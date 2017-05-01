class Vehicle {
  int vehicleSize = 20;
  float maxDesired = 0.3;
  float makeFoodMoreImportant = 0.1;
  float maxSpeed = 3;
  float maxFOV = 300;
  float friction = 0.1;
  float healthMax = 1;
  float mutationValue = 20;
  float feedValue = 0.7;
  float poisonValue = -0.5;
  float chanceToReproduce = 0.0005;

  PVector loc = new PVector();
  PVector vel = new PVector();
  PVector acc = new PVector();
  float[] DNA;
  float health;
  int fitness = 0;
  boolean mustDie = false;

  Vehicle(float x, float y) {
    DNA = new float[2];
    loc.set(x, y);
    vel.set(random(-maxSpeed, maxSpeed), random(-maxSpeed, maxSpeed));
    health = healthMax;
    DNA[0] = random(0, maxFOV);
    DNA[1] = random(0, maxFOV);
  }

  Vehicle(float x, float y, float[] oldDNA) {
    DNA = new float[2];
    DNA[0] = oldDNA[0];
    DNA[1] = oldDNA[1];
    loc.set(x, y);
    vel.set(random(-maxSpeed, maxSpeed), random(-maxSpeed, maxSpeed));
    health = healthMax;
    DNA[0] = random(oldDNA[0]-random(-mutationValue, mutationValue), oldDNA[0]+random(-mutationValue, mutationValue));
    if (DNA[0] > maxFOV) DNA[0] = maxFOV;
    DNA[1] = random(oldDNA[1]-random(-mutationValue, mutationValue), oldDNA[1]+random(-mutationValue, mutationValue));
    if (DNA[1] > maxFOV) DNA[1] = maxFOV;
  }

  void reproduce(float x, float y) {
    vehicles.add(new Vehicle(x, y, DNA));
  }

  void update() {
    fitness++;
    vel.add(acc);
    vel.limit(maxSpeed);
    loc.add(vel);
    updateHealth(-0.002);
    if (health < 0.30)
      beWeaker();

    if (random(1) < chanceToReproduce)
      reproduce(loc.x, loc.y);

    if (debugInfos) {
      noFill();
      stroke(0, 0, 255);
      line(loc.x, loc.y, loc.x + acc.x * 200, loc.y + acc.y * 200);
      stroke(255, 255, 0);
      line(loc.x, loc.y, loc.x + vel.x * 15, loc.y + vel.y * 15);
      stroke(0, 255, 0);
      ellipse(loc.x, loc.y, DNA[0]*2, DNA[0]*2);
      stroke(255, 0, 0);
      ellipse(loc.x, loc.y, DNA[1]*2, DNA[1]*2);
    }
  }

  void updateHealth(float amount) {
    health += amount;
    if (health > healthMax)
      health = healthMax;
    if (health <= 0)
      mustDie = true;
  }

  void eat() {
    for (int i = foods.size()-1; i >= 0; i--) {
      Food c = foods.get(i);
      float d =  dist(loc.x, loc.y, c.loc.x, c.loc.y);
      if (d <= hitBoxOfTheFood) {
        foods.remove(i);
        updateHealth(feedValue);
        beStronger();
      }
    }

    for (int i = poisons.size()-1; i >= 0; i--) {
      Poison c = poisons.get(i);
      float d =  dist(loc.x, loc.y, c.loc.x, c.loc.y);
      if (d <= hitBoxOfTheFood) {
        poisons.remove(i);
        updateHealth(poisonValue);
        beWeaker();
      }
    }
  }

  void beWeaker() {
    if (random(1) < 0.5)
      healthMax /= 2;
    updateHealth(0);
  }

  void beStronger() {
    if (random(1) < 0.5)
      healthMax += 0.1;
  }

  PVector findClosest() {
    int iOfClosestFood = -1;
    int iOfClosestPoison = -1;
    float recordFood = height;
    float recordPoison = height;

    for (int i = 0; i < foods.size(); i++) {
      Food c = foods.get(i);
      float d = dist(loc.x, loc.y, c.loc.x, c.loc.y);
      if (d <= DNA[0]) {
        if (d < recordFood) {
          iOfClosestFood = i;
          recordFood = d;
        }
      }
    }

    for (int i = 0; i < poisons.size(); i++) {
      Poison c = poisons.get(i);
      float d = dist(loc.x, loc.y, c.loc.x, c.loc.y);
      if (d <= DNA[1]) {
        if (d < recordPoison) {
          iOfClosestPoison = i;
          recordPoison = d;
        }
      }
    }
    PVector v;
    v = new PVector(iOfClosestFood, iOfClosestPoison);

    return v;
  }

  void seek() {
    PVector desiredDir = new PVector();
    PVector desiredFood = new PVector();
    PVector desiredPoison = new PVector();
    PVector closestFood;
    PVector closestPoison;

    if (loc.x > edges && loc.x < width-edges && loc.y > edges && loc.y < height-edges) {
      PVector thesesTargets = findClosest();
      if (thesesTargets.x > -1) {
        closestFood = new PVector(foods.get(int(thesesTargets.x)).loc.x, foods.get(int(thesesTargets.x)).loc.y);
      } else closestFood = new PVector(loc.x, loc.y);
      if (thesesTargets.y > -1) {
        closestPoison = new PVector(poisons.get(int(thesesTargets.y)).loc.x, poisons.get(int(thesesTargets.y)).loc.y);
      } else closestPoison = new PVector(loc.x, loc.y);

      desiredFood = closestFood.sub(loc);
      desiredPoison = closestPoison.sub(loc);

      desiredFood.setMag(maxDesired+makeFoodMoreImportant);
      desiredPoison.setMag(maxDesired);

      desiredDir = desiredFood.sub(desiredPoison);
      applyForce(desiredDir);
      
      if (debugInfos) {
        desiredPoison.mult(-1);
        stroke(0, 255, 0);
        line(loc.x, loc.y, loc.x+desiredFood.x*100, loc.y+desiredFood.y*100);
        stroke(255, 0, 0);
        line(loc.x, loc.y, loc.x+desiredPoison.x*100, loc.y+desiredPoison.y*100);
      }
    } else {
      PVector getAwayFrom = new PVector();
      if (loc.x < edges)        getAwayFrom.set(0, loc.y);
      if (loc.x > width-edges)  getAwayFrom.set(0, loc.y);
      if (loc.y < edges)        getAwayFrom.set(loc.x, 0);
      if (loc.y > height-edges) getAwayFrom.set(loc.x, 0);
      desiredDir = getAwayFrom.sub(loc);
      desiredDir.setMag(maxDesired);
      applyForce(desiredDir);
    }
  }

  void applyForce(PVector f) {
    acc.set(f);
    applyFriction();
  }

  void applyFriction() {
    if (vel.x > 0)
      vel.x -= friction;
    if (vel.y > 0)
      vel.y -= friction;
    if (vel.x < 0)
      vel.x += friction;
    if (vel.y < 0)
      vel.y += friction;
  }

  void show() {
    noStroke();
    color gr = color(0, 255, 0);
    color rd = color(255, 0, 0);
    float displayHealth = map(health, 0, 1, 0, health);
    color col = lerpColor(rd, gr, displayHealth);
    fill(col);

    PVector orientation = new PVector(vel.x, vel.y);
    orientation.setMag(vehicleSize);
    PShape s;
    s = createShape();
    s.beginShape();
    s.vertex(orientation.x, orientation.y);
    orientation.rotate(7*PI/8);
    s.vertex(orientation.x, orientation.y);
    orientation.rotate(+2*PI/8);
    s.vertex(orientation.x, orientation.y);
    s.endShape(CLOSE);
    shape(s, loc.x, loc.y);
  }
  
  void isTheBestIndicator() {
    stroke(203, 0, 177);
    fill(255, 50);
    ellipse(loc.x, loc.y, vehicleSize*2, vehicleSize*2);
  }
}