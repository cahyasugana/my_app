class Instrument {
  final int instrumentId;
  final int? ownerId;
  final String instrumentName;
  final String? instrumentType;
  final String? description;
  final String? instrumentCondition;
  final String? location;
  final String? availabilityStatus;
  final String? image;

  Instrument({
    required this.instrumentId,
    this.ownerId,
    required this.instrumentName,
    this.instrumentType,
    this.description,
    this.instrumentCondition,
    this.location,
    this.availabilityStatus,
    this.image,
  });

  factory Instrument.fromJson(Map<String, dynamic> json) {
    return Instrument(
      instrumentId: json['instrument_id'],
      ownerId: json['owner_id'],
      instrumentName: json['instrument_name'],
      instrumentType: json['instrument_type'],
      description: json['description'],
      instrumentCondition: json['instrument_condition'],
      location: json['location'],
      availabilityStatus: json['availability_status'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'instrument_id': instrumentId,
      'owner_id': ownerId,
      'instrument_name': instrumentName,
      'instrument_type': instrumentType,
      'description': description,
      'instrument_condition': instrumentCondition,
      'location': location,
      'availability_status': availabilityStatus,
      'image': image,
    };
  }
}
