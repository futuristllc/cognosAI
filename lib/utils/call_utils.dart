import 'dart:math';
import 'package:cognos/models/calls_data.dart';
import 'package:cognos/models/userlist.dart';
import 'package:cognos/resources/call_method.dart';
import 'package:cognos/screens/call_screen/call_screen.dart';
import 'package:flutter/material.dart';
import 'package:cognos/screens/call_screen/voice_call_screen.dart';
import 'package:intl/intl.dart';

class CallUtils {
  static final CallMethods callMethods = CallMethods();

  static dial({UserList from, UserList to, String type, context}) async {
    Call call = Call(
      callerId: from.uid,
      callerName: from.name,
      callerPic: from.profileurl,
      receiverId: to.uid,
      receiverName: to.name,
      receiverPic: to.profileurl,
      type: type.toString(),
      time: DateFormat("H:m").format(DateTime.now()).toString(),
      date: DateFormat('yyyy-MM-dd').format(DateTime.now()),
      channelId: Random().nextInt(1000).toString(),
    );

    bool callMade = await callMethods.makeCall(call: call);

    call.hasDialled = true;

    if(call.type == "VIDEO" && callMade){

        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CallScreen(call: call),
            ));

    }
    if(call.type == "VOICE" && callMade) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VoiceCall(call: call),
            ));

    }
  }
}

/*class VoiceUtils {
  static final VoiceCallMethods vcallMethods = VoiceCallMethods();

  static vdial({UserList from, UserList to, String type, context}) async {
    Voice voice = Voice(
      callerId: from.uid,
      callerName: from.name,
      callerPic: from.profileurl,
      receiverId: to.uid,
      receiverName: to.name,
      receiverPic: to.profileurl,
      type: "VOICE",
      channelId: Random().nextInt(1000).toString(),
    );

    bool vcallMade = await vcallMethods.vmakeCall(voice: voice);

    voice.hasDialled = true;

    if (vcallMade) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VoiceCall(voice: voice, flag: 1,),
          )
      );
    }
  }
}*/