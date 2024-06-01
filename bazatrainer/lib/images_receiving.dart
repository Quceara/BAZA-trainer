import 'package:flutter/material.dart';

List<Widget> createImageWidgets(List<String> imageUrls) {
  return imageUrls.map((url) => Image.network(url)).toList();
}

List<String> getImageUrls() {
  return [
  ];
}

List<Widget> ImagesRec() {
  List<String> imageUrls = getImageUrls();
  return createImageWidgets(imageUrls);
}
