
# csbuttons

A Flutter package that provides custom animated button widgets for interactive UI elements. 

This package offers customizable buttons with heart animations, particle effects, and scaling animations, perfect for adding engaging interactions to your Flutter applications.

## Features

- **CSButton**: A button that triggers a particle explosion effect and a scaling animation when tapped. Ideal for buttons that need extra visual feedback.
- **CSHeartButton**: A customizable heart animation button that shows floating hearts when double-tapped. Perfect for like or love interactions.
- Customizable icon size, color, and animation properties.
- Easily integratable into any Flutter app.

### Installation

Add `csbuttons` to your `pubspec.yaml` file:

```yaml
dependencies:
  csbuttons: ^1.0.0 # Replace with the latest version
```

### Preview of CSButtons
https://github.com/user-attachments/assets/7ced0786-59fd-438e-b177-32d167ca9efc

https://github.com/user-attachments/assets/d3dfe5ae-6285-4a93-8e43-42e73889ad44

### Preview of CSHeartButton
https://github.com/user-attachments/assets/e9ec1b4b-6adb-441b-b9f9-64ef93d2eb9c



### CSButton example

```dart
```dart
class MyApp extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            home: Scaffold(
                appBar: AppBar(title: Text("CSButton Example")),
                body: Center(
                    child: CSButton(
                        icon: Icons.favorite,
                        iconSize: 60.0,
                        color: Colors.red,
                        onTap: () {
                            print("CSButton tapped!");
                        },
                    ),
                ),
            ),
        );
    }
}
```
```
### CSHeartButton example

```dart
class MyApp extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            home: Scaffold(
                appBar: AppBar(title: Text("CSHeartButton Example")),
                body: Center(
                    child: CSHeartButton(
                        child: Text('CSHeartButton'),
                    ),
                ),
            ),
        );
    }
}
```
