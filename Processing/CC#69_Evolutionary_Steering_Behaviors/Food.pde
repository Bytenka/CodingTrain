class Food {
  PVector loc = new PVector();
  
  int size = 8;
  
  Food(float x, float y) {
    loc.set(x, y);    
  }
  
  void show() {
    fill (0, 255, 0);
    noStroke();
    ellipse(loc.x, loc.y, size, size);
  }
}