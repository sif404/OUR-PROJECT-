import 'package:flutter/material.dart';

import '../models/app_scope.dart';
import '../models/groups.dart';
import '../models/groups_scope.dart';
import '../routes.dart';
import '../theme/app_colors.dart';
import '../widgets/app_field.dart';
import '../widgets/buttons.dart';
import '../widgets/otp_row.dart';
import '../widgets/screen_chrome.dart';

class CreateGroupFlowScreen extends StatefulWidget {
  const CreateGroupFlowScreen({super.key, required this.groups});

  final GroupsController groups;

  @override
  State<CreateGroupFlowScreen> createState() => _CreateGroupFlowScreenState();
}

class _CreateGroupFlowScreenState extends State<CreateGroupFlowScreen> {
  GroupType? _type;
  int _stepIndex = 0;

  final TextEditingController _phone = TextEditingController();
  final TextEditingController _nationalId = TextEditingController();

  @override
  void dispose() {
    _phone.dispose();
    _nationalId.dispose();
    super.dispose();
  }

  void _back() {
    if (_stepIndex == 0) {
      Navigator.of(context).maybePop();
      return;
    }
    setState(() => _stepIndex -= 1);
  }

  Future<void> _selectType(GroupType type) async {
    if (_type == type && _stepIndex > 0) return;

    if (type == GroupType.family) {
      final accepted = await Navigator.of(context).pushNamed<bool>(Routes.familyConsent);
      if (accepted != true) return;
    }

    setState(() {
      _type = type;
      _stepIndex = 1;
    });
  }

  void _nextFromPhone() {
    if (_type == null) return;
    setState(() => _stepIndex = 2);
  }

  void _nextFromId() {
    if (_type == null) return;
    setState(() => _stepIndex = 3);
  }

  void _finish() {
    final type = _type;
    if (type == null) return;

    final id = widget.groups.nextGroupId(type: type);
    final group = GroupData(
      id: id,
      name: type == GroupType.family ? AppScope.of(context).t('createGroup_defaultFamilyName') : AppScope.of(context).t('createGroup_defaultGroupName'),
      type: type,
      members: const [],
      consentGranted: type == GroupType.family,
    );

    widget.groups.addGroup(group);
    Navigator.of(context).pop(group);
  }

  @override
  Widget build(BuildContext context) {
    return switch (_stepIndex) {
      0 => _buildType(),
      1 => _buildPhone(),
      2 => _buildNationalId(),
      _ => _buildOtp(),
    };
  }

  Widget _buildType() {
    return StandardScreenScaffold(
      onBack: _back,
      activeStep: 0,
      totalSteps: 4,
      bodyChildren: [
        const SizedBox(height: 6),
        Text(
          AppScope.of(context).t('createGroup_title'),
          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 10),
        Text(
          AppScope.of(context).t('createGroup_subtitle'),
          style: TextStyle(fontSize: 14, color: AppColors.textS(context)),
        ),
        const SizedBox(height: 18),
        _TypeTile(
          title: AppScope.of(context).t('createGroup_familyTitle'),
          subtitle: AppScope.of(context).t('createGroup_familySubtitle'),
          onTap: () => _selectType(GroupType.family),
        ),
        const SizedBox(height: 12),
        _TypeTile(
          title: AppScope.of(context).t('createGroup_groupTitle'),
          subtitle: AppScope.of(context).t('createGroup_groupSubtitle'),
          onTap: () => _selectType(GroupType.group),
        ),
      ],
      bottomChildren: const [],
    );
  }

  Widget _buildPhone() {
    return StandardScreenScaffold(
      onBack: _back,
      activeStep: 1,
      totalSteps: 4,
      bodyChildren: [
        Text(
          AppScope.of(context).t('createGroup_phoneTitle'),
          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 10),
        AppField(
          label: AppScope.of(context).t('createGroup_mobileLabel'),
          placeholder: AppScope.of(context).t('createGroup_mobilePlaceholder'),
          mono: true,
          controller: _phone,
        ),
      ],
      bottomChildren: [
        PrimaryButton(
          label: AppScope.of(context).t('btnContinue'),
          onTap: _nextFromPhone,
        ),
      ],
    );
  }

  Widget _buildNationalId() {
    return StandardScreenScaffold(
      onBack: _back,
      activeStep: 2,
      totalSteps: 4,
      bodyChildren: [
        Text(
          AppScope.of(context).t('createGroup_nationalIdTitle'),
          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 10),
        AppField(
          label: AppScope.of(context).t('createGroup_nationalIdTitle'),
          placeholder: 'XXXXXXXXXX',
          mono: true,
          controller: _nationalId,
        ),
      ],
      bottomChildren: [
        PrimaryButton(
          label: AppScope.of(context).t('btnContinue'),
          onTap: _nextFromId,
        ),
      ],
    );
  }

  Widget _buildOtp() {
    return StandardScreenScaffold(
      onBack: _back,
      activeStep: 3,
      totalSteps: 4,
      bodyCrossAxisAlignment: CrossAxisAlignment.center,
      bodyChildren: [
        Text(
          AppScope.of(context).t('createGroup_otpTitle'),
          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          AppScope.of(context).t('createGroup_otpSubtitle'),
          style: TextStyle(fontSize: 14, color: AppColors.textS(context)),
          textAlign: TextAlign.center,
        ),
        const OtpRow(),
      ],
      bottomChildren: [
        PrimaryButton(
          label: AppScope.of(context).t('createGroup_finishButton'),
          onTap: _finish,
        ),
      ],
    );
  }
}

class _TypeTile extends StatelessWidget {
  const _TypeTile({required this.title, required this.subtitle, required this.onTap});

  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surf(context),
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.border(context), width: 1.2),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.textP(context))),
                    const SizedBox(height: 4),
                    Text(subtitle, style: TextStyle(fontSize: 13, color: AppColors.textS(context))),
                  ],
                ),
              ),
              Icon(Icons.chevron_right_rounded, color: AppColors.textS(context)),
            ],
          ),
        ),
      ),
    );
  }
}

