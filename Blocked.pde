//Casey Niu
//Major Project
//January 18th, 2017

//global variables
Game game;
int state;
PImage home, rightArrow, leftArrow, restartArrow;
PFont largeWriting, smallWriting;
TextButton startButton, howToPlay;
TextButton[] levels;
ImageButton restart, nextLevel, previousLevel, startScreenButton;
Block[] blocks;

// light F0AA2A, CA870C, A06800 dark
void setup() {
  size(600, 600);
  state = 0;
  game = new Game();

  largeWriting = createFont("Lucida Console", 50);
  smallWriting = createFont("Lucida Console", 20);

  blocks = new Block[9];

  //load images for buttons
  home = loadImage("home.png");
  home.resize(0, 95);

  rightArrow = loadImage("nextArrow.png");
  rightArrow.resize(0, 80);

  leftArrow = loadImage("backArrow.png");
  leftArrow.resize(0, 80);

  restartArrow = loadImage("restart.png");
  restartArrow.resize(0, 75);

  //call constructor for all the buttons
  startButton = new TextButton(width/2, height/2-game.tileSize, width/3, height/6, color(255, 0, 0), "PLAY");
  howToPlay = new TextButton(width/2, height/2 + game.tileSize, width/2+game.tileSize, height/6, color(255, 0, 0), "HOW TO PLAY");

  startScreenButton = new ImageButton(width-game.tileSize, height-game.tileSize-10, game.tileSize+5, game.tileSize+5, color(#F0AA2A), home);
  restart = new ImageButton (width-game.tileSize, 180, game.tileSize+5, game.tileSize+5, color(#F0AA2A), restartArrow);
  nextLevel = new ImageButton (width-game.tileSize, 290, game.tileSize+5, game.tileSize+5, color(#F0AA2A), rightArrow);
  previousLevel = new ImageButton(width-game.tileSize, 400, game.tileSize+5, game.tileSize+5, color(#F0AA2A), leftArrow);

  //buttons for level select
  levels = new TextButton[3];
  for (int i = 0; i < levels.length; i ++) {
    levels[i] = new TextButton(i*width/3 +100, height/2, 100, 100, color(#CA870C), str(i+1));
  }
} 

void draw() {
  changeButtonColours();
  game.playGame();
}

//darken the color of the button when mouse hover
void changeButtonColours() {
  restart.changeColour(color(#F0AA2A), color(#CA870C));
  nextLevel.changeColour(color(#F0AA2A), color(#CA870C));
  previousLevel.changeColour(color(#F0AA2A), color(#CA870C));
  startScreenButton.changeColour(color(#F0AA2A), color(#CA870C));
  startButton.changeColour(color(255, 0, 0), color (#9B0000));
  howToPlay.changeColour(color(255, 0, 0), color(#9B0000));
  for (TextButton thisLevel : levels) {
    thisLevel.changeColour(color(#CA870C), color(#A06800));
  }
}


void mousePressed() {
  if (startButton.hover()&&state==0) {
    state = 1;//level select
  } else if (howToPlay.hover() && state ==0) {
    state = -1;//how to play screen
  } else if (startScreenButton.hover()) {
    state = 0;//start screen
  } else if (restart.hover() ) {
    game.resetBoard();
  } else if (state == 1) { 
    for (int i =0; i < levels.length; i++) {
      if (levels[i].hover()) {
        state = i*2+2;
      }
      game.setBoard();
    }
  } else if (state == 3 || state == 5 || state ==7) { 
    state = (state+1)%7;
    game.setBoard();
  } else if (nextLevel.hover() && (state == 2 || state == 4)) {
    state +=2;
    game.setBoard();
  } else if (previousLevel.hover() && (state == 4 || state == 6)) {
    state-= 2;
    game.setBoard();
  } else if (mouseX < game.tileSize*game.columns && mouseY < game.tileSize*game.rows && (state ==2 || state == 4 || state == 6)) {
    int previousSelectedBlock=0;
    for (int i = 0; i < blocks.length; i++) {
      if (blocks[i].selected) {
        previousSelectedBlock = i;
      }
      blocks[i].selected = false;
    }
    blocks[game.selectBlock(previousSelectedBlock)].selected=true;
  }
}

void keyPressed() {
  //moving the blocks 
  for (Block thisBlock : blocks) {
    if (keyCode == RIGHT) {
      if (thisBlock.selected == true && thisBlock.direction == true) {
        thisBlock.moveRight();
      }
    } else if ( keyCode == LEFT) {
      if (thisBlock.selected == true && thisBlock.direction == true) {
        thisBlock.moveLeft();
      }
    } else if (keyCode == DOWN) {
      if (thisBlock.selected == true && thisBlock.direction == false) {
        thisBlock.moveDown();
      }
    } else if (keyCode == UP) {
      if (thisBlock.selected == true && thisBlock.direction == false) {
        thisBlock.moveUp();
      }
    }
  }
}