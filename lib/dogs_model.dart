class DogsModel {
  // Свойста налобол незнаем что прилетить 
  String? message;
  String? status;

  DogsModel({this.message, this.status});
// метод  принемает мапу 
  DogsModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
  }
// обратный метод 
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['status'] = status;
    return data;
  }
}
