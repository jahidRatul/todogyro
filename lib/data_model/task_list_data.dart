class TaskListData {
  String? name;
  TaskListData({this.name,});


  Map<String, dynamic> toJson() {
    return {
      'name': name
    };
  }

  factory TaskListData.fromJson(Map<String, dynamic> json) {
    return TaskListData(
      name: json['name'],
    );
  }
}