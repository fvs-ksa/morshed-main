import 'package:agora_uikit/agora_uikit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';

const appId = '9b63ce35c9ce449f9aa164150bcf64b6';
const tokenCall =
    '007eJxTYEgV+8o2ac9+j2D3X6qrzjLcP2todi3oBMfpWxdD3/xUlF+nwGCZZGacnGpsmmyZnGpiYplmmZhoaGZiaGqQlJxmZpJkxj/nQkpDICNDy+lXLIwMEAji8zPk5pcWFWekpjhnJOblpeYwMAAAQe4l0A==';

class VideoCallScreen extends StatefulWidget {


  String channelName;

  VideoCallScreen({required this.channelName});
  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();

}

class _VideoCallScreenState extends State<VideoCallScreen> {

 // String get channelNames => widget.channelName;
 //  AgoraClient client = AgoraClient(
 //      agoraConnectionData:
 //          AgoraConnectionData(appId: appId, channelName:'widget.channelName',tempToken:tokenCall ),
 //      enabledPermission: [Permission.camera, Permission.microphone]);
  int? _remoteUid;
  int uid = 0;
 bool _isJoined = false; // Indicates if the local user has joined the channel
 bool _isHost = true; // Indicates whether the user has joined as a host or audience
 late RtcEngine agoraEngine;
 final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey
 = GlobalKey<ScaffoldMessengerState>();
 showMessage(String message) {
   scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(
     content: Text(message),
   ));
 }
  Future<void> setupVideoSDKEngine() async {
    // retrieve or request camera and microphone permissions
    await [Permission.microphone, Permission.camera].request();

    //create an instance of the Agora engine
    agoraEngine = createAgoraRtcEngine();
    await agoraEngine.initialize(const RtcEngineContext(
        appId: appId
    ));

    await agoraEngine.enableVideo();

    // Register the event handler
    agoraEngine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          showMessage("Local user uid:${connection.localUid} joined the channel");
          setState(() {
            _isJoined = true;
          });
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          showMessage("Remote user uid:$remoteUid joined the channel");
          setState(() {
            _remoteUid = remoteUid;
          });
        },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          showMessage("Remote user uid:$remoteUid left the channel");
          setState(() {
            _remoteUid = null;
          });
        },
      ),
    );
  }
  void join() async {

    // Set channel options
    ChannelMediaOptions options;

    // Set channel profile and client role
    if (_isHost) {
      options = const ChannelMediaOptions(
        clientRoleType: ClientRoleType.clientRoleBroadcaster,

        channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
      );
      await agoraEngine.startPreview();
    } else {
      options = const ChannelMediaOptions(
        clientRoleType: ClientRoleType.clientRoleAudience,
        channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
      );
    }

    await agoraEngine.joinChannel(
      token: tokenCall,
      channelId: widget.channelName,
      options: options,
      uid: uid,
    );
  }


 // Future<void> initForAgora() async {
 //   await setupVideoSDKEngine();
 //  }

  @override
  void initState() {
    setupVideoSDKEngine();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async=>false,
      child: Scaffold(
        appBar: AppBar(
          title: Text('أتصال مرئي'),
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          children: [
            // Container for the local video
            Container(
              height: 240,
              decoration: BoxDecoration(border: Border.all()),
              child: Center(child: _videoPanel()),
            ),
            // Radio Buttons
            Row(children: <Widget>[
              Radio<bool>(
                value: true,
                groupValue: _isHost,
                onChanged: (value) => _handleRadioValueChange(value),
              ),
              const Text('Host'),
              Radio<bool>(
                value: false,
                groupValue: _isHost,
                onChanged: (value) => _handleRadioValueChange(value),
              ),
              const Text('Audience'),
            ]),
            // Button Row
            Row(
              children: <Widget>[
                Expanded(
                  child: ElevatedButton(
                    child: const Text("Join"),
                    onPressed: () => {join()},
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    child: const Text("Leave"),
                    onPressed: () => {leave()},
                  ),
                ),
              ],
            ),
            // Button Row ends
          ],
        ),
        // body: Stack(
        //   children: [
        //     AgoraVideoViewer(
        //       client: client,
        //       layoutType: Layout.floating,
        //     ),
        //     AgoraVideoButtons(client: client,enabledButtons: [
        //       BuiltInButtons.callEnd,
        //       BuiltInButtons.toggleMic,
        //       BuiltInButtons.switchCamera,
        //     ],),
        //     AgoraVideoView(controller: controller)
        //     // Center(
        //     //   child: _renderRemoteVideo(),
        //     // ),
        //     // Align(
        //     //   alignment: AlignmentDirectional.topStart,
        //     //   child: Container(
        //     //     height: 120.h,
        //     //     width: 120.w,
        //     //     child: Center(
        //     //       child: _renderLocalePreview(),
        //     //     ),
        //     //   ),
        //     // )
        //   ],
        // ),
      ),
    );
  }

  Widget _renderLocalePreview() {
    return Container();
  }

  Widget _renderRemoteVideo() {
    if (_remoteUid != null) {
      return Container();
    } else {
      return Text(
        'من فضلك انتظر حتى قبول الطرف الأخر للإتصال',
        textAlign: TextAlign.center,
      );
    }
  }
 Widget _videoPanel() {
   if (!_isJoined) {
     return const Text(
       'Join a channel',
       textAlign: TextAlign.center,
     );
   } else if (_isHost) {
     // Show local video preview
     return AgoraVideoView(
       controller: VideoViewController(
         rtcEngine: agoraEngine,
         canvas: VideoCanvas(uid: 0),
       ),
     );
   } else {
     // Show remote video
     if (_remoteUid != null) {
       return AgoraVideoView(
         controller: VideoViewController.remote(
           rtcEngine: agoraEngine,
           canvas: VideoCanvas(uid: _remoteUid),
           connection: RtcConnection(channelId: widget.channelName),
         ),
       );
     } else {
       return const Text(
         'Waiting for a host to join',
         textAlign: TextAlign.center,
       );
     }
   }
 }
 void _handleRadioValueChange(bool? value) async {
   setState(() {
     _isHost = (value == true);
   });
   if (_isJoined) leave();
 }
 void leave() {
   setState(() {
     _isJoined = false;
     _remoteUid = null;
   });
   agoraEngine.leaveChannel();
 }
}
