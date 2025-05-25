import 'package:uuid/uuid.dart';

/// Represents a user's progress in a course
class UserCourse {
  /// Unique identifier for this user-course relation
  final String id;

  /// The user identifier
  final String userId;

  /// The course identifier
  final String courseId;

  /// The current lesson the user is on
  final String currentLessonId;

  final Course? course;

  UserCourse({
    required this.id,
    required this.userId,
    required this.courseId,
    required this.currentLessonId,
    this.course,
  });

  /// Create a UserCourse from a JSON map
  factory UserCourse.fromJson(Map<String, dynamic> json) {
    return UserCourse(
      id: json['id'],
      userId: json['userId'],
      courseId: json['courseId'],
      currentLessonId: json['currentLessonId'],
      course: json['course'] != null ? Course.fromJson(json['course']) : null,
    );
  }

  /// Convert UserCourse to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'courseId': courseId,
      'currentLessonId': currentLessonId,
      'course': course?.toJson(),
    };
  }

  /// Create a copy of UserCourse with updated fields
  UserCourse copyWith({
    String? userId,
    String? courseId,
    String? currentLessonId,
    Course? course,
  }) {
    return UserCourse(
      id: id,
      userId: userId ?? this.userId,
      courseId: courseId ?? this.courseId,
      currentLessonId: currentLessonId ?? this.currentLessonId,
      course: course ?? this.course,
    );
  }
}

/// Represents a language learning course
class Course {
  /// Unique identifier for the course
  final String id;

  /// Display name of the course
  final String displayName;

  /// Native language of the user (what they already know)
  final String nativeLanguage;

  /// Target language the user wants to learn
  final String targetLanguage;

  Course({
    String? id,
    required this.displayName,
    required this.nativeLanguage,
    required this.targetLanguage,
  }) : id = id ?? const Uuid().v4();

  /// Create a Course from a JSON map
  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'],
      displayName: json['displayName'],
      nativeLanguage: json['nativeLanguage'],
      targetLanguage: json['targetLanguage'],
    );
  }

  /// Convert Course to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'displayName': displayName,
      'nativeLanguage': nativeLanguage,
      'targetLanguage': targetLanguage,
    };
  }

  /// Create a copy of Course with updated fields
  Course copyWith({
    String? displayName,
    String? nativeLanguage,
    String? targetLanguage,
  }) {
    return Course(
      id: id,
      displayName: displayName ?? this.displayName,
      nativeLanguage: nativeLanguage ?? this.nativeLanguage,
      targetLanguage: targetLanguage ?? this.targetLanguage,
    );
  }
}
