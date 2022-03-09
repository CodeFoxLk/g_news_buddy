import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

class DominantColorProvider extends ChangeNotifier {
  Future<PaletteGenerator> updatePaletteGenerator(String imagePath) async {
    PaletteGenerator paletteGenerator = await PaletteGenerator.fromImageProvider(
      Image.asset(imagePath).image,
    );
    return paletteGenerator;
  }
}
