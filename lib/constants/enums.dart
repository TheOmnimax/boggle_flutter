String getEnumName(dynamic original) {
  final enumString = original.toString();
  final splitEnum = enumString.split('.');
  if (splitEnum.length < 2) {
    return 'Invalid enum';
  }

  final splitWords = splitEnum[1].split(RegExp(r'(?=[A-Z])'));
  splitWords[0] = splitWords[0].substring(0, 1).toUpperCase() +
      splitWords[0].substring(
        1,
      );
  for (var w = 1; w < splitWords.length; w++) {
    splitWords[w] = splitWords[w].substring(0, 1).toLowerCase() +
        splitWords[w].substring(
          1,
        );
  }

  return splitWords.join(' ');
}

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

enum GameStatus {
  pre,
  during,
  post,
}

enum LoadingStatus {
  working,
  ready,
  warning,
  error,
}
