class DataBar {
  PVector loc = new PVector();
  float w = 130;
  float borders;
  float ownBorders = 10;

  DataBar(float borders_, float y) {
    borders = borders_;
    loc.set(0, y);
  }

  int findTheBest() {
    int record = 0;
    int idOfTheBest = 0;
    for (int i = 0; i < vehicles.size(); i++) {
      Vehicle v = vehicles.get(i);
      if (record < v.fitness) {
        record = v.fitness;
        idOfTheBest = i;
      }
    }
    if (bestFitness < record) bestFitness = record;
    return idOfTheBest;
  }

  int findTheBestHealth() {
    float record = 0;
    int idOfTheBest = 0;
    for (int i = 0; i < vehicles.size(); i++) {
      Vehicle v = vehicles.get(i);
      if (record < v.health) {
        record = v.health;
        idOfTheBest = i;
      }
    }
    return idOfTheBest;
  }

  void show() {
    fill(247, 154, 2, 100);
    noStroke();
    rect(loc.x+borders, loc.y, loc.x+ui.w-borders, loc.y+w);
    int idOfTheBest = findTheBest();
    displayBestVehicle(idOfTheBest);
    displayMaxBestVehicle(20);
    displayBestHealth(idOfTheBest, 40);
    displayBestHealthMax(idOfTheBest, 60);
    displayNbOfGen(80);
    displayNbOfVehicles(100);
    //displaySeparatingLine(90);
  }

  void displayBestVehicle(int best) {
    fill(255);
    text("Current best vehicle: " + vehicles.get(best).fitness, loc.x+borders+ownBorders, loc.y+borders+ownBorders);
    vehicles.get(best).isTheBestIndicator();
  }

  void displayMaxBestVehicle(int space) {
    fill(255);
    text("Best fitness: " + bestFitness, loc.x+borders+ownBorders, loc.y+borders+ownBorders+space);
  }

  void displayBestHealth(int best, int space) {
    fill(255);
    text("Health of the best: " + vehicles.get(best).health, loc.x+borders+ownBorders, loc.y+borders+ownBorders+space);
  }

  void displayBestHealthMax(int best, int space) {
    fill(255);
    text("Max health of the best: " + vehicles.get(best).healthMax, loc.x+borders+ownBorders, loc.y+borders+ownBorders+space);
  }

  void displayNbOfGen(int space) {
    fill(255);
    text("Generation n°: " + generations, loc.x+borders+ownBorders, loc.y+borders+ownBorders+space);
  }

  void displayNbOfVehicles(int space) {
    fill(255);
    text("Number of vehicles: " + vehicles.size(), loc.x+borders+ownBorders, loc.y+borders+ownBorders+space);
  }

  //void displaySeparatingLine(int space) {
  //  stroke(0);
  //  line(loc.x+borders+ownBorders*2, loc.y+borders+ownBorders+space, loc.x+w-borders-ownBorders*2, loc.y+borders+ownBorders+space);
  //}
}