enum LoginResult {
  success,
  disabled,
  invalidEmail,
  wrongPassword,
  weakPassword,
  missingEmail,
  missingPassword,
  missingReenter,
  passwordMismatch,
  notFound,
  usedUsername,
  brute,
  unknownError,
}

enum PlayerType {
  solo,
  guest,
  host,
}

enum WordReason {
  notFound,
  notExist,
  tooShort,
}
