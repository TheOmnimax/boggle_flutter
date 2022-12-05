# Developer guide

## App (front end)

The app was developed using Flutter. It uses Firebase. It has components for storing login credentials, but there is currently no way to log in. It does use Firebase for hosting.

### lib

#### main.dart

This is the main file that is run when the app is opened. It uses an async to initialize Firebase, and then run the app.

When running the app, it is wrapped in a bloc provider for the app bloc (discussed [below](#bloc-app-bloc)).

It then runs a MaterialApp. Currently, since data is usually passed between screens, there is only one named route, the home screen.

#### bloc (app bloc)

This folder contains the app bloc, or bloc data that is shared between all screens.

In addition to login data (which isn't actually currently used, but kept in case it will be added later)
