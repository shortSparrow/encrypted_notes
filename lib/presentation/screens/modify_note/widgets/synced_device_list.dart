import 'package:encrypted_notes/presentation/screens/modify_note/widgets/synced_device_item.dart';
import 'package:flutter/material.dart';

class SyncedDeviceUI {
  final IconData icon;
  final String name;
  final bool shouldSync;

  SyncedDeviceUI({
    required this.icon,
    required this.name,
    required this.shouldSync,
  });
}

class SyncedDeviceList extends StatelessWidget {
  const SyncedDeviceList({super.key});

  @override
  Widget build(BuildContext context) {
    final syncedDevices = [
      SyncedDeviceUI(
        icon: Icons.laptop_mac,
        name: "mac book 16 pro",
        shouldSync: true,
      ),
      SyncedDeviceUI(
        icon: Icons.smartphone,
        name: "Xiaomi redmi note 4x",
        shouldSync: true,
      ),
      SyncedDeviceUI(
        icon: Icons.smartphone,
        name: "Xiaomi redmi note 4x",
        shouldSync: true,
      ),
      SyncedDeviceUI(
        icon: Icons.smartphone,
        name: "Xiaomi redmi note 4x",
        shouldSync: true,
      ),
      SyncedDeviceUI(
        icon: Icons.smartphone,
        name: "Xiaomi redmi note 4x",
        shouldSync: true,
      ),
    ];

    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: syncedDevices.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: SyncedDeviceItem(
            deviceIcon: syncedDevices[index].icon,
            deviceName: syncedDevices[index].name,
            shouldSync: syncedDevices[index].shouldSync,
            onToggleShouldSync: (bool value) {},
          ),
        );
      },
    );
  }
}
