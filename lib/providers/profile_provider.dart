import 'package:flutter/material.dart';
import '../models/user_profile.dart';

class ProfileProvider extends ChangeNotifier {
  UserProfile _user = UserProfile(
    id: 'u101',
    name: 'Ajay Babu',
    email: 'ajay.babu@example.com',
    phone: '+91 9643589226',
    address: 'Kakrala road near mandi samiti Budaun Woodcraft Avenue, Suite 3B, Budaun, KA 560001',
    profileImagePath: null,
    avatarPreset: 'teal',
  );

  bool _isEditing = false;

  UserProfile get user => _user;
  bool get isEditing => _isEditing;

  void setEditing(bool editing) {
    _isEditing = editing;
    notifyListeners();
  }

  void updateProfile({
    required String name,
    required String email,
    required String phone,
    required String address,
    String? profileImagePath,
    String? avatarPreset,
  }) {
    _user = _user.copyWith(
      name: name,
      email: email,
      phone: phone,
      address: address,
      profileImagePath: profileImagePath ?? _user.profileImagePath,
      avatarPreset: avatarPreset ?? _user.avatarPreset,
    );
    _isEditing = false;
    notifyListeners();
  }

  void updateProfileImage(String pathOrPreset, {bool isCustomFile = false}) {
    if (isCustomFile) {
      _user = _user.copyWith(profileImagePath: pathOrPreset);
    } else {
      _user = _user.copyWith(avatarPreset: pathOrPreset, profileImagePath: null);
    }
    notifyListeners();
  }
}
