class Button {
  //data
  float x, y, buttonHeight, buttonWidth;
  color colour;

  //construcor
  Button(float _x, float _y, float _buttonWidth, float _buttonHeight, color _colour) {
    x = _x; 
    y = _y;
    buttonHeight = _buttonHeight;
    buttonWidth = _buttonWidth;
    colour = _colour;
  }
  //behavior

  boolean hover() {
    if (mouseX > x - buttonWidth/2 && mouseX < x + buttonWidth/2 && mouseY > y - buttonHeight/2 && mouseY < y + buttonHeight/2) {
      return true;
    }
    return false;
  }
  
  void changeColour(color _colour, color newColour) {
    if (hover()) {
      colour = newColour;
    } else {
      colour = _colour;
    }
  }

}