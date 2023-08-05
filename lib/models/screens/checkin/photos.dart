class Photos{
  // ADD PHOTO
  String image;
  String title;
  String description;
  String sharable;
  List<String> taggable = [];

  Photos({
    this.image = "",
    this.title = "",
    this.description = "",
    this.sharable = "",
    required this.taggable,
  });

  Map<String, dynamic> toMap() => {
    "image": image,
    "title": title,
    "description": description,
    "sharable": sharable,
    for(int x = 0; x < taggable.length; x++)...{
      "taggable[$x]": taggable[x].toString()
    }
  };
}

Photos photos = new Photos(taggable: []);