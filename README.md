# flutter_core_spotlight

Flutter plugin used for indexing items in Spotlight search on iOS.

<img src="https://user-images.githubusercontent.com/10003040/124283078-c8a1a900-db4b-11eb-909a-9c6c8c611095.png" alt="Example Screenshot" width="200"/>

Note: This plugin only works on iOS.

## Getting Started

Add flutter_core_spotlight as a [dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/).

Check out the example directory for a sample app.

## Usage

Import the library via

```dart
import 'package:flutter_core_spotlight/flutter_core_spotlight.dart';
```

Example:

```dart
// Indexing a searchable item
FlutterCoreSpotlight.instance.indexSearchableItems([
    FlutterSpotlightItem(
        uniqueIdentifier: 'ExampleUniqueIdentifier',
        domainIdentifier: 'com.example.flutter_spotlight_plugin',
        attributeTitle: 'Item Title',
        attributeDescription: 'This is an item description',
    )
]);

// Deleting a searchable item
FlutterCoreSpotlight.instance.deleteSearchableItems([
    'ExampleUniqueIdentifier',
]);

// Callback on searchable item selected
FlutterCoreSpotlight.instance.configure(
    onSearchableItemSelected: (userActivity) {
        print(userActivity?.uniqueIdentifier);
        print(userActivity?.userInfo);
    },
);
```
