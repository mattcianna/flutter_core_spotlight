# flutter_core_spotlight

Flutter plugin used for indexing items in Spotlight search on iOS.

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
