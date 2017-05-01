class HideShow {
  PVector loc = new PVector();
  float sizeX = 15;
  float sizeY = 30;
  float oldX;
  boolean display = true;

  HideShow(float x, float y) {
    loc.set(x, y);
    oldX = x;
  }

  void show() {
    if (!display) loc.x = 0; else loc.x = oldX;
      stroke(0);
      fill(255, 100);
      rect(loc.x, loc.y, loc.x+sizeX, loc.y+sizeY, 0, 5, 5, 0);
      line(loc.x+sizeX/3, loc.y+4, loc.x+sizeX/3, loc.y+sizeY-4);
      line(loc.x+2*sizeX/3, loc.y+4, loc.x+2*sizeX/3, loc.y+sizeY-4);
  }

  boolean click() {
    if (mouseX > loc.x && mouseX < loc.x+sizeX && mouseY > loc.y && mouseY < loc.y+sizeY) {
      if (display) display = false;
      else display = true;
      return true;
    }
    return false;
  }
}