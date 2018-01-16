class Game {
  //data
  int rows, columns;
  int[][] board;
  float[] blockColors;
  int tileSize, moves;

  //constructor
  Game() {
    tileSize = 75;
    rows = 6;
    columns = 6;
    moves = 0;
    board = new int[columns][rows];

    //array of grey scale values to color the ordinary blocks
    blockColors = new float[10];
    for (int i = 0; i < blockColors.length; i++) {
      blockColors[i] = random(230);
    }
  }
  
  //behavior
  void playGame() {
    if (state == 0) {
      background(#FFC354);
      startScreen();
    } else if (state == -1) {
      background(#FFC354);
      howToPlayScreen();
    } else if (state == 1) {
      background(#FFC354);
      levelSelect();
      startScreenButton.display();
    } else if (state == 2) {
      background(#FFC354);
      gameScreen();
      textFont(largeWriting);
      fill(#FFD17C);
      text("LEVEL 1", 150, 550);
    } else if (state == 3 || state == 5 || state == 7) {
      winScreen();
      textFont(largeWriting);
      fill(#CA870C);
      text("YOU WIN!", width/2, height/2-tileSize);
      textFont(smallWriting);
      text("You completed the puzzle in " + moves + " moves", width/2, height/2);
      text("Click anywhere to continue", width/2, height/2+tileSize);
    } else if (state == 4) {
      background(#FFC354);
      gameScreen();
      textFont(largeWriting);
      fill(#FFD17C);
      text("LEVEL 2", 150, 550);
    } else if (state == 6) {
      background(#FFC354);
      gameScreen();
      textFont(largeWriting);
      fill(#FFD17C);
      text("LEVEL 3", 150, 550);
    }
  }

  void drawTiles() {
    //draw large rectanlge around enitre gird
    rectMode(CORNERS);
    noFill();
    stroke(0);
    rect(0, 0, tileSize*rows, tileSize*columns);
    //draw each individual rectangle of the grid
    for (int x = 0; x < columns; x++) {
      for (int y = 0; y < rows; y ++) {
        colourTiles(x, y);
        noStroke();
        rect(x*tileSize, y*tileSize, x*tileSize + tileSize, y *tileSize + tileSize, 10);
      }
    }
  }

  void gameScreen() {
    startScreenButton.display();
    restart.display();
    nextLevel.display();
    previousLevel.display();
    displayMoves();
    drawTiles();
    if (win()) {
      state+=1;
    }
  }

  void startScreen() {
    startButton.display();
    howToPlay.display();
  }

  void levelSelect() {
    textFont(largeWriting);
    fill(0);
    text("SELECT A LEVEL", width/2, height/4);
    for (TextButton thisLevel : levels) {
      thisLevel.display();
    }
  }

  void howToPlayScreen() {
    startScreenButton.display();
    fill(0);
    textFont(largeWriting);
    textAlign(CENTER, CENTER);
    text("HOW TO PLAY", width/2, 80);
    textFont(smallWriting);
    text("The object of the game is to move the", width/2, 150);
    text("red block to the right side of the grid", width/2, 200);
    text("by moving the other blocks around it.", width/2, 250);
    text("Click on a block to select it,", width/2, 350);
    text("then use the arrow keys to move it.", width/2, 400);
  }

  void colourTiles(int x, int y) {
    if (board[x][y] == 1) {
      fill(255, 0, 0);
    } else if (board[x][y] == 0) {
      fill(#FFD17C);//empty colour
    } else {
      fill(blockColors[board[x][y]]);
    }
    if (board[x][y] > 0) {
      if (blocks [board[x][y]-1].selected) {
        fill(#A06800);
      }
    }
  }

  void displayMoves() {
    fill(#F0AA2A);
    stroke(0);
    rectMode(CENTER);
    rect(width-tileSize, tileSize-5, tileSize+5, tileSize+5);
    textFont(smallWriting);
    textAlign(CENTER, CENTER);
    fill(0);
    text("MOVES:", width-tileSize+2, 45);
    textFont(largeWriting);
    text(moves, width-tileSize, 80);
  }

  void resetBoard() {
    for (int x = 0; x < columns; x ++) {
      for (int y = 0; y < rows; y ++) {
        board[x][y] = 0;
      }
    }
    for (Block thisBlock : blocks) {
      thisBlock.reset();
    }
    moves = 0;
  }

  int selectBlock(int previous) {
    int mousePressedX = int(mouseX/tileSize);
    int mousePressedY = int (mouseY/tileSize);
    int blockNumber = board[mousePressedX][mousePressedY];
    if (blockNumber > 0) {
      return blockNumber-1;
    }
    return previous;
  }

  boolean win() {
    if (board[5][2] == 1) {
      return true;
    }
    return false;
  }

  void winScreen() {
    //using the pixels array cuz im fancy
    loadPixels();
    for (int i = 0; i < width*height; i++) {
      color thisPixelColor = pixels[i];
      float r = red(thisPixelColor);
      float g = green(thisPixelColor);
      float b = blue(thisPixelColor);

      color newColor = color(r+10, b+17, g+7);
      pixels[i] = newColor;
    }
    updatePixels();

    int stars = 0;
    if (moves<=55) {
      stars = 2;
    } else if (moves<=80) {
      stars = 1;
    } else {
      stars = 0;
    }
    float x = width/2 + (40*(stars-1));
    float y = height/2 - 2*tileSize;
    drawStars(stars, x, y);
  }

  void setBoard() {
    if (state==2) {
      setLevelOne();
      resetBoard();
    } else if (state == 4) {
      setLevelTwo();
      resetBoard();
    } else if (state == 6) {
      setLevelThree();
      resetBoard();
    }
  }

  void drawStars(int num, float x, float y) {
    noStroke();
    fill(#F0AA2A);
    triangle(x, y, x+10, y+20, x -10, y+20);
    triangle(x, y+25, x+10, y +5, x-10, y+5);
    if (num > 0) {
      //could have just used a for loop, but recursion looks more impressive
      drawStars(num-1, width/2 + (40*(num-2)),height/2 - 2*tileSize);
    }
  }

  //functions to set levels
  void setLevelThree() {
    int[] one = {1, 2, 2, 2};
    blocks[0] = new Block(one, true, 1);
    int[] two = {0, 0, 0, 1, 0, 2};
    blocks[1] = new Block(two, false, 2);
    int[] three = { 0, 3, 1, 3, 2, 3};
    blocks[2] = new Block(three, true, 3);
    int[] four = {2, 4, 2, 5};
    blocks[3] = new Block(four, false, 4);
    int[] five = {3, 5, 4, 5};
    blocks[4] = new Block (five, true, 5);
    int[] six = {3, 1, 3, 2};
    blocks[5] = new Block(six, false, 6);
    int[] seven = {3, 0, 4, 0, 5, 0};
    blocks[6] = new Block(seven, true, 7);
    int[] eight = {3, 3, 3, 4};
    blocks[7] = new Block(eight, false, 8);
    int[] nine = {5, 1, 5, 2, 5, 3};
    blocks[8] = new Block(nine, false, 9);
  }

  void setLevelTwo() {
    int[] one = {0, 2, 1, 2};
    blocks[0] = new Block(one, true, 1);
    int[] two = {0, 3, 0, 4};
    blocks[1] = new Block(two, false, 2);
    int[] three = {1, 4, 2, 4, 3, 4};
    blocks[2] = new Block(three, true, 3);
    int[] four = {2, 1, 2, 2};
    blocks[3] = new Block(four, false, 4);
    int[] five = {4, 1, 5, 1};
    blocks[4] = new Block(five, true, 5);
    int[] six = {3, 0, 3, 1};
    blocks[5] = new Block(six, false, 6);
    int[] seven = {3, 2, 3, 3};
    blocks[6] = new Block(seven, false, 7);
    int[] eight = {4, 2, 4, 3};
    blocks[7] = new Block(eight, false, 8);
    int[] nine={4, 4, 4, 5};
    blocks[8] = new Block(nine, false, 9);
  }

  void setLevelOne() {
    int[] one = {0, 2, 1, 2};
    blocks[0] = new Block(one, true, 1);
    int[] two = {0, 4, 0, 5};
    blocks[1] = new Block(two, false, 2);
    int[] three = {0, 3, 1, 3};
    blocks[2] = new Block(three, true, 3);
    int[] four = {2, 0, 2, 1, 2, 2};
    blocks[3] = new Block(four, false, 4);
    int[] five = {1, 4, 2, 4};
    blocks[4] = new Block(five, true, 5);
    int[] six = {3, 1, 3, 2};
    blocks[5] = new Block(six, false, 6);
    int[] seven = {1, 5, 2, 5, 3, 5};
    blocks[6] = new Block(seven, true, 7);
    int[] eight = {3, 3, 3, 4};
    blocks[7] = new Block(eight, false, 8);
    int[] nine={5, 2, 5, 3, 5, 4};
    blocks[8] = new Block(nine, false, 9);
  }
}