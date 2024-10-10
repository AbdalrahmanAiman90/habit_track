import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:habit_track/feature/Auth/data/auth_operation.dart';
import 'package:habit_track/service/firebase_service.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  AuthOperation auth = AuthOperation(); //register and login
  FirebaseService firebaseService = FirebaseService(); //set date in firebase

  //!register
  Future<void> register(
      {required String emial,
      required String password,
      required String name}) async {
    emit(AuthLoading());
    try {
      var result = await auth.register(emial, password);
      if (result == "succses") {
        String idUser = firebaseService.getFirebaseUserId();
        await setAuthUserData(email: emial, name: name, id: idUser);
        emit(AuthRegisterSucsses());
      } else {
        emit(AuthFaileRegister(errorMassage: result));
      }
    } on Exception catch (e) {
      emit(AuthFaileRegister(errorMassage: e.toString()));
    }
  }

  //!login
  Future<void> logIN({required String emial, required String password}) async {
    emit(AuthLoading());
    try {
      var result = await auth.signIn(emial, password);
      if (result == "succses") {
        emit(AuthLogInSucsses());
      } else {
        emit(AuthFaileLogin(errorMassage: result));
      }
    } on Exception catch (e) {
      emit(AuthFaileLogin(errorMassage: e.toString()));
    }
  }

//!set user data
  Future<void> setAuthUserData(
      {required String email, required String name, required String id}) async {
    try {
      var userData = {
        'email': email,
        'name': name,
        "id": id,
      };

      await firebaseService.setData(
          collection: 'user_info', data: userData, documentId: id);
    } catch (e) {
      log('Error storing user data: $e');
    }
  }
//logout
  Future<void> logOut() async {
    try {
      await auth.signOut();
      emit(AuthInitial()); // Emit an initial state or a logout success state
    } catch (e) {
      log('Error logging out: $e');
      // You can emit a failure state if needed
    }
  }

  @override
  void onChange(Change<AuthState> change) {
    // TODO: implement onChange
    log(change.toString());
    super.onChange(change);
  }

  void updateAccount({required String name, required String email, required String password}) {}
}
