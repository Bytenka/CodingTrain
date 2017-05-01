class InfosBoard {
  float h, w, borders;
  float wMinusBorders;

  InfosBoard(float h_, float w_, float borders_) {
    h = h_;
    w = w_;
    borders = borders_;
    wMinusBorders = w-borders;
  }

  void show() {
    fill(150, 100);
    stroke(0);
    float untilH;
    if (debugInfos) untilH = height-borders; else untilH = 390;
    rect(borders, 250, w-borders, untilH, 10);
    pieceOfFood(20);
    pieceOfPoison(40);
    vehicle(60);
    dyingVehicle(80);
    bestVehicle(110);
    if (debugInfos) {
      FOVFood(155);
      FOVPoison(200);
      velocity(230);
      acceleration(260);
      attractFood(290);
      repelPoison(320);
    }
    fill(255, 139, 253);
    textAlign(CENTER);
    text("Click to add a randomed DNA vehicule", w/2, h - 10);
    textAlign(LEFT);
  }

  void pieceOfFood(float space) {
    Food f = new Food(borders+20, h+space);
    f.show();
    fill (255);
    text("Piece of food", f.loc.x+10, f.loc.y+5);
  }

  void pieceOfPoison(float space) {    
    Poison p = new Poison(borders+20, h+space);
    p.show();
    fill (255);
    text("Piece of poison", p.loc.x+10, p.loc.y+5);
  }

  void vehicle(float space) {    
    Vehicle p = new Vehicle(borders+30, h+space);
    p.vel.set(1, 0);
    p.show();
    fill (255);
    text("Healthy vehicle", p.loc.x+30, p.loc.y+5);
  }

  void dyingVehicle(float space) {    
    Vehicle p = new Vehicle(borders+30, h+space);
    p.health = 0;
    p.vel.set(1, 0);
    p.show();
    fill (255);
    text("Dying vehicle", p.loc.x+30, p.loc.y+5);
  }

  void bestVehicle(float space) {    
    Vehicle p = new Vehicle(borders+30, h+space);
    p.vel.set(1, 0);
    p.show();
    p.isTheBestIndicator();
    fill (255);
    text("Best vehicle", p.loc.x+30, p.loc.y+5);
  }

  void FOVFood(float space) {
    noFill();
    stroke(0, 255, 0);
    ellipse(borders+30, h+space, 40, 40);
    fill (255);
    text("FOV for food", borders+60, h+space+5);
  }

  void FOVPoison(float space) {
    noFill();
    stroke(255, 0, 0);
    ellipse(borders+30, h+space, 40, 40);
    fill (255);
    text("FOV for poison", borders+60, h+space+5);
  }

  void velocity(float space) {
    noFill();
    stroke(255, 255, 0);
    line(borders+15, h+space, borders+45, h+space);
    fill (255);
    text("Velocity vector", borders+60, h+space+5);
  }
  void acceleration(float space) {
    noFill();
    stroke(0, 0, 255);
    line(borders+15, h+space, borders+45, h+space);
    fill (255);
    text("Acceleration vector", borders+60, h+space+5);
  }
  void attractFood(float space) {
    noFill();
    stroke(0, 255, 0);
    line(borders+15, h+space, borders+45, h+space);
    fill (255);
    text("Attraction of food vector", borders+60, h+space+5);
  }
  void repelPoison(float space) {
    noFill();
    stroke(255, 0, 0);
    line(borders+15, h+space, borders+45, h+space);
    fill (255);
    text("Repultion of poison vector", borders+60, h+space+5);
  }
}