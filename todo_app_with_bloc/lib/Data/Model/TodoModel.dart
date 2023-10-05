class Todo{
  int? id;
  String? note;
  String? date;
  String? time;
  String? status;

  Todo({this.id,
     this.note,
     this.date,
     this.time,
     this.status,});

  factory Todo.fromJson(Map<String,dynamic>data)
  {
    return Todo(
         id:data['id'] ,
        note: data['text'],
        date: data['date'],
        time: data['time'],
        status: data['status']);
  }

  Map<String,dynamic>  toJson()
  {
    return {
      "id":id,
      "text":note,
      "date":date,
      "time":time,
      "status":status
    };
  }
}