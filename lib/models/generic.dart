class Generic {
  final bool success;

  Generic({required this.success});

  factory Generic.fromMap(Map<String, dynamic> json) =>
      Generic(success: (json['success'] != null) ? json['success'] : false);
}
