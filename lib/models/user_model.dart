import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String? id;
  final String name;
  final int age;
  final String gender;
  final List<dynamic> imageUrls;
  final List<dynamic> interests;
  final String bio;
  final String jobTitle;

  const User({
    this.id,
    required this.name,
    required this.age,
    required this.gender,
    required this.imageUrls,
    required this.interests,
    required this.bio,
    required this.jobTitle,
  });

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
      ];

  static User fromSnapshot(DocumentSnapshot snap) {
    User user = User(
      id: snap.id,
      name: snap['name'],
      age: snap['age'],
      gender: snap['gender'],
      imageUrls: snap['imageUrls'],
      interests: snap['interests'],
      bio: snap['bio'],
      jobTitle: snap['jobTitle'],
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
    );
  }

  static List<User> users = [
    User(
      id: '1',
      name: 'John',
      age: 25,
      gender: 'Male',
      imageUrls: [
        'https://images.unsplash.com/photo-1595623238469-fc58b3839cf6?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=755&q=80',
        'https://images.unsplash.com/photo-1595623238469-fc58b3839cf6?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=755&q=80',
        'https://images.unsplash.com/photo-1595623238469-fc58b3839cf6?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=755&q=80',
        'https://images.unsplash.com/photo-1595623238469-fc58b3839cf6?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=755&q=80',
        'https://images.unsplash.com/photo-1595623238469-fc58b3839cf6?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=755&q=80',
      ],
      jobTitle: 'Job Title Here',
      interests: ['Music', 'Economics', 'Football'],
      bio:
          'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.',
    ),
    User(
      id: '2',
      name: 'Tamara',
      age: 30,
      gender: 'Female',
      imageUrls: [
        'https://images.unsplash.com/photo-1622023459113-9b195477d9c4?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=671&q=80',
        'https://images.unsplash.com/photo-1622023459113-9b195477d9c4?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=671&q=80',
        'https://images.unsplash.com/photo-1622023459113-9b195477d9c4?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=671&q=80',
        'https://images.unsplash.com/photo-1622023459113-9b195477d9c4?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=671&q=80',
        'https://images.unsplash.com/photo-1622023459113-9b195477d9c4?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=671&q=80',
      ],
      jobTitle: 'Job Title Here',
      interests: ['Music', 'Economics', 'Football'],
      bio:
          'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.',
    ),
    User(
      id: '3',
      name: 'Marta',
      age: 35,
      gender: 'Female',
      imageUrls: [
        'https://images.unsplash.com/photo-1622244099803-75318348305a?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
        'https://images.unsplash.com/photo-1622244099803-75318348305a?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
        'https://images.unsplash.com/photo-1622244099803-75318348305a?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
        'https://images.unsplash.com/photo-1622244099803-75318348305a?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
        'https://images.unsplash.com/photo-1622244099803-75318348305a?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
      ],
      jobTitle: 'Job Title Here',
      interests: ['Music', 'Economics', 'Football'],
      bio:
          'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.',
    ),
    User(
      id: '4',
      name: 'Sara',
      age: 30,
      gender: 'Female',
      imageUrls: [
        'https://images.unsplash.com/photo-1622023459113-9b195477d9c4?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=671&q=80',
        'https://images.unsplash.com/photo-1622023459113-9b195477d9c4?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=671&q=80',
        'https://images.unsplash.com/photo-1622023459113-9b195477d9c4?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=671&q=80',
        'https://images.unsplash.com/photo-1622023459113-9b195477d9c4?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=671&q=80',
        'https://images.unsplash.com/photo-1622023459113-9b195477d9c4?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=671&q=80',
      ],
      jobTitle: 'Job Title Here',
      interests: ['Music', 'Economics', 'Football'],
      bio:
          'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.',
    ),
    User(
      id: '5',
      name: 'Anna',
      age: 35,
      gender: 'Female',
      imageUrls: [
        'https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
        'https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
        'https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
        'https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
        'https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
      ],
      jobTitle: 'Job Title Here',
      interests: ['Music', 'Economics', 'Football'],
      bio:
          'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.',
    ),
    User(
      id: '6',
      name: 'Lisa',
      age: 35,
      gender: 'Female',
      imageUrls: [
        'https://images.unsplash.com/photo-1503185912284-5271ff81b9a8?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
        'https://images.unsplash.com/photo-1503185912284-5271ff81b9a8?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
        'https://images.unsplash.com/photo-1503185912284-5271ff81b9a8?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
        'https://images.unsplash.com/photo-1503185912284-5271ff81b9a8?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
        'https://images.unsplash.com/photo-1503185912284-5271ff81b9a8?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
      ],
      jobTitle: 'Job Title Here',
      interests: ['Music', 'Economics', 'Football'],
      bio:
          'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.',
    ),
    User(
      id: '7',
      name: 'Luisa',
      age: 35,
      gender: 'Female',
      imageUrls: [
        'https://images.unsplash.com/photo-1622244099803-75318348305a?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
        'https://images.unsplash.com/photo-1622244099803-75318348305a?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
        'https://images.unsplash.com/photo-1622244099803-75318348305a?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
        'https://images.unsplash.com/photo-1622244099803-75318348305a?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
        'https://images.unsplash.com/photo-1622244099803-75318348305a?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
      ],
      jobTitle: 'Job Title Here',
      interests: ['Music', 'Economics', 'Football'],
      bio:
          'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.',
    ),
    User(
      id: '8',
      name: 'Sara',
      age: 35,
      gender: 'Female',
      imageUrls: [
        'https://images.unsplash.com/photo-1589571894960-20bbe2828d0a?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=633&q=80',
        'https://images.unsplash.com/photo-1589571894960-20bbe2828d0a?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=633&q=80',
        'https://images.unsplash.com/photo-1589571894960-20bbe2828d0a?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=633&q=80',
        'https://images.unsplash.com/photo-1589571894960-20bbe2828d0a?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=633&q=80',
        'https://images.unsplash.com/photo-1589571894960-20bbe2828d0a?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=633&q=80',
      ],
      jobTitle: 'Job Title Here',
      interests: ['Music', 'Economics', 'Football'],
      bio:
          'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.',
    ),
    User(
      id: '9',
      name: 'Andrea',
      age: 35,
      gender: 'Female',
      imageUrls: [
        'https://images.unsplash.com/photo-1622244099803-75318348305a?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
        'https://images.unsplash.com/photo-1622244099803-75318348305a?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
        'https://images.unsplash.com/photo-1622244099803-75318348305a?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
        'https://images.unsplash.com/photo-1622244099803-75318348305a?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
        'https://images.unsplash.com/photo-1622244099803-75318348305a?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
      ],
      jobTitle: 'Job Title Here',
      interests: ['Music', 'Economics', 'Football'],
      bio:
          'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.',
    ),
    User(
      id: '10',
      name: 'Mary',
      age: 35,
      gender: 'Female',
      imageUrls: [
        'https://images.unsplash.com/photo-1456885284447-7dd4bb8720bf?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
        'https://images.unsplash.com/photo-1456885284447-7dd4bb8720bf?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
        'https://images.unsplash.com/photo-1456885284447-7dd4bb8720bf?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
        'https://images.unsplash.com/photo-1456885284447-7dd4bb8720bf?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
        'https://images.unsplash.com/photo-1456885284447-7dd4bb8720bf?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80',
      ],
      jobTitle: 'Job Title Here',
      interests: ['Music', 'Economics', 'Football'],
      bio:
          'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.',
    ),
    User(
      id: '11',
      name: 'Denise',
      age: 35,
      gender: 'Female',
      imageUrls: [
        'https://images.unsplash.com/photo-1596815064285-45ed8a9c0463?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=615&q=80',
        'https://images.unsplash.com/photo-1596815064285-45ed8a9c0463?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=615&q=80',
        'https://images.unsplash.com/photo-1596815064285-45ed8a9c0463?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=615&q=80',
        'https://images.unsplash.com/photo-1596815064285-45ed8a9c0463?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=615&q=80',
        'https://images.unsplash.com/photo-1596815064285-45ed8a9c0463?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=615&q=80',
      ],
      jobTitle: 'Job Title Here',
      interests: ['Music', 'Economics', 'Football'],
      bio:
          'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.',
    ),
    User(
      id: '12',
      name: 'Elle',
      age: 35,
      gender: 'Female',
      imageUrls: [
        'https://images.unsplash.com/photo-1562003389-902303a38425?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1429&q=80',
        'https://images.unsplash.com/photo-1562003389-902303a38425?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1429&q=80'
            'https://images.unsplash.com/photo-1562003389-902303a38425?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1429&q=80'
            'https://images.unsplash.com/photo-1562003389-902303a38425?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1429&q=80'
            'https://images.unsplash.com/photo-1562003389-902303a38425?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1429&q=80'
      ],
      jobTitle: 'Job Title Here',
      interests: ['Music', 'Economics', 'Football'],
      bio:
          'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.',
    ),
  ];
}
