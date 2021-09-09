import 'dart:async';
import 'dart:io';

import 'package:aking/logic/blocs/firestore/firestore_bloc.dart';
import 'package:aking/logic/blocs/process_state.dart';
import 'package:aking/logic/models/public_user_info.dart';
import 'package:aking/logic/repositories/firestore/public_user_info_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({
    required FirestoreBloc<PublicUserInfo> publicUserInfoBloc,
    required String uid,
    required this.publicUserInfoRepository,
  }) : super(ProfileState()) {
    _updateUserInfoFollowUid(publicUserInfoBloc, uid);
    subscription?.cancel();
    subscription = publicUserInfoBloc.stream.listen((state) {
      if (state is FirestoreLoaded<PublicUserInfo>) {
        _updateUserInfoFollowUid(publicUserInfoBloc, uid);
      }
    });
  }

  void _updateUserInfoFollowUid(
      FirestoreBloc<PublicUserInfo> publicUserInfoBloc, String uid) {
    final userInfo = publicUserInfoBloc.allDoc.firstWhere(
      (element) => element.id == uid,
      orElse: () => PublicUserInfo(
          id: "fake",
          email: "fake@gmail.com",
          name: "Fake",
          avatarLink: "",
          description: "",
          status: true),
    );
    add(UpdateUserInfo(userInfo: userInfo));
  }

  final _picker = ImagePicker();
  final PublicUserInfoRepository publicUserInfoRepository;
  StreamSubscription? subscription;

  @override
  Stream<ProfileState> mapEventToState(
    ProfileEvent event,
  ) async* {
    if (event is UpdateUserInfo) {
      yield state.copyWith(userInfo: event.userInfo);
    } else if (event is NameOnChange) {
      yield state.copyWith(name: event.name);
    } else if (event is RequestChangeAvatar) {
      yield state.copyWith(imageSourceSheetIsVisible: true);
    } else if (event is DescriptionOnChange) {
      yield state.copyWith(description: event.description);
    } else if (event is ShowImagePicker) {
      yield* _mapShowImagePickerToState(event);
    } else if (event is SaveProfile) {
      yield* _mapSaveProfileToState();
    }
  }

  Stream<ProfileState> _mapShowImagePickerToState(
      ShowImagePicker event) async* {
    yield state.copyWith(imageSourceSheetIsVisible: false);
    final XFile? pickedImage =
        await _picker.pickImage(source: event.imageSource);
    if (pickedImage == null) return;
    final _imageFile = File(pickedImage.path);
    final String fileName = basename(_imageFile.path);
    yield state.copyWith(formStatus: Processing());

    try {
      final Reference firebaseStorageRef =
          FirebaseStorage.instance.ref().child('uploads/$fileName');
      final UploadTask uploadTask = firebaseStorageRef.putFile(_imageFile);
      final TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => {});
      final urlDownload = await taskSnapshot.ref.getDownloadURL();

      final String? error = await publicUserInfoRepository
          .updateWithJson({'avatarLink': urlDownload}, state.userInfo.id);

      if (error == null) {
        print("sucess");
        yield state.copyWith(formStatus: ProcessSuccess());
      } else {
        yield state.copyWith(formStatus: ProcessFailure(error));
      }
    } catch (e) {
      yield state.copyWith(
        formStatus: ProcessFailure(e.toString()),
      );
    }
    yield state.copyWith(formStatus: ProcessInitial());
  }

  Stream<ProfileState> _mapSaveProfileToState() async* {
    yield state.copyWith(formStatus: Processing());
    if (state.name == "") {
      yield state.copyWith(
          formStatus: ProcessFailure("Your name can not empty"));
    } else if (state.description == "" && state.userInfo.description == "") {
      yield state.copyWith(
          formStatus: ProcessFailure("Your description can not empty"));
    } else {
      final String? error = await publicUserInfoRepository.updateWithJson(
        {
          'name': state.name,
          'description': state.description == ""
              ? state.userInfo.description
              : state.description
        },
        state.userInfo.id,
      );
      if (error == null) {
        yield state.copyWith(formStatus: ProcessSuccess());
      } else {
        yield state.copyWith(formStatus: ProcessFailure(error));
      }
    }
    yield state.copyWith(formStatus: ProcessInitial());
  }

  @override
  Future<void> close() {
    subscription?.cancel();
    return super.close();
  }
}
