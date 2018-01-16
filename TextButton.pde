class TextButton extends Button {
  //data
  String writing;
  //constructor
  TextButton(float _x, float _y, float _buttonWidth, float _buttonHeight, color _colour, String _writing) {
    super(_x, _y, _buttonWidth, _buttonHeight, _colour);//calling parent class
    writing = _writing;
  }
  //behavior
  void display() {
    stroke(0);
    rectMode(CENTER);
    fill(colour);
    strokeWeight(3);
    rect(x, y, buttonWidth, buttonHeight, 100);
    textAlign(CENTER, CENTER);
    textFont(largeWriting);
    fill(0);
    text(writing, x, y);
  }
}