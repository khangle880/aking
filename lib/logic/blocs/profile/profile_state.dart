part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  final PublicUserInfo userInfo;
  final String avatarPath;
  final String name;
  final String description;
  final ProcessState formStatus;
  final bool imageSourceSheetIsVisible;

  const ProfileState({
    this.userInfo = const PublicUserInfo(
        id: "fake",
        email: "fake@gmail.com",
        name: "Fake",
        avatarLink: "",
        description: "",
        status: true),
    this.avatarPath = '',
    this.name = '',
    this.description = '',
    this.formStatus = const ProcessInitial(),
    this.imageSourceSheetIsVisible = false,
  });

  @override
  List<Object> get props {
    return [
      userInfo,
      avatarPath,
      name,
      description,
      formStatus,
      imageSourceSheetIsVisible,
    ];
  }

  ProfileState copyWith({
    PublicUserInfo? userInfo,
    String? avatarPath,
    String? name,
    String? description,
    ProcessState? formStatus,
    bool? imageSourceSheetIsVisible,
  }) {
    return ProfileState(
      userInfo: userInfo ?? this.userInfo,
      avatarPath: avatarPath ?? this.avatarPath,
      name: name ?? this.name,
      description: description ?? this.description,
      formStatus: formStatus ?? this.formStatus,
      imageSourceSheetIsVisible:
          imageSourceSheetIsVisible ?? this.imageSourceSheetIsVisible,
    );
  }
}
