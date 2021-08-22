import 'dart:async';

import 'package:aking/logic/models/public_user_info.dart';
import 'package:aking/logic/repositories/public_user_info_repository.dart';
import 'package:aking/logic/utils/extensions/extensions.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'public_user_info_event.dart';
part 'public_user_info_state.dart';

class PublicUserInfoBloc
    extends Bloc<PublicUserInfoEvent, PublicUserInfoState> {
  PublicUserInfoBloc(this._publicUserInfoRepository)
      : super(PublicUserInfoInitial());

  final PublicUserInfoRepository _publicUserInfoRepository;
  List<PublicUserInfo> _allUserInfo = [];
  StreamSubscription? _subscription;
  @override
  Stream<PublicUserInfoState> mapEventToState(
    PublicUserInfoEvent event,
  ) async* {
    if (event is LoadPublicUsersInfo) {
      yield* _mapLoadPublicUsersInfoToState();
    } else if (event is UpdateUsersInfo) {
      yield* _mapUpdateUsersInfoToState(event.infos);
    } else if (event is FindByText) {
      yield* _mapFindByTextToState(event.findKey);
    }
  }

  Stream<PublicUserInfoState> _mapLoadPublicUsersInfoToState() async* {
    _subscription?.cancel();
    _subscription = _publicUserInfoRepository
        .getAllPublicUserInfo()
        .listen((infos) => add(UpdateUsersInfo(infos)));
  }

  Stream<PublicUserInfoState> _mapUpdateUsersInfoToState(
      List<PublicUserInfo> infos) async* {
    _allUserInfo = infos;
    await Future.delayed(Duration(milliseconds: 400));
    yield PublicUserInfoLoaded(infos);
  }

  Stream<PublicUserInfoState> _mapFindByTextToState(String findKey) async* {
    if (state is PublicUserInfoLoaded) {
      final infos =
          _allUserInfo.findByText(findKey: findKey);
      yield PublicUserInfoFiltered(infos);
    }
  }
}
