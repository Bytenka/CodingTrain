ArrayList<Vehicle> vehicles;
ArrayList<Food> foods;
ArrayList<Poison> poisons;
float[] create;
int bestFitness = 0;
boolean debugInfos;
int generations = 1;
UI ui;

int edges = 0;              // Used to control the size of the area;
int hitBoxOfTheFood = 8;
float foodGenProba = 0.06;
float poisonGenProba = 0.05; // Chances if a piece of food has been generated

void setup() {
  size(1200, 600);
  rectMode(CORNERS);
  ui = new UI(0, 0, 300);

  vehicles = new ArrayList<Vehicle>();
  foods = new ArrayList<Food>();
  poisons = new ArrayList<Poison>();

  for (int i = 0; i < 10; i++) {
    vehicles.add(new Vehicle(random(width), random(height)));
  }

  for (int i = 0; i < 100; i++) {
    genFood();
    if (random(1) < 0.5) genPoison();
  }
}

void draw() {
    background(51);

    for (int i = 0; i < foods.size(); i++) {
      Food c = foods.get(i);
      c.show();
    }

    for (int i = 0; i < poisons.size(); i++) {
      Poison c = poisons.get(i);
      c.show();
    }

    for (int i = vehicles.size()-1; i >= 0; i--) {
      Vehicle v = vehicles.get(i);
      v.eat();
      v.seek();
      v.update();
      if (v.mustDie) vehicles.remove(i);
      else v.show();
    }

    if (random(1) < foodGenProba) {
      genFood();
      if (random(1) < poisonGenProba)
        genPoison();
    }

    if (foods.size() <= 5) genFood();
    if (poisons.size() <= 2) genPoison();
    if (vehicles.size() == 0) {vehicles.add(new Vehicle(random(width), random(height))); generations++;}

    ui.show();
    debugInfos = ui.debug.checked;
}

void genFood() {
  if (ui.genNewFood.checked || foods.size() <= 2) foods.add(new Food(random(edges+50, width-(edges+50)), random(edges+50, height-(edges+50))));
}

void genPoison() {
  if (ui.genNewPoison.checked || poisons.size() <= 2) poisons.add(new Poison(random(edges+50, width-(edges+50)), random(edges+50, height-(edges+50))));
}

void mouseReleased() {              // Check if the mouse is on a CheckBox or on the rectract-arrow.
  boolean debug = ui.debug.click();
  boolean genNewFood = ui.genNewFood.click();
  boolean genNewPoison = ui.genNewPoison.click();
  boolean arrow = ui.arrow.click();
  if (!debug && !genNewFood && !genNewPoison && !arrow) vehicles.add(new Vehicle(mouseX, mouseY));
}

void keyPressed() {                                       // For debuging/fun.
  if (key == 'f') foods.add(new Food(mouseX, mouseY));
  if (key == 'p') poisons.add(new Poison(mouseX, mouseY));
  if (key == 'c') {
    for (int i = foods.size()-1; i > 0; i--) foods.remove(i);
    for (int i = poisons.size()-1; i > 0; i--) poisons.remove(i);
  }
}