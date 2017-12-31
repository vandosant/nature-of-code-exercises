int width = 1440;
int height = 855;
Mover[] movers = new Mover[20];
Attractor[] attractors = new Attractor[2];

void setup() {
  size(1440, 855);
  for (int i = 0; i < movers.length; i++) {
    movers[i] = new Mover(140, 31, 71, random(2, 20), random(width), random(height));
  }
  for (int i = 0; i < attractors.length; i++) {
    attractors[i] = new Attractor(random(width), random(height), random(10, 20));
  }
}

void draw() {
  background(22, 20, 38);
  for (int i = 0; i < attractors.length; i++) {
    attractors[i].display();
  }
  for (int i = 0; i < movers.length; i++) {
    for (int j = 0; j < attractors.length; j++) {
      PVector force = attractors[j].attract(movers[i]);
      movers[i].applyForce(force);
    }

    movers[i].update();
    movers[i].display();
  }
}

class Mover {
  PVector location, velocity, acceleration;
  int r, g, b;
  float offset, mass, radius;

  Mover(int r, int g, int b, float mass, float x, float y) {
    location = new PVector(x, y);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
    this.r = r;
    this.g = g;
    this.b = b;
    this.mass = mass;
    this.radius = mass*3.0;
  }

  void display() {
    stroke(r, g, b);
    fill(r, g, b, 10*mass);
    ellipse(location.x, location.y, radius, radius);
    smooth();
  }

  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0);
    limit(30);
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
}

class Attractor {
  PVector location;
  float m, G;
  
  Attractor(float x, float y, float m) {
    this.location = new PVector(x, y);
    this.m = m;
    this.G = 0.4;
  }
  
  void display() {
    noStroke();
    fill(0, 95, 155);
    ellipse(location.x, location.y, 6*m, 6*m);
  }
  
  PVector attract(Mover mover) {
    PVector force = PVector.sub(location, mover.location);
    float distance = force.mag();
    if (distance < 6*m) {
      force.mult(1000);
      force.mult(-1);
    }
    distance = constrain(distance, 5.0, 25.0);
    float strength = G * m * mover.mass;
    force.normalize();
    return force.mult(strength / (distance * distance));
  }
}