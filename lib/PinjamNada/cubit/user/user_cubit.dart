import 'package:flutter/widgets.dart';
// import 'package:my_app/PinjamNada/dto/user.dart';
// import 'package:my_app/services/data_service.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(const UserInitialState());

  void login(String roles, int userID, String username) {
    emit(UserState(
      roles: roles,
      userID: userID,
      username: username,
    ));
  }

  void updateProfile({
    String? email,
    String? full_name,
    String? phone,
    String? profile_picture,
  }) {
    if (state is UserState) {
      emit((state as UserState).copyWith(
        email: email,
        full_name: full_name,
        phone: phone,
        profile_picture: profile_picture,
      ));
    }
  }

  int get userID {
    return state.userID;
  }
}
