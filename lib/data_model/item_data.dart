class ItemData{
  String? title;
  dynamic time;
  String? note;
  bool? checked;
  ItemData({this.title,this.time,this.note,this.checked});


  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'time': time != null ? time.toString() : null,
      'note': note,
      'checked':checked
    };
  }

  factory ItemData.fromJson(Map<String, dynamic> json) {
    return ItemData(
      title: json['title'],
      time: json['time'] != null ? DateTime.parse(json['time']) : null,
      note: json['note'],
      checked: json['checked']
    );
  }
}
