class Blog {
  int? id;
  String? title;
  String? image;
  String? createTime;

  Blog._main(this.id, this.title, this.image, this.createTime);
  factory Blog.fromJson(Map<String, dynamic> json) => Blog._main(
      int.tryParse(json['id']),
      (json['title'] ?? "").toString(),
      (json['imageUrl'] ?? "").toString(),
      (json['createdAt'] ?? "").toString());
}
