class UserProfile {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String address;
  final String? profileImagePath;
  final String avatarPreset; // Fallback avatar color/preset identifier

  UserProfile({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    this.profileImagePath,
    this.avatarPreset = 'default_teal',
  });

  UserProfile copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? address,
    String? profileImagePath,
    String? avatarPreset,
  }) {
    return UserProfile(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      profileImagePath: profileImagePath ?? this.profileImagePath,
      avatarPreset: avatarPreset ?? this.avatarPreset,
    );
  }
}
