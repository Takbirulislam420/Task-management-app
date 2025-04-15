class TaskStatusCountModel {
  late String status;
  late int count;

  TaskStatusCountModel.fromJson(Map<String, dynamic> jsondata) {
    status = jsondata['_id'];
    count = jsondata['sum'];
  }
}
