class ImageButton extends Button {
  //data
  PImage image;
  //constructor
  ImageButton(float _x, float _y, float _buttonWidth, float _buttonHeight, color _colour, PImage _image) {
    super(_x, _y, _buttonWidth, _buttonHeight, _colour);//calling parent class
    image = _image;
  }
  //behavior
  void display() {
    stroke(0);
    rectMode(CENTER);
    fill(colour);
    rect(x, y, buttonWidth, buttonHeight);
    imageMode(CENTER);
    image(image, x, y);
  }
}