import 'package:flutter/material.dart';

class SyncedDeviceItem extends StatelessWidget {
  final IconData deviceIcon;
  final String deviceName;
  final bool shouldSync;
  final Function(bool value) onToggleShouldSync;

  const SyncedDeviceItem({
    super.key,
    required this.deviceIcon,
    required this.deviceName,
    required this.shouldSync,
    required this.onToggleShouldSync,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(deviceIcon, size: 40.0),
        const SizedBox(width: 15),
        Expanded(
          child: Text(
            deviceName
            // deviceName + deviceName + deviceName + deviceName+deviceName + deviceName + deviceName + deviceName,
          ),
        ),
        const SizedBox(width: 15),
        Checkbox(
          value: shouldSync,
          onChanged: (value) {
            onToggleShouldSync(value ?? false);
          },
        ),
      ],
    );
  }
}
