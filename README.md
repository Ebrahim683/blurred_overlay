# blurred_overlay

A lightweight Flutter package to show beautiful blurred dialogs and modal bottom sheets with shadow, radius, and customization.


## ✨ Features

- Blur effect using `BackdropFilter`
- Customizable border radius, padding, and margin
- Optional box shadow
- Works with both dialogs and bottom sheets

  
## 🖼️ Screenshots

<table border="0">
  <tr>
    <td align="center">
      <img src="https://i.ibb.co.com/3y7cSJKg/bottom-sheet.jpg" alt="bottom-sheet" border="0" width="300"/><br/>
      <sub><b>Blurred BottomSheet</b></sub>
    </td>
    <td align="center">
      <img src="https://i.ibb.co.com/ZzhMK0jy/dialog.jpg" alt="dialog" border="0" width="300"/><br/>
      <sub><b>Blurred Dialog</b></sub>
    </td>
  </tr>
</table>


## 🚀 Quick Start
Installation

Add dependency into your pubspec.yaml
```yaml
dependencies:
  blurred_overlay: ^1.0.0
```
Then run
```shell
flutter pub get
```

Or use the command line
```shell
flutter pub add blurred_overlay
```

## 📱 Basic Usage
Blurred BottomSheet
```dart
showBlurredModalBottomSheet(
  context: context,
  showHandle: true,
  builder: (context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            'System Information',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        const Divider(color: Colors.white24, indent: 20, endIndent: 20),
        const ListTile(
          dense: true,
          leading: Icon(Icons.devices, size: 20),
          title: Text('Device Name', style: TextStyle(fontSize: 14)),
          trailing: Text('Galaxy A50', style: TextStyle(fontSize: 12)),
        ),
        const ListTile(
          dense: true,
          leading: Icon(Icons.memory, size: 20),
          title: Text('RAM', style: TextStyle(fontSize: 14)),
          trailing: Text('12 GB', style: TextStyle(fontSize: 12)),
        ),
        const ListTile(
          dense: true,
          leading: Icon(Icons.sd_storage, size: 20),
          title: Text('ROM', style: TextStyle(fontSize: 14)),
          trailing: Text('256 GB', style: TextStyle(fontSize: 12)),
        ),
        const SizedBox(height: 10),
        const Center(
          child: Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Text(
              "Blurred BottomSheet",
              style: TextStyle(fontSize: 13, color: Colors.grey),
            ),
          ),
        ),
      ],
    );
  },
);
```

Bludder Dialog
```dart
showBlurredDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text(
                  'Root Status',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16.0),
                const Text(
                  'Your phone Galaxy A50 is not rooted.',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 16.0),
                ),
                const SizedBox(height: 24.0),
                Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                    },
                    child: const Text('CLOSE'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
```