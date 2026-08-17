import 'package:flutter/material.dart';

enum GroupType { family, group }

enum VerificationStatus { national, phone, none }

class GroupMember {
  final String name;
  final String initials;
  final Color color;
  final String role;
  final VerificationStatus verified;
  final bool live;
  final String? lastSeen;

  const GroupMember({
    required this.name,
    required this.initials,
    required this.color,
    required this.role,
    required this.verified,
    required this.live,
    this.lastSeen,
  });
}

class GroupData {
  final String id;
  final String name;
  final GroupType type;
  final List<GroupMember> members;
  final bool consentGranted;

  const GroupData({
    required this.id,
    required this.name,
    required this.type,
    required this.members,
    this.consentGranted = false,
  });
}

const List<GroupData> demoGroups = [
  GroupData(
    id: 'al-amins',
    name: 'The Al-Amins',
    type: GroupType.family,
    consentGranted: true,
    members: [
      GroupMember(
        name: 'Sara Amin',
        initials: 'SA',
        color: Color(0xFFCFE8DE),
        role: 'Admin (You)',
        verified: VerificationStatus.national,
        live: true,
      ),
      GroupMember(
        name: 'Rami Amin',
        initials: 'RM',
        color: Color(0xFFD9D3F2),
        role: 'Member',
        verified: VerificationStatus.national,
        live: true,
      ),
      GroupMember(
        name: 'Lina Amin',
        initials: 'LA',
        color: Color(0xFFF7E3C4),
        role: 'Member (Child)',
        verified: VerificationStatus.national,
        live: false,
        lastSeen: '12 min ago',
      ),
    ],
  ),
  GroupData(
    id: 'petra-weekend',
    name: 'Petra weekend',
    type: GroupType.group,
    members: [
      GroupMember(
        name: 'Sami Adel',
        initials: 'SA',
        color: Color(0xFFE4EFFC),
        role: 'Admin',
        verified: VerificationStatus.phone,
        live: true,
      ),
      GroupMember(
        name: 'Huda Kamal',
        initials: 'HK',
        color: Color(0xFFFCE3E9),
        role: 'Member',
        verified: VerificationStatus.phone,
        live: true,
      ),
      GroupMember(
        name: 'Omar Naser',
        initials: 'ON',
        color: Color(0xFFE3F6F3),
        role: 'Member',
        verified: VerificationStatus.phone,
        live: false,
        lastSeen: '1h ago',
      ),
    ],
  ),
];
