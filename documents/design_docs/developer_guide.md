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

## Server (back end)

The server stores the game information, and processes data from the players (users).

The high-level class is "GameRoom". This is what is stored by the memory store. This stores the "Player" information and "Game" information. The other classes in turn will ultimately be either properties of that class object, or properties of objects that are part of the GameRoom object.

The main file that is run is "main.py". This file is very simply, simply storing the CORS info, as well as the routers. The routers are the functions called when certain URLs are called using the API. They are all stored in the "routers" folder

### routers

There are several files in the "routers" folder that 

## Interaction