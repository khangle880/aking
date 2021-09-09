part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class NameOnChange extends ProfileEvent {
  final String name;
  const NameOnChange({
    required this.name,
  });

  @override
  List<Object> get props => [name];
}

class DescriptionOnChange extends ProfileEvent {
  final String description;
  const DescriptionOnChange({
    required this.description,
  });

  @override
  List<Object> get props => [description];
}

class ShowImagePicker extends ProfileEvent {
  final ImageSource imageSource;
  const ShowImagePicker({
    required this.imageSource,
  });

  @override
  List<Object> get props => [imageSource];
}

class UpdateUserInfo extends ProfileEvent {
  final PublicUserInfo userInfo;
  const UpdateUserInfo({
    required this.userInfo,
  });

  @override
  List<Object> get props => [userInfo];
}

class SaveProfile extends ProfileEvent {}

class RequestChangeAvatar extends ProfileEvent {}
