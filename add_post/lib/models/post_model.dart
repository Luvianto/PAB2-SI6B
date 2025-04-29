class Post {
  final String category;
  final String createdAt;
  final String description;
  final String fullName;
  final String image;
  final double latitude;
  final double longitude;
  final String userId;

  Post({
    required this.category,
    required this.createdAt,
    required this.description,
    required this.fullName,
    required this.image,
    required this.latitude,
    required this.longitude,
    required this.userId,
  });

  factory Post.fromMap(Map<String, dynamic> data) {
    return Post(
      category: data['category'] ?? 'Tidak Diketahui',
      createdAt: (data['createdAt'] ?? ''),
      description: data['description'] ?? '',
      fullName: data['fullName'] ?? 'Anonim',
      image: data['image'] ?? '',
      latitude: ((data['latitude'] ?? 0) as num).toDouble(),
      longitude: ((data['longitude'] ?? 0) as num).toDouble(),
      userId: data['userId'] ?? '',
    );
  }
}
