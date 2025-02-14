import 'package:book_app_m2m/utils/string_extension.dart';
import 'package:book_app_m2m/utils/util_functions.dart';

class FullUserModel {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final DateTime? birthDate;
  final String coverImageUrl;
  final String profileImageUrl;
  final String? motivationalQuote;
  final bool disabled;
  // TODO: status and role should be enums but I don't know all possible values
  final String role;
  final String status; // "ACTIVE"
  final bool isEmailVerified;
  final DateTime lastSeen;
  final DateTime createdAt;
  final DateTime updatedAt;

  final String fullName;

  FullUserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    this.birthDate,
    required this.coverImageUrl,
    required this.profileImageUrl,
    this.motivationalQuote,
    required this.disabled,
    required this.role,
    required this.status,
    required this.isEmailVerified,
    required this.lastSeen,
    required this.createdAt,
    required this.updatedAt,
  }) : fullName =
            '${firstName.toFirstUpperCase()} ${lastName.toFirstUpperCase()}';

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phoneNumber': phoneNumber,
      'birthDate': birthDate?.toIso8601String(),
      'coverImageUrl': coverImageUrl,
      'profileImageUrl': profileImageUrl,
      'motivationalQuote': motivationalQuote,
      'disabled': disabled,
      'role': role,
      'status': status,
      'isEmailVerified': isEmailVerified,
      'lastSeen': lastSeen.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'fullName': fullName,
    };
  }

  factory FullUserModel.fromMap(Map<String, dynamic> map) {
    return FullUserModel(
      id: map['id'] as String,
      firstName: (map['firstName'] as String).toFirstUpperCase(),
      lastName: (map['lastName'] as String).toFirstUpperCase(),
      email: map['email'] as String,
      phoneNumber: map['phoneNumber'] as String,
      birthDate: map['birthDate'] != null
          ? UtilFunctions.parseDateTime(map['birthDate'])
          : null,
      coverImageUrl: map['coverImageUrl'] as String,
      profileImageUrl: map['profileImage'] as String,
      motivationalQuote: map['motivationalQuote'] as String?,
      disabled: map['disabled'] as bool,
      role: map['role'] as String,
      status: map['status'] as String,
      isEmailVerified: map['isEmailVerified'] as bool,
      lastSeen: UtilFunctions.parseDateTime(map['lastSeen']),
      createdAt: UtilFunctions.parseDateTime(map['createdAt']),
      updatedAt: UtilFunctions.parseDateTime(map['updatedAt']),
    );
  }

  @override
  String toString() {
    return 'FullUserModel{id: $id, firstName: $firstName, lastName: $lastName, '
        'email: $email, phoneNumber: $phoneNumber, birthDate: $birthDate, '
        'coverImageUrl: $coverImageUrl, profileImageUrl: $profileImageUrl, '
        'motivationalQuote: $motivationalQuote, disabled: $disabled, '
        'role: $role, status: $status, isEmailVerified: $isEmailVerified, '
        'lastSeen: $lastSeen, createdAt: $createdAt, updatedAt: $updatedAt, '
        'fullName: $fullName}';
  }
}
