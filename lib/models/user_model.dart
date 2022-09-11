import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import 'location_model.dart';

class User extends Equatable {
  final String? id;
  final String name;
  final int age;
  final String gender;
  final List<dynamic> imageUrls;
  final List<dynamic> interests;
  final String bio;
  final String jobTitle;
  final Location? location;
  final List<String>? swipeLeft;
  final List<String>? swipeRight;
  final List<Map<String, dynamic>>? matches;
  final List<String>? genderPreference;
  final List<int>? ageRangePreference;
  final int? distancePreference;

  const User({
    this.id,
    required this.name,
    required this.age,
    required this.gender,
    required this.imageUrls,
    required this.interests,
    required this.bio,
    required this.jobTitle,
    this.location,
    this.swipeLeft,
    this.swipeRight,
    this.matches,
    this.genderPreference,
    this.ageRangePreference,
    this.distancePreference,
  });

  static const User empty = User(
    id: '',
    name: '',
    age: 0,
    gender: '',
    imageUrls: [],
    jobTitle: '',
    interests: [],
    bio: '',
    location: Location.initialLocation,
    swipeLeft: [],
    swipeRight: [],
    matches: [],
    genderPreference: ['Male', 'Female'],
    ageRangePreference: [18, 50],
    distancePreference: 10,
  );

  static User fromSnapshot(DocumentSnapshot snap) {
    var data = snap.data() as Map<String, dynamic>?;

    List<String> userGenderPreference = [''];
    List<int> userAgeRangePreference = [];
    int userDistancePreference = 10;

    if (data != null) {
      userGenderPreference = (data['genderPreference'] == null)
          ? ['Male']
          : (data['genderPreference'] as List)
              .map((gender) => gender as String)
              .toList();
      userAgeRangePreference = (data['ageRangePreference'] == null)
          ? [19, 40]
          : (data['ageRangePreference'] as List)
              .map((age) => age as int)
              .toList();
      userDistancePreference = (data['distancePreference'] == null)
          ? 30
          : data['distancePreference'];
    }

    User user = User(
      id: snap.id,
      name: snap['name'],
      age: snap['age'],
      gender: snap['gender'],
      imageUrls: snap['imageUrls'],
      interests: snap['interests'],
      bio: snap['bio'],
      jobTitle: snap['jobTitle'],
      location: Location.fromJson(snap['location']),
      swipeLeft: (snap['swipeLeft'] as List)
          .map((swipeLeft) => swipeLeft as String)
          .toList(),
      swipeRight: (snap['swipeRight'] as List)
          .map((swipeRight) => swipeRight as String)
          .toList(),
      matches: (snap['matches'] as List)
          .map((matches) => matches as Map<String, dynamic>)
          .toList(),
      genderPreference: userGenderPreference,
      ageRangePreference: userAgeRangePreference,
      distancePreference: userDistancePreference,
    );
    return user;
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'age': age,
      'gender': gender,
      'imageUrls': imageUrls,
      'interests': interests,
      'bio': bio,
      'jobTitle': jobTitle,
      'location': location!.toMap(),
      'swipeLeft': swipeLeft,
      'swipeRight': swipeRight,
      'matches': matches,
      'genderPreference': genderPreference,
      'ageRangePreference': ageRangePreference,
      'distancePreference': distancePreference,
    };
  }

  User copyWith({
    String? id,
    String? name,
    int? age,
    String? gender,
    List<dynamic>? imageUrls,
    List<dynamic>? interests,
    String? bio,
    String? jobTitle,
    Location? location,
    List<String>? swipeLeft,
    List<String>? swipeRight,
    List<Map<String, dynamic>>? matches,
    List<String>? genderPreference,
    List<int>? ageRangePreference,
    int? distancePreference,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      imageUrls: imageUrls ?? this.imageUrls,
      interests: interests ?? this.interests,
      bio: bio ?? this.bio,
      jobTitle: jobTitle ?? this.jobTitle,
      location: location ?? this.location,
      swipeLeft: swipeLeft ?? this.swipeLeft,
      swipeRight: swipeRight ?? this.swipeRight,
      matches: matches ?? this.matches,
      genderPreference: genderPreference ?? this.genderPreference,
      ageRangePreference: ageRangePreference ?? this.ageRangePreference,
      distancePreference: distancePreference ?? this.distancePreference,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        age,
        gender,
        imageUrls,
        interests,
        bio,
        jobTitle,
        location,
        swipeLeft,
        swipeRight,
        matches,
        genderPreference,
        ageRangePreference,
        distancePreference,
      ];
}
