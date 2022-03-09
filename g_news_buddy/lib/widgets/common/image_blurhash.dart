import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';

class BlurHashImage extends StatelessWidget {
  const BlurHashImage({Key? key, this.hash, required this.uri}) : super(key: key);

  final String? hash;
  final String uri;

  @override
  Widget build(BuildContext context) {
    return BlurHash(
      imageFit: BoxFit.cover,
      hash: hash ?? 'LEHV6nWB2yk8pyo0adR*.7kCMdnj',
      image: uri,
      // duration: duration,
      // onStarted: onStarted,
      // onDecoded: onDecoded,
      // onDisplayed: onDisplayed,
    );
  }
}
