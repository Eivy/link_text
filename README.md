# link_text

Flutter package for Text widget contains link.

## Sample

```dart
import 'package:flutter/material.dart';
import 'package:link_text/link_text.dart';

void main() => runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: Text('LinkText Sample')),
      body: LinkText("some text including link like 'https://www.google.com'"),
    ),
  ));

```

## Result
![result](./result.png)
