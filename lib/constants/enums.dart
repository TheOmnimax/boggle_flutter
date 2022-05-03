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
  tooShort,
  notFound,
  notAWord,
  sharedWord,
  noTime,
  alreadyAdded,
  unknown,
}
