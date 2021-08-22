part of 'public_user_info_bloc.dart';

abstract class PublicUserInfoState extends Equatable {
  const PublicUserInfoState();

  @override
  List<Object> get props => [];
}

class PublicUserInfoInitial extends PublicUserInfoState {}

class PublicUserInfoLoaded extends PublicUserInfoState {
  final List<PublicUserInfo> infos;

  const PublicUserInfoLoaded(this.infos);

  @override
  List<Object> get props => [infos];
}

class PublicUserInfoFiltered extends PublicUserInfoLoaded {
  const PublicUserInfoFiltered(List<PublicUserInfo> infos) : super(infos);
}
