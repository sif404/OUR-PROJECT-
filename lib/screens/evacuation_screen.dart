import 'package:flutter/material.dart';
import '../models/app_scope.dart';

class EvacuationScreen extends StatefulWidget {
  final VoidCallback? onExitEvacuation;

  const EvacuationScreen({super.key, this.onExitEvacuation});

  @override
  State<EvacuationScreen> createState() => _EvacuationScreenState();
}

class _EvacuationScreenState extends State<EvacuationScreen> {
  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness != Brightness.dark;
    final bg = isLight ? const Color(0xFFF7F6F2) : const Color(0xFF121212);
    final textColor = isLight ? const Color(0xFF111111) : Colors.white;
    final subTextColor = isLight ? const Color(0xFF6E6E6E) : Colors.white70;

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: bg,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close, color: textColor),
          onPressed: () {
            widget.onExitEvacuation?.call();
            Navigator.of(context).maybePop();
          },
        ),
        title: Text(
          AppScope.of(context).t('evac_title'),
          style: TextStyle(
            color: textColor,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: isLight ? Colors.white : const Color(0xFF141B2E),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isLight
                        ? const Color(0xFFE7E2DA)
                        : Colors.white.withOpacity(0.1),
                  ),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.directions_run_rounded,
                      size: 64,
                      color: isLight ? const Color(0xFFCE1126) : const Color(0xFFE63946),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      AppScope.of(context).t('evac_heading'),
                      style: TextStyle(
                        color: textColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      AppScope.of(context).t('evac_instructions'),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: subTextColor,
                        fontSize: 14,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isLight
                      ? const Color(0xFFF9E2E5)
                      : const Color(0xFF2A1A1C),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info_outline,
                        color: isLight
                            ? const Color(0xFFCE1126)
                            : const Color(0xFFE63946)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        AppScope.of(context).t('evac_disclaimer'),
                        style: TextStyle(
                          color: isLight
                              ? const Color(0xFFCE1126)
                              : const Color(0xFFE63946),
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: Material(
                  color: isLight ? const Color(0xFFCE1126) : const Color(0xFFE63946),
                  borderRadius: BorderRadius.circular(12),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      widget.onExitEvacuation?.call();
                      Navigator.of(context).maybePop();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Center(
                        child: Text(
                          AppScope.of(context).t('evac_exitButton'),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
