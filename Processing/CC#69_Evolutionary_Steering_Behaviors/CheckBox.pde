class CheckBox {
  PVector loc = new PVector();
  float size = 15;
  boolean checked = false;
  String message;

  CheckBox(float x, float y, String s) {
    loc.set(x, y);
    message = s;
  }
  CheckBox(float x, float y, String s, boolean isChecked) {
    checked = isChecked;
    loc.set(x, y);
    message = s;
  }

  void show() {
    fill(100);
    stroke(0);
    rect(loc.x, loc.y, loc.x+size, loc.y+size, 2);

    if (checked) {
      stroke(0);
      line(loc.x, loc.y, loc.x+size, loc.y+size);
      line(loc.x, loc.y+size, loc.x+size, loc.y);
    }
    textSize(14);
    fill(0, 209, 189);
    text(message, loc.x+size+10, loc.y+size-2);
  }

  boolean click() {
    if (mouseX > loc.x && mouseX < loc.x+size && mouseY > loc.y && mouseY < loc.y+size) {
      if (checked) checked = false;
      else checked = true;
      return true;
    }
    return false;
  }
}