import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:boggle_flutter/bloc/bloc.dart';
import 'package:boggle_flutter/constants/constants.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc()
      : super(
          const AppState(
            username: '',
          ),
        ) {
    on<AppOpened>(_appOpened);
    on<Login>(_login);
    on<Logout>(_logout);
    on<Register>(_register);
    on<LoginError>(_loginError);
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> get authToken async {
    final user = _auth.currentUser;
    final token = await user?.getIdToken() ?? '';
    return token;
  }

  Future _appOpened(AppOpened event, Emitter<AppState> emit) async {
    final currentUser = _auth.currentUser;
    final username = currentUser?.email ?? '';
    emit(AppState(
      username: username,
    ));
  }

  LoginResult? checkCredentials({
    required String username,
    required String password,
    String? password2,
  }) {
    // Check the credentials given, and see if they are good enough to log in or register with
    if (username == '') {
      return LoginResult.missingEmail;
    } else if (!RegExp(kEmailRegex).hasMatch(username)) {
      return LoginResult.invalidEmail;
    } else if (password == '') {
      return LoginResult.missingPassword;
    } else if (password2 == '') {
      return LoginResult.missingReenter;
    } else if ((password2 != null) && (password != password2)) {
      return LoginResult.passwordMismatch;
    } else {
      return null;
    }
  }

  Map<String, dynamic> analyzeLoginError(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        {
          return <String, dynamic>{
            'loginResult': LoginResult.invalidEmail,
            'message': e.message,
          };
        }
      case 'account-exists-with-different-credential':
      case 'credential-already-in-use':
      case 'email-already-in-use':
        {
          return <String, dynamic>{
            'loginResult': LoginResult.usedUsername,
            // 'message': e.message,
          };
        }
      case 'user-not-found':
        {
          return <String, dynamic>{
            'loginResult': LoginResult.notFound,
            // 'message': e.message,
          };
        }
      case 'user-disabled':
        {
          return <String, dynamic>{
            'loginResult': LoginResult.disabled,
          };
        }
      case 'wrong-password':
        {
          return <String, dynamic>{
            'loginResult': LoginResult.wrongPassword,
            // 'message': e.message,
          };
        }
      case 'weak-password':
        {
          return <String, dynamic>{
            'loginResult': LoginResult.weakPassword,
            'message': e.message,
          };
        }
      case 'too-many-requests':
        {
          return <String, dynamic>{
            'loginResult': LoginResult.brute,
            // 'message': e.message,
          };
        }
      default:
        {
          print('Error:');
          print(e);
          return <String, dynamic>{
            'loginResult': LoginResult.unknownError,
            'message': e.message,
          };
        }
    }
  }

  Future _login(Login event, Emitter<AppState> emit) async {
    final credentialStatus = checkCredentials(
      username: event.username,
      password: event.password,
    );

    if (credentialStatus != null) {
      // If there is an issue with the credentials being entered
      emit(state.copyWith(loginStatus: credentialStatus));
      return;
    }

    try {
      await _auth.signInWithEmailAndPassword(
          email: event.username, password: event.password);
    } on FirebaseAuthException catch (e) {
      final loginErrorInfo = analyzeLoginError(e);
      if (loginErrorInfo.containsKey('message')) {
        emit(state.copyWith(
          loginStatus: loginErrorInfo['loginResult'] as LoginResult,
          loginDetails: loginErrorInfo['message'] as String,
        ));
      } else {
        emit(state.copyWith(
          loginStatus: loginErrorInfo['loginResult'] as LoginResult,
        ));
      }
      return;
    } catch (e) {
      emit(state.copyWith(
        loginStatus: LoginResult.unknownError,
        loginDetails: e.toString(),
      ));
      return;
    }

    emit(state.copyWith(
      username: event.username,
    ));
  }

  Future _logout(Logout event, Emitter<AppState> emit) async {
    await _auth.signOut();
    emit(state.copyWith(
      username: '',
    ));
  }

  Future _register(Register event, Emitter<AppState> emit) async {
    final credentialStatus = checkCredentials(
      username: event.username,
      password: event.password1,
      password2: event.password2,
    );

    if (credentialStatus != null) {
      // If there is an issue with the credentials being entered
      emit(state.copyWith(loginStatus: credentialStatus));
      return;
    }

    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
          email: event.username, password: event.password1);
      if (userCredential == null) {
        emit(state.copyWith(loginStatus: LoginResult.unknownError));
        return;
      }
    } on FirebaseAuthException catch (e) {
      final loginErrorInfo = analyzeLoginError(e);
      emit(state.copyWith(
        loginStatus: loginErrorInfo['loginResult'] as LoginResult,
        loginDetails: loginErrorInfo['message'] as String,
      ));
      return;
    } catch (e) {
      emit(state.copyWith(
        loginStatus: LoginResult.unknownError,
        loginDetails: e.toString(),
      ));
      return;
    }

    emit(state.copyWith(
      username: event.username,
    ));
  }

  void _loginError(LoginError event, Emitter<AppState> emit) {
    emit(state.copyWith(
      loginStatus: event.loginResult,
      loginDetails: event.loginDetails,
    ));
  }

// void _requestToken(RequestToken event, Emitter<AppState> emit) {}
}
