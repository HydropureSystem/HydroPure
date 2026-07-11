class DetectionModel {

  final String className;

  final double confidence;

  final List bbox;

  DetectionModel({

    required this.className,

    required this.confidence,

    required this.bbox,

  });

  factory DetectionModel.fromJson(
      Map<String,dynamic> json){

    return DetectionModel(

      className: json["class"],

      confidence: json["confidence"],

      bbox: json["bbox"],

    );

  }

}