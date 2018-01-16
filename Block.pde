class Block {
  //data
  int size, blockNumber;
  int[] whichCells, initialCells;
  boolean direction, selected;
  //construtor
  Block( int[] _whichCells, boolean _direction, int _blockNumber) {
    size = 60;
    blockNumber = _blockNumber;
    whichCells = _whichCells;//this array will change with the position of the block
    initialCells = _whichCells;//this array is saved for when the user clicks reset
    direction = _direction; //true = horizontal movement , false = vertical movement 
    selected = false;
    for (int i = 0; i < (whichCells.length-1); i+=2) {
      game.board[ whichCells[i] ] [ whichCells[i+1] ] = blockNumber;
    }
  }

  //behavior
  void update() {
    for (int i = 0; i < (whichCells.length-1); i+=2) {
      game.board[ whichCells[i] ] [ whichCells[i+1] ] = blockNumber;
    }
  }

  void moveRight() {
    //change the whichCells array
    int[] nextTurn = new int[whichCells.length];
    for (int i = 0; i < whichCells.length; i ++) {
      if (i%2 == 0) {
        nextTurn[i] = whichCells[i] +1;
      } else {
        nextTurn[i] = whichCells[i];
      }
    }

    if (canMove(nextTurn, nextTurn.length-2, nextTurn.length-2, nextTurn.length-1)) {
      game.board [ whichCells[0] ] [ whichCells [1] ] = 0;
      whichCells = nextTurn;
      game.moves++;
      update();
    }
  }

  void moveLeft() {
    //change the whichCells array
    int[] nextTurn = new int[whichCells.length];
    for (int i = 0; i < whichCells.length; i ++) {
      if (i%2 == 0) {
        nextTurn[i] = whichCells[i] -1;
      } else {
        nextTurn[i] = whichCells[i];
      }
    }

    if (canMove(nextTurn, 0, 0, 1)) {
      game.board [ whichCells[whichCells.length-2] ] [ whichCells [whichCells.length-1] ] = 0;
      whichCells = nextTurn;
      game.moves++;
      update();
    }
  }

  void moveUp() {
    //change the whichCells array
    int[] nextTurn = new int[whichCells.length];
    for (int i = 0; i < whichCells.length; i ++) {
      if (i%2 != 0) {
        nextTurn[i] = whichCells[i] -1;
      } else {
        nextTurn[i] = whichCells[i];
      }
    }

    if (canMove(nextTurn, 1, 0, 1)) {
      game.board [ whichCells[whichCells.length-2] ] [ whichCells [whichCells.length-1] ] = 0;
      whichCells = nextTurn;
      game.moves++;
      update();
    }
  }

  void moveDown() {
    //change the whichCells array
    int[] nextTurn = new int[whichCells.length];
    for (int i = 0; i < whichCells.length; i ++) {
      if (i%2 != 0) {
        nextTurn[i] = whichCells[i] +1;
      } else {
        nextTurn[i] = whichCells[i];
      }
    }

    if (canMove(nextTurn, nextTurn.length-1, nextTurn.length-2, nextTurn.length-1)) {
      game.board [ whichCells[0] ] [ whichCells [1] ] = 0;
      whichCells = nextTurn;
      game.moves++;
      update();
    }
  }

  void reset() {
    whichCells = initialCells;
    selected = false;
    update();
  }

  boolean canMove(int[] nextTurn, int i, int x, int y) {
    // i = the element in the array that is possibly out of bound
    // [x][y] = adjacent position in the array to check
    if (nextTurn[i] > game.rows-1 || nextTurn[i] <0) {
      return false;
    } else if (nextTurn[i] < game.rows || nextTurn[i] >-1) {
      if (game.board[(nextTurn[x])][nextTurn[y]] !=0) {
        return false;
      }
    }
    //the block can be moved
    return true;
  }
  
}