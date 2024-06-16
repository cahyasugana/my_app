class Instruments {
  final int instrumentId;
  final int ownerId;
  final String ownerUsername;
  final String instrumentName;
  final String description;
  final String location;
  final int availabilityStatus;
  final String? image;
  final int instrumentTypeId;
  final String instrumentType; // New field for the instrument type name
  final String averageRating; // New field for the average rating

  Instruments({
    required this.instrumentId,
    required this.ownerId,
    required this.ownerUsername,
    required this.instrumentName,
    required this.description,
    required this.location,
    required this.availabilityStatus,
    this.image,
    required this.instrumentTypeId,
    required this.instrumentType, // Include the new field in the constructor
    required this.averageRating, // Include the new field in the constructor
  });

  factory Instruments.fromJson(Map<String, dynamic> json) {
    return Instruments(
      instrumentId: json['instrument_id'] as int,
      ownerId: json['owner_id'] as int,
      ownerUsername: json['owner_username'] as String,
      instrumentName: json['instrument_name'] as String,
      description: json['description'] as String,
      location: json['location'] as String,
      availabilityStatus: json['availability_status'] as int,
      image: json['image'] as String?,
      instrumentTypeId: json['instrument_type_id'] as int,
      instrumentType: json['instrument_type'] as String,
      averageRating: json['average_rating'] as String,
    );
  }
}
