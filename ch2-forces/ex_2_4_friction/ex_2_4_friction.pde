int width = 840;
int height = 840;
Mover[] movers = new Mover[50];

void setup() 
{
  size(840, 840);
  for (int i = 0; i < movers.length; i++) {
    movers[i] = new Mover(140, 31, 71, random(8));
  }
}

void draw() {
  background(22, 20, 38);
  PVector gravity = new PVector(0, 1);
  PVector wind = new PVector(0.01, 0);

  for (int i = 0; i < movers.length; i++) {
    float x = movers[i].location.x;
    float y = movers[i].location.x;
    
    if (x > width / 2 && y > height / 2) {
      float c = 0.1;
      PVector friction = movers[i].velocity.copy();
      friction.normalize();
      friction.mult(c);
      movers[i].applyForce(friction);
    } else {
      float c = 0.1;
      PVector friction = movers[i].velocity.copy();
      friction.mult(-1);
      friction.normalize();
      friction.mult(c);
      movers[i].applyForce(friction);
    }
    movers[i].applyForce(gravity);
    movers[i].applyForce(wind);

    movers[i].update();
    movers[i].display();
  }
}

class Mover {
  PVector location, velocity, acceleration, wind, helium, gravity, window;
  int r, g, b;
  float offset, mass;

  Mover(int r, int g, int b, float mass) {
    location = new PVector(random(0, width), random(0, height));
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
    this.r = r;
    this.g = g;
    this.b = b;
    this.mass = mass;
  }

  void display() {
    stroke(r, g, b);
    noFill();
    ellipse(
      location.x, location.y,
      10*mass, 10*mass
    );
    smooth();
  }

  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0);
    limit(50);
    checkEdges();
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
    if (velocity.x < 0.1) {
      velocity.x = 0.1;
    }
  }
  
  void checkEdges() {
    if (location.y > height) {
      location.y = height;
      velocity.y *= -1;
    }
    if (location.y < 0) {
      location.y = 0;
      velocity.y *= -1;
    }

    if (location.x > width) {
      location.x = width;
      velocity.x *= -1;
    }
    if (location.x < 0) {
      location.x = 0;
      velocity.x *= -1;
    }
  }
}