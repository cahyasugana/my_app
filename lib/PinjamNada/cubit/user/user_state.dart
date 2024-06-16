part of 'user_cubit.dart';

@immutable
class UserState {
  final String roles;
  final int userID;
  final String username;
  final String? email;
  final String? full_name;
  final String? phone;
  final String? profile_picture;

  const UserState({
    required this.roles,
    required this.userID,
    required this.username,
    this.email,
    this.full_name,
    this.phone,
    this.profile_picture,
  });

  UserState copyWith({
    String? roles,
    int? userID,
    String? username,
    String? email,
    String? full_name,
    String? phone,
    String? profile_picture,
  }) {
    return UserState(
      roles: roles ?? this.roles,
      userID: userID ?? this.userID,
      username: username ?? this.username,
      email: email ?? this.email,
      full_name: full_name ?? this.full_name,
      phone: phone ?? this.phone,
      profile_picture: profile_picture ?? this.profile_picture,
    );
  }
}

class UserInitialState extends UserState {
  const UserInitialState()
      : super(
            roles: '',
            userID: 0,
            username: '',
            email: null,
            full_name: null,
            phone: null,
            profile_picture: null);
}
