import express from "express";
import path from "path";
import fs from "fs";
import { execSync } from "child_process";
import { GoogleGenAI } from "@google/genai";
import dotenv from "dotenv";

dotenv.config();

// Lazy initialization of GoogleGenAI client to avoid startup warnings when API key is not set
let aiClient: GoogleGenAI | null = null;
function getGeminiClient(): GoogleGenAI | null {
  const apiKey = process.env.GEMINI_API_KEY || process.env.GOOGLE_API_KEY;
  if (!apiKey) return null;
  if (!aiClient) {
    aiClient = new GoogleGenAI({
      apiKey: apiKey,
      httpOptions: {
        headers: {
          'User-Agent': 'aistudio-build',
        }
      }
    });
  }
  return aiClient;
}

const SYSTEM_INSTRUCTION = `
You are the AXN Smart City AI Co-Pilot (المساعد الذكي), a highly polished, helpful, and interactive smart assistant designed exclusively for the Prince Al Hussein Stadium and Jordan exploration app.

Your primary capabilities:
1. HELP PLANNING EVENINGS:
   - Suggest fantastic itineraries, dinners, cafes, and scenic sunset/night spots in Jordan.
   - Recommend trying traditional Jordan food: Mansaf (منسف), Knafeh (كنافة) from Habibah in Amman downtown, mixed grills, and traditional mint tea or cardamom coffee.
   - Recommend places in Amman (Rainbow Street, Weibdeh, Citadel at sunset), Salt (historic streets, Al-Khader church, scenic viewpoints), or Aqaba.

2. HELP WITH THE STADIUM (Prince Al Hussein Stadium):
   - Provide smart guidance on crowd density (Gate 1 is currently crowded/moderate with ~17k visitors; Gate 3 is extremely clear and recommended for fast exits).
   - Help find parking: Zone B Slot 42 is the user's active synchronized parking spot, best reached via Sector C exits.
   - Suggest facilities: Mention "Al-Waha Rooftop Cafe" (مقهى الواحة العلوي) for a beautiful stadium view and cardamom coffee, or nearby rest stops.
   - Stadium capacity is 25,000; active visitors count is around 17,842 (71.4% occupancy).

3. PLACES TO VISIT IN JORDAN:
   - Recommend world-famous sites in Jordan with great cultural depth:
     * Petra: The rose-red Nabataean city, Treasury, Monastery, and Petra by Night experience.
     * Wadi Rum: The Valley of the Moon, stargazing, Bedouin bubble camps, jeep safaris, Martian-like red deserts.
     * Dead Sea: Floating in hypersaline water, therapeutic black mud, lowest point on Earth.
     * Jerash: Beautifully preserved ancient Roman ruins, theaters, and temples.
     * Ajloun: Lush green oak forests and the 12th-century Ajloun Castle.
     * Aqaba: Pristine Red Sea diving, coral reefs, and warm coastal vibes.
     * Amman Citadel & Roman Theater: Splendid panoramic viewpoints overlooking the ancient hills of the capital.

4. STRICT DOMAIN BOUNDARY & OFF-TOPIC REFUSAL (CRITICAL RULE):
   - You are exclusively the Prince Al Hussein Stadium & Jordan Exploration AI Co-Pilot.
   - You MUST STRICTLY REFUSE and ignore any questions that are NOT about Prince Al Hussein Stadium, stadium facilities, gates, parking, matchday experience, or Jordan tourism/evening planning.
   - If the user asks about general AI ("how AI works", "what model are you", etc.), coding, programming, mathematics, general science, politics, general trivia, or any off-topic subject, you MUST politely decline to answer.
   - Example English refusal: "Ahlan! As your AXN Smart City Co-Pilot, I specialize exclusively in Prince Al Hussein Stadium guidance, matchday facilities, parking, and Jordan exploration itineraries. I cannot answer general topics like how AI works. How can I assist with your stadium visit or Jordan evening plans today?"
   - Example Arabic refusal (عربي): "أهلاً بك! بصفتي مساعدك الذكي في مدينة عمرة واستاد الأمير الحسين، يقتصر تخصصي حصراً على مرافق الاستاد، البوابات، المواقف، وجولات وأمسيات الأردن. أعتذر عن الإجابة على المواضيع العامة خارج هذا التخصص. كيف يمكنني مساعدتك في رحلتك بالاستاد أو تخطيط أمسيتك اليوم؟"

TONE & BEHAVIOR:
- Respond in the language of the user's message. If they write in Arabic, respond in clear, hospitable, and friendly Arabic (عربي). If they write in English, write in warm, elegant English.
- Always be incredibly welcoming, professional, and smart. Keep your formatting highly structured using clean markdown, bullet points, and short readable paragraphs to look perfect in a mobile screen chat.
- Since you are integrated into a real mobile app, make recommendations feel real-time and context-aware.
`;

async function startServer() {
  const app = express();
  const PORT = 3000;

  // Middleware to parse JSON
  app.use(express.json());

  // CORS Middleware to allow requests from the Flutter client (both local and web previews)
  app.use((req, res, next) => {
    res.setHeader("Access-Control-Allow-Origin", "*");
    res.setHeader("Access-Control-Allow-Methods", "GET, POST, OPTIONS, PUT, PATCH, DELETE");
    res.setHeader("Access-Control-Allow-Headers", "Content-Type, Authorization");
    if (req.method === "OPTIONS") {
      return res.sendStatus(200);
    }
    next();
  });

  // Health check endpoint
  app.get("/api/health", (req, res) => {
    res.json({
      status: "healthy",
      api_key_configured: !!(process.env.GEMINI_API_KEY || process.env.GOOGLE_API_KEY || process.env.GROQ_API_KEY)
    });
  });

  // Download Single Standalone HTML bundle endpoint
  app.get("/api/download-html", (req, res) => {
    const distHtml = path.join(process.cwd(), 'dist', 'index.html');
    if (fs.existsSync(distHtml)) {
      res.setHeader("Content-Type", "text/html; charset=utf-8");
      res.setHeader("Content-Disposition", 'attachment; filename="axn_smart_city_app.html"');
      return res.sendFile(distHtml);
    }
    return res.status(404).json({
      error: "No built frontend was found. Please build the static frontend into the 'dist' folder first."
    });
  });

  // AI Planner Chat proxy endpoint
  app.post("/api/chat", async (req, res) => {
    const { message, history } = req.body;

    if (!message || typeof message !== "string") {
      return res.status(400).json({ error: "Invalid request. 'message' string is required." });
    }

    const groqKey = (req.headers['x-groq-api-key'] as string) || process.env.GROQ_API_KEY;
    if (groqKey) {
      try {
        const groqMessages: any[] = [{ role: 'system', content: SYSTEM_INSTRUCTION }];
        if (history && Array.isArray(history)) {
          for (const turn of history) {
            if (turn.role === "user" || turn.role === "model") {
              groqMessages.push({
                role: turn.role === "model" ? "assistant" : "user",
                content: turn.text
              });
            }
          }
        }
        groqMessages.push({ role: "user", content: message });

        const groqRes = await fetch("https://api.groq.com/openai/v1/chat/completions", {
          method: "POST",
          headers: {
            "Authorization": `Bearer ${groqKey}`,
            "Content-Type": "application/json"
          },
          body: JSON.stringify({
            model: "allam-2-7b",
            messages: groqMessages,
            temperature: 0.7
          })
        });

        if (groqRes.ok) {
          const data = await groqRes.json();
          const botText = data?.choices?.[0]?.message?.content;
          if (botText) {
            return res.json({ text: botText });
          }
        }
      } catch (e) {
        console.warn("Groq server-side fallback error:", e);
      }
    }

    const ai = getGeminiClient();
    if (!ai) {
      // Return a smart fallback if key is missing
      return res.json({
        text: `Ahlan! Your AXN Smart City co-pilot is here. You asked: "${message}". For the stadium, Gate 3 is clear! For Jordan, Jerash and Petra are outstanding!`
      });
    }

    try {
      // Map history to Google Gen AI format if present
      const formattedContents: any[] = [];
      
      if (history && Array.isArray(history)) {
        for (const turn of history) {
          if (turn.role === "user" || turn.role === "model") {
            formattedContents.push({
              role: turn.role === "model" ? "assistant" : "user",
              parts: [{ text: turn.text }]
            });
          }
        }
      }

      // Add the active user prompt at the end
      formattedContents.push({
        role: "user",
        parts: [{ text: message }]
      });

      // Call the recommended Gemini model
      const response = await ai.models.generateContent({
        model: "gemini-3.5-flash",
        contents: formattedContents,
        config: {
          systemInstruction: SYSTEM_INSTRUCTION,
          temperature: 0.7,
        },
      });

      res.json({ text: response.text ?? '' });
    } catch (error: any) {
      console.error("Gemini API Error:", error);
      res.status(500).json({ error: "Failed to generate AI response. Please try again.", details: error.message });
    }
  });

  // Optionally serve a static frontend bundle if present.
  const distPath = path.join(process.cwd(), 'dist');
  if (fs.existsSync(distPath)) {
    app.use(express.static(distPath));
    app.get('*', (req, res) => {
      res.sendFile(path.join(distPath, 'index.html'));
    });
  }

  app.listen(PORT, "0.0.0.0", () => {
    console.log(`Server running on http://0.0.0.0:${PORT}`);
  });
}

startServer();
