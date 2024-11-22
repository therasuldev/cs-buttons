
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
  csbuttons: ^0.1.1 # Replace with the latest version
```

### Preview of CSButtons

<img width="200" height="250" alt="screen" src="https://github.com/user-attachments/assets/615c04a4-cb70-46ed-8ea7-0c7327ddabf0">
<img width="200" height="250" alt="screen" src="https://github.com/user-attachments/assets/ca38f831-ade6-4bfa-a246-e03f051fb8b4">


### Preview of CSHeartButton

<img width="350" height="400" alt="screen" src="https://github.com/user-attachments/assets/951749a3-8b38-4ebc-9d35-5e5fc83ca9cd">


### CSButton example

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
                        child: Text('Double tap the screen'),
                    ),
                ),
            ),
        );
    }
}
```
