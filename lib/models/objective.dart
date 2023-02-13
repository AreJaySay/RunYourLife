class Objective {
  final int id;
  final int idObjective;
  final int clientId;
  final int position;
  int viewStatus;
  final DateTime createdAt;
  final DateTime updatedAt;
  final SubObjective? objective;
   Objective({
    required this.objective,
    required this.clientId,
    required this.idObjective,
    required this.createdAt,
    required this.id,
    required this.position,
    required this.updatedAt,
    this.viewStatus = 0,
  });

  factory Objective.fromJson(Map<String, dynamic> json) => Objective(
        objective: json['obj_programmation'] == null ? null : SubObjective.fromJson(json['obj_programmation']),
        clientId: json['client_id'].toInt(),
        idObjective: json['id_obj_programmation'].toInt(),
        createdAt: DateTime.parse(json['created_at']),
        id: json['id'].toInt(),
        position: json['position']?.toInt() ?? 0,
        updatedAt: DateTime.parse(json['updated_at']),
        viewStatus: json['view_status']?.toInt() ?? 0,
      );

  Map<String, dynamic> toJson()=> {
    "id" : id,
    "objective" : objective != null ? objective!.toJson() : null,
    "client_id" : clientId,
    "id_obj_programmation" : idObjective,
    "createdAt" : createdAt.toString(),
    "updatedAt" : updatedAt.toString(),
    "view_status" : viewStatus,
    "position" : position,
  };

  @override
  String toString() => "${toJson()}";
}

class SubObjective {
  final int id;
  final int coachId;
  final String title;
  final String description;
  final int tags;
  final RelatedTags? relatedTags;

  const SubObjective({
    required this.id,
    required this.title,
    required this.coachId,
    required this.description,
    required this.tags,
    required this.relatedTags,
  });

  factory SubObjective.fromJson(Map<String, dynamic> json) => SubObjective(
        id: json['id'].toInt(),
        title: json['title'] ?? "",
        coachId: json['coach_id'].toInt(),
        description: json['programmation_description'] ?? "",
        tags: json['tags'].toInt(),
        relatedTags: json['related_tags'] == null
            ? null
            : RelatedTags.fromJson(json['related_tags']),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "coach_id": coachId,
        "title": title,
        "programmation_description": description,
        "tags": tags,
        "related_tags": relatedTags == null ? null : relatedTags!.toJson(),
      };

  @override
  String toString() => '${toJson()}';
}

class RelatedTags {
  final int id;
  final String name;
  final String color;
  final String description;
  final String type;
  const RelatedTags(
      {required this.id,
      required this.name,
      required this.color,
      required this.description,
      required this.type});

  factory RelatedTags.fromJson(Map<String, dynamic> json) => RelatedTags(
        id: json['id'].toInt(),
        name: json['name'] ?? "",
        color: json['color'] ?? "",
        description: json['description'] ?? "",
        type: json['type'] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "color": color,
        "description": description,
        "type": type,
      };

  @override
  String toString() =>
      '{ "id" : $id, "name" : $name, "color" : $color, "description" : $description, "type" : $type }';
}
