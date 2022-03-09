import 'package:flutter/material.dart';
import 'package:better_player/better_player.dart';
import 'package:flutter/services.dart';

class AriticleVideoPlayer extends StatelessWidget {
  const AriticleVideoPlayer({Key? key, required this.videoUrl})
      : super(key: key);

  final String videoUrl;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: BetterPlayer.network(
        videoUrl,
        betterPlayerConfiguration:  BetterPlayerConfiguration(
            //deviceOrientationsOnFullScreen : [DeviceOrientation.portraitUp],
            controlsConfiguration: BetterPlayerControlsConfiguration (controlBarColor : Colors.black.withOpacity(0.2)) ,
            deviceOrientationsAfterFullScreen: [DeviceOrientation.portraitUp]),
      ),
    );
  }
}
