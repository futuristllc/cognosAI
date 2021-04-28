import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cognos/models/calls_data.dart';
import 'package:cognos/const/strings.dart';

class CallMethods {
  final CollectionReference callCollection =
  Firestore.instance.collection(CALL_COLLECTION);

  final CollectionReference callstore =
  Firestore.instance.collection(CALL_LOG);

  Stream<DocumentSnapshot> callStream({String uid}) =>
      callCollection.document(uid).snapshots();

  Stream<DocumentSnapshot> callLog({String uid}) =>
      callstore.document(uid).snapshots();

  Future<bool> makeCall({Call call}) async {
    try {
      call.hasDialled = true;
      Map<String, dynamic> hasDialledMap = call.toMap(call);

      call.hasDialled = false;
      Map<String, dynamic> hasNotDialledMap = call.toMap(call);

      await callCollection.document(call.callerId).setData(hasDialledMap);
      await callCollection.document(call.receiverId).setData(hasNotDialledMap);

      //logs
      await callstore.document(call.callerId).collection(call.callerId).document().setData(hasDialledMap);
      await callstore.document(call.receiverId).collection(call.receiverId).document().setData(hasNotDialledMap);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> endCall({Call call}) async {
    try {
      await callCollection.document(call.callerId).delete();
      await callCollection.document(call.receiverId).delete();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}