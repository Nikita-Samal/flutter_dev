import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../core/network/api_client.dart';
import '../../models/user_profile_model.dart';

/// Contract for fetching and persisting user profiles remotely (CRUD + Streams)
abstract class UserRemoteDataSource {
  /// Fetches the profile document for [userId]
  Future<UserProfileModel?> getUserProfile(String userId);

  /// Emits real-time updates whenever the user profile changes in remote storage
  Stream<UserProfileModel?> watchUserProfile(String userId);

  /// Creates or replaces the user profile in remote storage
  Future<void> saveUserProfile(UserProfileModel profile);

  /// Updates specific fields of the user profile
  Future<void> updateUserProfile(String userId, Map<String, dynamic> data);

  /// Deletes the user profile from remote storage
  Future<void> deleteUserProfile(String userId);

  /// Backwards-compatible generic fetch for the current user
  Future<UserProfileModel> fetchUserProfile();
}

/// Firebase Cloud Firestore implementation of [UserRemoteDataSource]
class FirebaseUserRemoteDataSource implements UserRemoteDataSource {
  final FirebaseFirestore _firestore;
  final FirebaseAuth? _auth;

  static const String collectionPath = 'users';

  FirebaseUserRemoteDataSource({
    FirebaseFirestore? firestore,
    FirebaseAuth? auth,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _auth = auth;

  CollectionReference<Map<String, dynamic>> get _usersCollection =>
      _firestore.collection(collectionPath);

  @override
  Future<UserProfileModel?> getUserProfile(String userId) async {
    final docSnapshot = await _usersCollection.doc(userId).get();
    if (!docSnapshot.exists || docSnapshot.data() == null) {
      return null;
    }
    return UserProfileModel.fromFirestore(docSnapshot);
  }

  @override
  Stream<UserProfileModel?> watchUserProfile(String userId) {
    return _usersCollection.doc(userId).snapshots().map((snapshot) {
      if (!snapshot.exists || snapshot.data() == null) {
        return null;
      }
      return UserProfileModel.fromFirestore(snapshot);
    });
  }

  @override
  Future<void> saveUserProfile(UserProfileModel profile) async {
    await _usersCollection.doc(profile.id).set(
          profile.toFirestore(),
          SetOptions(merge: true),
        );
  }

  @override
  Future<void> updateUserProfile(String userId, Map<String, dynamic> data) async {
    final enrichedData = Map<String, dynamic>.from(data);
    enrichedData['updated_at'] = FieldValue.serverTimestamp();
    await _usersCollection.doc(userId).update(enrichedData);
  }

  @override
  Future<void> deleteUserProfile(String userId) async {
    await _usersCollection.doc(userId).delete();
  }

  @override
  Future<UserProfileModel> fetchUserProfile() async {
    final currentUid = _auth?.currentUser?.uid;
    if (currentUid == null) {
      throw Exception('No authenticated user session found.');
    }
    final profile = await getUserProfile(currentUid);
    if (profile == null) {
      throw Exception('User profile document not found in Firestore.');
    }
    return profile;
  }
}

/// HTTP/ApiClient-based fallback implementation of [UserRemoteDataSource]
class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final ApiClient _apiClient;

  UserRemoteDataSourceImpl(this._apiClient);

  @override
  Future<UserProfileModel?> getUserProfile(String userId) async {
    final response = await _apiClient.get<Map<String, dynamic>>('/user/profile/$userId');
    if (response.data == null) return null;
    return UserProfileModel.fromJson(response.data!);
  }

  @override
  Stream<UserProfileModel?> watchUserProfile(String userId) {
    return Stream.fromFuture(getUserProfile(userId));
  }

  @override
  Future<void> saveUserProfile(UserProfileModel profile) async {
    await _apiClient.post<Map<String, dynamic>>(
      '/user/profile',
      data: profile.toJson(),
    );
  }

  @override
  Future<void> updateUserProfile(String userId, Map<String, dynamic> data) async {
    await _apiClient.patch<Map<String, dynamic>>(
      '/user/profile/$userId',
      data: data,
    );
  }

  @override
  Future<void> deleteUserProfile(String userId) async {
    await _apiClient.delete<Map<String, dynamic>>('/user/profile/$userId');
  }

  @override
  Future<UserProfileModel> fetchUserProfile() async {
    final response = await _apiClient.get<Map<String, dynamic>>('/user/profile');
    return UserProfileModel.fromJson(response.data!);
  }
}
