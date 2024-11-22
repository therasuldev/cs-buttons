
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

![cs-buttons](https://github.com/user-attachments/assets/7af16aae-78a1-4d0f-962f-c4aa212df9cc)
![cs-buttons](https://github.com/user-attachments/assets/faf0979d-cf93-4082-8e69-f88473d93719)

### Preview of CSHeartButton

![ezgif-3-67edc78494](https://github.com/user-attachments/assets/283197b5-f894-4cda-bb95-82aa206d0d23)



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
