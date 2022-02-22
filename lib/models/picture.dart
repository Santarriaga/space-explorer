
class Picture{

  String? imageUrl;
  String? imageInfo="Image Information";
  String? imageTitle="Image Title";
  String? mediaType ="mediaType";
  bool isLiked = false;



  Picture({this.imageUrl, this.imageInfo, this.imageTitle, this.mediaType});

  factory Picture.fromJson(Map<String, dynamic> json) {
    return Picture(
        imageUrl: json['hdurl'],
        imageTitle: json['title'],
        imageInfo: json['explanation'],
        mediaType: json['media_type'],
    );
  }

}