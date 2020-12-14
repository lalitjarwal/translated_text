# translated_text

A wrapper to the [translator: ^0.1.5](https://pub.dev/packages/translator) package.

## *Note 
- It can be used to internationilize your app but not recommended for production. 

A ```TranslatedText()``` widget that displays text to choosen translated language. 

# Getting Started

Add this to your ```pubspec.yaml``` file.
```yaml 
   dependecies:
       translated_text: 'latest-version'
```
Import the package into your package.
```dart
import 'package:translated_text/translated_text.dart';
```

# Usage 
```dart  
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp( title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Material App Bar'),
        ),
        body: Center(
          child: Container(
            child: TranslatedText('I love Flutter',to:'hi'),
            // it will be printed in hindi.
          ),
        ),
      ),
    );
  }
}
```
## Bonus
- You can also use ```JumpingProgressIndicator()``` widget into your app.
# License
MIT License

Copyright © 2020 Lalit Jarwal

# Disclamer
This package is developed for educational purposes only. Do not depend on this package as it may break anytime as it is based on crawling the Google Translate website. Consider buying Official Google Translate API for other types of usage.