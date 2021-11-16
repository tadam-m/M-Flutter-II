# Techno immer das Gleiche

# How to use

Start the development server :

```sh
cd Server && npm install && npm start
```

Install flutter packages with `flutter pub get`.

Run the application with `flutter run`.

If you want to use another server address, change the address in
`lib/API/api_manager.dart`.

# Testing

Run unit and widget test with `flutter test`.

Run integration test with :

```sh
flutter drive \
    --driver=test_driver/integration_test.dart \
    --target=integration_test/test_all_test.dart
```

# Bonus

Full CI that analyse and test the project.

A live server is deployed on Heroku, at the address
`https://gehensiezumclub.herokuapp.com/api/gehenSiezumClub`.
