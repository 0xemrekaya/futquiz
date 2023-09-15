import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:futquiz/model/user_model.dart';
import 'package:mobx/mobx.dart';
part 'user_modelview.g.dart';

class UserModelView = _UserModelViewBase with _$UserModelView;

abstract class _UserModelViewBase with Store {
  final _firestore = FirebaseFirestore.instance;

  @observable
  User? user = FirebaseAuth.instance.currentUser;

  @observable
  UserMapModel? userMapModel;

  @action
  void setUser(User? user) {
    this.user = user;
  }

  @action
  Future<void> setUserforFirstTime() async {
    await _firestore.collection("users").doc(user!.uid).set({
      "uid": user!.uid,
      "email": user!.email,
      "displayName": user!.displayName,
      "createdAt": DateTime.now().toString(),
      "userScoreGameOne": 0,
    });
  }

  @action
  Future<void> getUserData() async {
    final data = _firestore.collection("users").doc(user!.uid);
    final response = data.withConverter(
      fromFirestore: UserMapModel.fromFirestore,
      toFirestore: (userMapModel, _) => userMapModel.toFirestore(),
    );
    final docSnap = await response.get();
    final docData = docSnap.data();
    if (docData != null) {
      userMapModel = docData;
    } else {
      print("Data is null");
    }
  }

  @action
  Future<void> setUserData(UserMapModel user) async {
    final data = _firestore.collection("users").doc(user.uid);
    final response = data.withConverter(
      fromFirestore: UserMapModel.fromFirestore,
      toFirestore: (userMapModel, _) => userMapModel.toFirestore(),
    );
    await response.set(user);
  }
}
