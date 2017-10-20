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
  for (int i = 0; i < Movers1.length; i++) {
    Movers1[i] = new Mover(140, 31, 71, new PVector(random(0, width), random(0, height)));
  }
  for (int i = 0; i < Movers2.length; i++) {
    Movers2[i] = new Mover(217, 34, 59, new PVector(random(0, width), random(0, height)));
  }
  for (int i = 0; i < Movers3.length; i++) {
    Movers3[i] = new Mover(242, 195, 53, new PVector(random(0, width), random(0, height)));
  }
  for (int i = 0; i < Movers4.length; i++) {
    Movers4[i] = new Mover(242, 123, 39, new PVector(random(0, width), random(0, height)));
  }
  int flyer_r = int(random(10, 55));
  int flyer_g = int(random(80, 145));
  int flyer_b = int(random(80, 255));
  for (int i = 0; i < Flyers1.length; i++) {
    Flyers1[i] = new Flyer(flyer_r, flyer_g, flyer_b, new PVector(random(5, 11)*i+1, height / 2 + random(0, 5)));
  }

  int waver_r = int(random(10, 55));
  int waver_g = int(random(100, 210));
  int waver_b = int(random(0, 80));
  wind_offset = random(8888);
  windEast = updateWindEastern(wind_offset);
  windWest = updateWindWestern(wind_offset);
  for (int i = 0; i < Wavers1.length; i++) {
    float mass = random(7, 10);
    Wavers1[i] = new Waver(
      waver_r,
      waver_g,
      waver_b,
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
  PVector location, velocity, prev, acceleration, offset;
  int r, g, b;
  float topspeed;

  Mover(int r, int g, int b, PVector start_location) {
    location = start_location;
    velocity = new PVector(0, 0);
    acceleration = new PVector(-0.001, 0.002);
    prev = new PVector(location.x, location.y);
    offset = new PVector(random(8888), random(8888));
    this.r = r;
    this.g = g;
    this.b = b;
    topspeed = random(0.3, 0.8);
  }

  void display() {
    stroke(r, g, b);
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
}

class Flyer {
  PVector location, velocity, acceleration, offset;
  int r, g, b;
  float topspeed;

  Flyer(int r, int g, int b, PVector start_location) {
    location = start_location;
    velocity = new PVector(0, 0);
    acceleration = new PVector(random(0.4, 0.4), 2);
    offset = new PVector(random(8), random(8));
    this.r = r;
    this.g = g;
    this.b = b;
    topspeed = 3;
  }

  void display() {
    stroke(r, g, b);
    ellipse(
      location.x,
      location.y,
      10,
      10
    );
    smooth();
  }

  void update() {
    checkEdges();
    float stepsize = montecarlo()*1.5;
    offset.y += stepsize;
    acceleration = new PVector(1, map(noise(offset.y), 0, 1, -1, 0.05));
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
}


class Waver {
  PVector start_location, location, velocity, acceleration;
  int r, g, b;
  float topspeed, mass;

  Waver(int r, int g, int b, PVector start_location, float mass) {
    this.start_location = new PVector(start_location.x, start_location.y);
    this.location = new PVector(start_location.x, start_location.y);
    this.velocity = new PVector(0, 0);
    this.acceleration = new PVector(0, 0);
    this.topspeed = 3;
    this.r = r;
    this.g = g;
    this.b = b;
    this.mass = mass;
  }

  void display() {
    stroke(r, g, b);
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