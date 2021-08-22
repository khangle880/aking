part of 'public_user_info_bloc.dart';

abstract class PublicUserInfoEvent extends Equatable {
  const PublicUserInfoEvent();

  @override
  List<Object> get props => [];
}

class LoadPublicUsersInfo extends PublicUserInfoEvent {}

class UpdateUsersInfo extends PublicUserInfoEvent {
  final List<PublicUserInfo> infos;

  const UpdateUsersInfo(this.infos);

  @override
  List<Object> get props => [infos];
}

class FindByText extends PublicUserInfoEvent {
  final String findKey;

  const FindByText(this.findKey);

  @override
  List<Object> get props => [findKey];
}
