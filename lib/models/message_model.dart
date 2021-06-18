import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class Message extends Equatable {
  final int id;
  final int senderId;
  final int receiverId;
  final String message;
  final DateTime dateTime;
  final String timeString;

  Message({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.dateTime,
    required this.timeString,
  });

  @override
  List<Object?> get props => [
        id,
        receiverId,
        senderId,
        message,
        dateTime,
      ];

  static List<Message> messages = [
    Message(
        id: 1,
        senderId: 1,
        receiverId: 2,
        message: 'Hey, how are you?',
        dateTime: DateTime.now(),
        timeString: DateFormat('jm').format(DateTime.now())),
    Message(
        id: 2,
        senderId: 2,
        receiverId: 1,
        message: 'I\'m good, thank you.',
        dateTime: DateTime.now(),
        timeString: DateFormat('jm').format(DateTime.now())),
    Message(
        id: 3,
        senderId: 1,
        receiverId: 2,
        message: 'I\'m good, as well. Thank you.',
        dateTime: DateTime.now(),
        timeString: DateFormat('jm').format(DateTime.now())),
    Message(
        id: 4,
        senderId: 1,
        receiverId: 3,
        message: 'Hey, how are you?',
        dateTime: DateTime.now(),
        timeString: DateFormat('jm').format(DateTime.now())),
    Message(
        id: 5,
        senderId: 3,
        receiverId: 1,
        message: 'I\'m good, thank you.',
        dateTime: DateTime.now(),
        timeString: DateFormat('jm').format(DateTime.now())),
    Message(
        id: 6,
        senderId: 1,
        receiverId: 5,
        message: 'Hey, how are you?',
        dateTime: DateTime.now(),
        timeString: DateFormat('jm').format(DateTime.now())),
    Message(
        id: 7,
        senderId: 5,
        receiverId: 1,
        message: 'I\'m good, thank you.',
        dateTime: DateTime.now(),
        timeString: DateFormat('jm').format(DateTime.now())),
    Message(
        id: 8,
        senderId: 1,
        receiverId: 6,
        message: 'Hey, how are you?',
        dateTime: DateTime.now(),
        timeString: DateFormat('jm').format(DateTime.now())),
    Message(
        id: 9,
        senderId: 6,
        receiverId: 1,
        message: 'I\'m good, thank you.',
        dateTime: DateTime.now(),
        timeString: DateFormat('jm').format(DateTime.now())),
    Message(
        id: 10,
        senderId: 1,
        receiverId: 7,
        message: 'Hey, how are you?',
        dateTime: DateTime.now(),
        timeString: DateFormat('jm').format(DateTime.now())),
    Message(
        id: 11,
        senderId: 7,
        receiverId: 1,
        message: 'I\'m good, thank you.',
        dateTime: DateTime.now(),
        timeString: DateFormat('jm').format(DateTime.now())),
  ];
}
