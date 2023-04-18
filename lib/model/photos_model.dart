class Photomodel {
  String imgsrc;
  String photographer;
  Photomodel({required this.photographer, required this.imgsrc});
  static Photomodel fromApiToApp(Map<String, dynamic> photoMap) {
    return Photomodel(
      photographer: photoMap["photographer"],
      imgsrc: (photoMap["src"])["portrait"],
    );
  }
}
