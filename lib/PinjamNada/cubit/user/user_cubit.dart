import 'package:flutter/widgets.dart';
// import 'package:my_app/PinjamNada/dto/user.dart';
import 'package:my_app/PinjamNada/services/data_service.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(const UserInitialState());

  void login(String roles, int userID, String username, String? email,
      String? full_name, String? phone, String? profile_picture) {
    emit(UserState(
      roles: roles,
      userID: userID,
      username: username,
      email: email,
      full_name: full_name,
      phone: phone,
      profile_picture: profile_picture,
    ));
  }

  Future<void> updateProfile({
    int? userID,
    String? email,
    String? full_name,
    String? phone,
    String? profile_picture,
  }) async {
    if (state is UserState) {
      emit((state as UserState).copyWith(
        email: email,
        full_name: full_name,
        phone: phone,
        profile_picture: profile_picture,
      ));
      try {
        final response =
            await DataService.updateUser(userID!, email, full_name, phone);
        if (response.statusCode == 200) {
          print(response.body);
        } else {
          print('Failed to update profile: ${response.statusCode}');
          // Tangani error sesuai kebutuhan aplikasi Anda
        }
      } catch (e) {
        print('Error updating profile: $e');
        // Tangani error sesuai kebutuhan aplikasi Anda
      }
    }
  }

  void logout() {
    emit(UserState(
        roles: '',
        userID: 0,
        username: '',
        email: null,
        full_name: null,
        phone: null,
        profile_picture: null));
  }

  int get userID {
    return state.userID;
  }

  String get roles {
    return state.roles;
  }
}
