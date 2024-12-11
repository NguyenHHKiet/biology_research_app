class Kingdom {
  final String name;

  Kingdom({required this.name});

  factory Kingdom.fromJson(Map<String, dynamic> json) {
    return Kingdom(name: json['name']);
  }
}
