import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:gamaapp/shared/widgets/square_line.dart';
import 'package:get/get.dart';

import '../../../../shared/themes/images.dart';
import '../../../../shared/themes/palette.dart';
import '../../domain/entities/profile_info.dart';
import '../controllers/profile_controller.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProfileInfo? profileInfo = controller.profile;

    return Scaffold(
      appBar: AppBar(
        title: Text(profileInfo?.fullname ?? ""),
        centerTitle: true,
        backgroundColor: Palette.primary,
        foregroundColor: Palette.white,
      ),
      body: ListView(
        children: [
          Container(
            color: Palette.primary,
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: Center(
              child: Image.asset(
                Images.logoPNG,
                height: 104,
                width: 104,
              ),
            ),
          ),
          const SquaresLines(),
          const SizedBox(height: 8),
          ListTile(
            leading: const Icon(PhosphorIcons.user),
            title: Text(profileInfo?.username ?? ""),
          ),
          const Divider(color: Palette.lightGrey),
          ListTile(
            leading: const Icon(PhosphorIcons.envelope),
            title: Text(profileInfo?.email ?? ""),
          ),
          const Divider(color: Palette.lightGrey),
          ListTile(
            leading: const Icon(PhosphorIcons.shield),
            title: Text(controller.roleName ?? ""),
          ),
          const Divider(color: Palette.lightGrey),
        ],
      ),
    );
  }
}
