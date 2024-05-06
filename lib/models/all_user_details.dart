import 'package:uuid/uuid.dart';

const uuid = Uuid();

class BookDetails {
  const BookDetails({
    required this.carType,
    required this.parkingSlot,
    required this.timeDuration,
    required this.pricePerHour,
  });

  final String carType;
  final String parkingSlot;
  final Duration timeDuration;
  final int pricePerHour;
}

class RegisterInfo {
  RegisterInfo({
    required this.userName,
    required this.email,
    required this.phone,
    required this.carType,
    required this.password,
  });
  final String userName;
  final String email;
  final String phone;
  final String carType;
  final String password;
}

class LoginInfo {
  LoginInfo({
    required this.email,
    required this.password,
  });
  final String email;
  final String password;
}

class UserLoginInfo {
  UserLoginInfo(
      {required this.token,
      required this.id,
      required this.isAdmin,
      required this.isVerified});
  final String token;
  final String id;
  final bool isAdmin;
  final bool isVerified;
}

class UserLoggedIn {
  UserLoggedIn({
    required this.email,
    required this.token,
    required this.isAdmin,
  });
  final String email;
  final String token;
  final bool isAdmin;
  UserLoggedIn copyWith({String? email, String? token, bool? isAdmin}) {
    return UserLoggedIn(
      email: email ?? this.email,
      token: token ?? this.token,
      isAdmin: isAdmin ?? this.isAdmin,
    );
  }
}

class UserData {
  UserData({
    required this.id,
    required this.userName,
    required this.email,
    required this.mobileNumber,
    required this.carType,
    required this.isAdmin,
    required this.isVerified,
    required this.points,
    this.slot,
  });
  String id;
  String userName;
  String email;
  String mobileNumber;
  String carType;
  dynamic slot;
  bool isAdmin;
  bool isVerified;
  int points;

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'],
      isAdmin: json['isAdmin'],
      userName: json['username'],
      points: json['points'],
      email: json['email'],
      mobileNumber: json['mobileNumber'],
      carType: json['carType'],
      isVerified: json['isVerified'],
      slot: json['slot'],
    );
  }
  @override
  String toString() {
    return 'UserData{id: $id, isAdmin: $isAdmin, username: $userName, points: $points, email: $email, mobileNumber: $mobileNumber, carType: $carType, isVerified: $isVerified , slot: $slot} ';
  }
}

class SlotData {
  SlotData(
      {required this.id,
      required this.code,
      required this.isFree,
      required this.userId,
      required this.createdAt,
      required this.updatedAt});
  final String id;
  final String code;
  final bool isFree;
  final String createdAt;
  final String updatedAt;
  String? userId;

  factory SlotData.fromJson(Map<String, dynamic> json) {
    return SlotData(
      id: json['id'],
      code: json['code'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      isFree: json['isFree'] as bool,
      userId: json['userId'],
    );
  }
  @override
  String toString() {
    return 'SlotData(id: $id, code: $code, isFree: $isFree, userId: $userId, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}

class Resetpassword {
  final String email;
  const Resetpassword({required this.email});
}
