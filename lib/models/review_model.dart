class ReviewModel {
  final String id;
  final String shopId;
  final String userId;
  final String? review;
  final double rating;

  ReviewModel({
    required this.id,
    required this.shopId,
    required this.userId,
    this.review,
    required this.rating,
  });

  factory ReviewModel.fromMap(String uid, Map<String, dynamic> map) {
    return ReviewModel(
      id: uid,
      shopId: map['shopId'],
      userId: map['userId'],
      review: map['review'] ?? '',
      rating: map['rating'] ?? 0.0,
    );
  }
}
