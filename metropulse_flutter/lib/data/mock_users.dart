/// Demo login accounts for the prototype — there is no real backend, so
/// authentication is just a match against this fixed list.
enum UserRole { citizen, teknik, ibb }

class MockUser {
  final String name;
  final List<String> identifiers; // email and/or phone, any of which work
  final String password;
  final UserRole role;
  const MockUser({required this.name, required this.identifiers, required this.password, required this.role});

  String get roleLabel => switch (role) {
        UserRole.citizen => 'Vatandaş',
        UserRole.teknik => 'Teknik Ekip',
        UserRole.ibb => 'İBB Personeli',
      };
}

const List<MockUser> mockUsers = [
  MockUser(
    name: 'Selin',
    identifiers: ['selin@gmail.com', '05555555555'],
    password: '1234',
    role: UserRole.citizen,
  ),
  MockUser(
    name: 'Hasan',
    identifiers: ['hasan@ibbteknik.com'],
    password: '1234',
    role: UserRole.teknik,
  ),
  MockUser(
    name: 'Elif Büyük',
    identifiers: ['elifbuyuk@ibbpersonel.com'],
    password: '1234',
    role: UserRole.ibb,
  ),
];

String _normalize(String v) => v.trim().toLowerCase().replaceAll(RegExp(r'[\s()\-]'), '');

/// Returns the matching account for [identifier]/[password], or null if
/// there isn't one — the caller shows "Kullanıcı adı veya şifre hatalı".
MockUser? findMockUser(String identifier, String password) {
  final normId = _normalize(identifier);
  final normPass = password.trim();
  if (normId.isEmpty || normPass.isEmpty) return null;
  for (final u in mockUsers) {
    if (u.password != normPass) continue;
    if (u.identifiers.any((id) => _normalize(id) == normId)) return u;
  }
  return null;
}
