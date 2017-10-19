Mover w, w1, w2, w3;
Mover[] Movers1 = new Mover[int(random(33, 66))];
Mover[] Movers2 = new Mover[int(random(33, 66))];
Mover[] Movers3 = new Mover[int(random(33, 66))];
Mover[] Movers4 = new Mover[int(random(33, 66))];
Flyer[] Flyers1 = new Flyer[int(random(33, 66))];

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
  int flyer_r = int(random(10, 255));
  int flyer_g = int(random(10, 255));
  int flyer_b = int(random(10, 355));
  for (int i = 0; i < Flyers1.length; i++) {
    Flyers1[i] = new Flyer(flyer_r, flyer_g, flyer_b, new PVector(10*i, height / 2));
  }
}

void draw() {
  background(22, 20, 38);
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
      location.x, location.y,
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