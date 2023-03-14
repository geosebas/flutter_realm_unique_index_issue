# flutter_realm_unique_index_issue

Flutter project to reproduce a race issue with realm. 

See more info here : [Github issue](https://github.com/realm/realm-dart/issues/1209)


Steps to reproduce : 
- execute : `flutter pub get`
- execute : `flutter packages pub run build_runner build` 
- use your own app id in main.dart
- add schema on atlas (you can find it in event.dart)
- create an unique compound index (see [this file](create_index_screenshot.png))
- start app with `flutter run` and click on the add button


So far, I managed to reproduce each times I tried