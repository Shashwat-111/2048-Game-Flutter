import 'dart:math';

List gameLogic({required List all, required String task}) {

  // List all = [
  //   [16, 16, 2, 0],
  //   [2, 0, 2, 2],
  //   [0, 2, 0, 4],
  //   [2, 2, 0, 2]
  // ];
  List changed = [];
  switch (task) {
    case ("L" || "l"):
      for (int i = 0; i < 4; i++) {
        List curr = all[i];
        shiftLeft(curr);
        addLeft(curr);
        shiftLeft(curr);
        changed.add(curr);
      }
    case "R"|| "r":
      for (int i = 0; i < 4; i++) {
        List curr = all[i];
        shiftRight(curr);
        addRight(curr);
        shiftRight(curr);
        changed.add(curr);
      }
    case "D"|| "d":
      {
        List up = shiftDown(all);
        up = addDown(up);
        up = shiftDown(up);
        changed = up;
      }
    case "U"|| "u":
      {
        List up = shiftUp(all);
        up = addUp(up);
        up = shiftUp(up);
        changed = up;
      }
  }
  // print(changed[0]);
  // print(changed[1]);
  // print(changed[2]);
  // print(changed[3]);
  return changed;
}

List shiftUp(List l) {
  int temp;
  for (int c = 0; c <= 3; c++) {
    for (int i = 0; i <= 3; i++) {
      if (l[i][c] == 0) {
        for (int j = (i + 1); j <= 3; j++) {
          if (l[j][c] != 0) {
            temp = l[i][c];
            l[i][c] = l[j][c];
            l[j][c] = temp;
            break;
          }
        }
      }
    }
  }
  return l;
}

List addUp(List l) {
  int temp;
  for (int c = 0; c <= 3; c++) {
    for (int k = 0; k < 3; k++) {
      if (l[k][c] == l[k + 1][c]) {
        temp = l[k][c] * 2;
        l[k][c] = temp;
        l[k + 1][c] = 0;
      }
    }
  }
  return l;
}

List shiftDown(List l) {
  int temp;
  for (int c = 0; c <= 3; c++) {
    for (int i = 3; i >= 0; i--) {
      if (l[i][c] == 0) {
        for (int j = (i - 1); j >= 0; j--) {
          if (l[j][c] != 0) {
            temp = l[i][c];
            l[i][c] = l[j][c];
            l[j][c] = temp;
            break;
          }
        }
      }
    }
  }
  return l;
}

List addDown(List l) {
  int temp;
  for (int c = 0; c <= 3; c++) {
    for (int k = 3; k > 0; k--) {
      if (l[k][c] == l[k - 1][c]) {
        temp = l[k][c] * 2;
        l[k][c] = temp;
        l[k - 1][c] = 0;
      }
    }
  }
  return l;
}

List shiftLeft(List l) {
  int temp;
  for (int i = 0; i <= 3; i++) {
    if (l[i] == 0) {
      for (int j = (i + 1); j <= 3; j++) {
        if (l[j] != 0) {
          temp = l[i];
          l[i] = l[j];
          l[j] = temp;
          break;
        }
      }
    }
  }
  return l;
}

List addLeft(List l) {
  int temp;
  for (int k = 0; k < 3; k++) {
    if (l[k] == l[k + 1]) {
      temp = l[k] * 2;
      l[k] = temp;
      l[k + 1] = 0;
    }
  }
  return l;
}

List shiftRight(List l) {
  int temp;
  for (int i = 3; i >= 0; i--) {
    if (l[i] == 0) {
      for (int j = (i - 1); j >= 0; j--) {
        if (l[j] != 0) {
          temp = l[i];
          l[i] = l[j];
          l[j] = temp;
          break;
        }
      }
    }
  }
  return l;
}

List addRight(List l) {
  int temp;
  for (int k = 3; k > 0; k--) {
    if (l[k] == l[k - 1]) {
      temp = l[k] * 2;
      l[k] = temp;
      l[k - 1] = 0;
    }
  }
  return l;
}



List getSingleList(List original) {
  List converted = [];
  for (int i = 0; i <= 3; i++) {
    for (int j = 0; j <= 3; j++) {
      converted.add(original[i][j]);
    }
  }
  return converted;
}


List randomTwoGenerator(original) {
  Random random = Random();
  List emptyCells = [];

  // Collect all empty cell positions
  for (int r = 0; r < 4; r++) {
    for (int c = 0; c < 4; c++) {
      if (original[r][c] == 0) {
        emptyCells.add([r, c]);
      }
    }
  }

  // If there are empty cells, place a 2 in one of them
  if (emptyCells.isNotEmpty) {
    int randomIndex = random.nextInt(emptyCells.length);
    List<int> cell = emptyCells[randomIndex];
    original[cell[0]][cell[1]] = 2;
  }

  return original;
}