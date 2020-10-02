class Casts {
  List<Cast> casts = new List();

  Casts();

  Casts.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    jsonList.forEach((element) {
      final cast = new Cast.fromJsonMap(element);
      casts.add(cast);
    });
  }
}

class Cast {
  int castId;
  String character;
  String creditId;
  int gender;
  int id;
  String name;
  int order;
  String profilePath;

  Cast({
    this.castId,
    this.character,
    this.creditId,
    this.gender,
    this.id,
    this.name,
    this.order,
    this.profilePath,
  });

  Cast.fromJsonMap(Map<String, dynamic> json) {
    castId = json['cast_id'];
    character = json['character'];
    creditId = json['credit_id'];
    gender = json['gender'];
    id = json['id'];
    name = json['name'];
    order = json['order'];
    profilePath = json['profile_path'];
  }

  getPicture() {
    if (profilePath == null) {
      return "https://icon-library.com/images/no-profile-pic-icon/no-profile-pic-icon-27.jpg";
    }
    return "https://image.tmdb.org/t/p/w500/$profilePath";
  }
}
