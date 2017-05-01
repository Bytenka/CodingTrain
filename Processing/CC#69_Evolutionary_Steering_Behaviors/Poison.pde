class Poison {
  PVector loc = new PVector();

  int size = 8;

  Poison(float x, float y) {
    loc.set(x, y);
  }

  void show() {
    fill (255, 0, 0);
    noStroke();
    ellipse(loc.x, loc.y, size, size);
  }
}