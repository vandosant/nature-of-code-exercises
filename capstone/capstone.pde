Mover w, w1, w2, w3;
PVector windEast, windWest;
float wind_offset;
Mover[] Movers1 = new Mover[int(random(5,33))];
Mover[] Movers2 = new Mover[int(random(5,33))];
Mover[] Movers3 = new Mover[int(random(5,33))];
Mover[] Movers4 = new Mover[int(random(5, 33))];
Flyer[] Flyers1 = new Flyer[int(random(49, 99))];
Waver[] Wavers1 = new Waver[int(random(400, 800))];

void setup() 
{
  size(1440, 900);

  wind_offset = random(8888);
  windEast = updateWindEastern(wind_offset);
  windWest = updateWindWestern(wind_offset);

  IntDict flyerColors = new IntDict();
  flyerColors.set("red", int(random(10, 55)));
  flyerColors.set("green", int(random(80, 145)));
  flyerColors.set("blue", int(random(80, 255)));

  IntDict waverColors = new IntDict();
  waverColors.set("red", int(random(10, 55)));
  waverColors.set("green", int(random(100, 210)));
  waverColors.set("blue", int(random(0, 80)));

  for (int i = 0; i < Movers1.length; i++) {
    IntDict colors = new IntDict();
    colors.set("red", 140);
    colors.set("green", 31 );
    colors.set("blue", 71);
    Movers1[i] = new Mover(colors, new PVector(random(0, width), random(0, height)));
  }
  for (int i = 0; i < Movers2.length; i++) {
    IntDict colors = new IntDict();
    colors.set("red", 217);
    colors.set("green", 34);
    colors.set("blue", 59);
    Movers2[i] = new Mover(colors, new PVector(random(0, width), random(0, height)));
  }
  for (int i = 0; i < Movers3.length; i++) {
    IntDict colors = new IntDict();
    colors.set("red", 242);
    colors.set("green", 195);
    colors.set("blue", 53);
    Movers3[i] = new Mover(colors, new PVector(random(0, width), random(0, height)));
  }
  for (int i = 0; i < Movers4.length; i++) {
    IntDict colors = new IntDict();
    colors.set("red", 242);
    colors.set("green", 123);
    colors.set("blue", 39);
    Movers4[i] = new Mover(colors, new PVector(random(0, width), random(0, height)));
  }

  for (int i = 0; i < Flyers1.length; i++) {
    float mass = random(8, 13);
      Flyers1[i] = new Flyer(
      flyerColors,
      new PVector(random(5, 11)*i+1, height / 2 + random(0, 5)),
      mass
    );
  }

  for (int i = 0; i < Wavers1.length; i++) {
    float mass = random(7, 10);
    Wavers1[i] = new Waver(
      waverColors,
      new PVector(
        random(-20, width + 20),
        height - 70
      ),
      mass
     );
  }
}

void draw() {
  background(22, 20, 38);
  stroke(205,105,80);
  fill(205,105,80);
  rect(0, height - 69, width, 70);
  for (int i = 0; i < Movers1.length; i++) {
    Movers1[i].update();
    Movers1[i].display();
  }
  for (int i = 0; i < Movers2.length; i++) {
    Movers2[i].update();
    Movers2[i].display();
  }
  for (int i = 0; i < Movers3.length; i++) {
    Movers3[i].update();
    Movers3[i].display();
  }
  for (int i = 0; i < Movers4.length; i++) {
    Movers4[i].update();
    Movers4[i].display();
  }
  
  for (int i = 0; i < Flyers1.length; i++) {
    Flyers1[i].update();
    Flyers1[i].display();
  }

  float stepsize = montecarlo()*55.5;
  wind_offset += stepsize;
  windEast = updateWindEastern(wind_offset);
  windWest = updateWindWestern(wind_offset);
  for (int i = 0; i < Wavers1.length; i++) {
    Wavers1[i].applyForce(windEast);
    Wavers1[i].applyForce(windWest);
    Wavers1[i].update();
    Wavers1[i].display();
  }
}

class Mover {
  PVector location, velocity, acceleration, offset;
  IntDict colors;
  float topspeed;

  Mover(IntDict colors, PVector location) {
    this.location = location;
    this.velocity = new PVector(0, 0);
    this.acceleration = new PVector(-0.001, 0.002);
    this.offset = new PVector(random(8888), random(8888));
    this.colors = colors;
    this.topspeed = random(0.3, 0.8);
  }

  void display() {
    stroke(colors.get("red"), colors.get("green"), colors.get("blue"));
    noFill();
    triangle(
      location.x, location.y,
      location.x + 5, location.y + 10,
      location.x - 5, location.y + 10
    );
    smooth();
  }

  void update() {
    checkEdges();
    float stepsize = montecarlo()*1.5;
    offset.x += stepsize;
    offset.y += stepsize;
    acceleration.x = map(noise(offset.x), 0, 1, -topspeed, topspeed);
    acceleration.y = map(noise(offset.y), 0, 1, -topspeed, topspeed);
    velocity.add(acceleration);
    velocity.limit(topspeed);
    location.add(velocity);
  }
  
  void limit(float max) {
    if (velocity.x > max) {
      velocity.x = max; 
    }
    if (velocity.y > max) {
      velocity.y = max; 
    }
  }
  
  void checkEdges() {
    if (location.y < 0) {
      location.y = height; 
    }
    if (location.y > height) {
      location.y = 0; 
    }
    if (location.x < 0) {
      location.x = width;
    }
    if (location.x > width) {
      location.x = 0;
    }
  }
}

class Flyer {
  PVector location, velocity, acceleration, offset;
  IntDict colors;
  float topspeed, mass;

  Flyer(IntDict colors, PVector location, float mass) {
    this.location = location;
    this.velocity = new PVector(0, 0);
    this.acceleration = new PVector(random(0.4, 0.4), 2);
    this.offset = new PVector(random(8), random(8));
    this.colors = colors;
    this.topspeed = 3;
    this.mass = mass;
  }

  void display() {
    stroke(
      colors.get("red"),
      colors.get("green"),
      colors.get("blue")
    );
    ellipse(
      location.x,
      location.y,
      mass,
      mass
    );
    smooth();
  }

  void update() {
    checkEdges();
    float stepsize = montecarlo()*1.5;
    offset.y += stepsize;
    applyForce(new PVector(1, map(noise(offset.y), 0, 1, -1, 0.05)));
    velocity.add(acceleration);
    velocity.limit(topspeed);
    location.add(velocity);
    acceleration.mult(0);
  }
  
  void limit(float max) {
    if (velocity.x > max) {
      velocity.x = max;
    }
    if (velocity.y > max) {
      velocity.y = max;
    }
  }
  
  void applyForce(PVector force) {
    PVector f = PVector.div(force, mass);
    acceleration.add(f);
  }

  void checkEdges() {
    if (location.y < 0) {
      location.y = height; 
    }
    if (location.y > height) {
      location.y = 0; 
    }
    if (location.x < 0) {
      location.x = width;
    }
    if (location.x > width) {
      location.x = 0;
    }
  }
}


class Waver {
  PVector start_location, location, velocity, acceleration;
  IntDict colors;
  float topspeed, mass;

  Waver(IntDict colors, PVector start_location, float mass) {
    this.start_location = new PVector(start_location.x, start_location.y);
    this.location = new PVector(start_location.x, start_location.y);
    this.velocity = new PVector(0, 0);
    this.acceleration = new PVector(0, 0);
    this.colors = colors;
    this.topspeed = 3;
    this.mass = mass;
  }

  void display() {
    stroke(
      colors.get("red"),
      colors.get("green"),
      colors.get("blue")
    );
    curve(
      start_location.x + 6*mass,
      start_location.y - 5*mass,
      start_location.x,
      start_location.y,
      location.x,
      location.y - 4*mass,
      start_location.x + 2*mass,
      start_location.y - 3*mass
    );
    smooth();
  }

  void update() {
    checkEdges();
    velocity.add(acceleration);
    velocity.limit(topspeed);
    location.add(velocity);
    acceleration.mult(0);
  }

  void applyForce(PVector force) {
    PVector f = PVector.div(force, mass);
    acceleration.add(f);
  }

  void limit(float max) {
    if (velocity.x > max) {
      velocity.x = max;
    }
    if (velocity.y > max) {
      velocity.y = max;
    }
  }

  void checkEdges() {
    if (location.x > start_location.x + 20) {
      location.x = start_location.x + 20;
    }
    if (location.x < start_location.x - 10) {
      location.x = start_location.x - 10;
    }
  }
}

float montecarlo() {
  while (true) {
    float r1 = random(-1, 1);
    float p = pow(1.0 - r1, 1.5);
    float r2 = random(1);
    if (r2 < p) {
      return r1;
    }
  }
}

PVector updateWindEastern(float offset) {
  return new PVector(map(noise(offset), 0, 1, 0, 0.03), 0);
}

PVector updateWindWestern(float offset) {
  return new PVector(map(noise(offset), 0, 1, -0.03, 0), 0);
}