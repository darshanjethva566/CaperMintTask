
class TaskModel {
  String? title;
  String? cat;
  String? date;
  String? description;
  bool ?task;

  TaskModel({this.title, this.cat, this.date, this.description, this.task});

  TaskModel.fromJson(Map<String, dynamic> json) {
     title = json['title'];
     cat = json['cat'];
     date = json['date'];
     description = json['description'];
     task = json['task'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cat'] = cat;
    data['title'] = title;
    data['date'] = date;
    data['description'] = description;
    data['task'] = task;
    return data;
  }

}