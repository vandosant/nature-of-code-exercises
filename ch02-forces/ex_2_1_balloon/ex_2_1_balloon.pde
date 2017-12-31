int width = 640;
int height = 640;
Mover[] movers = new Mover[10];

void setup() 
{
  size(640, 640);
  for (int i = 0; i < movers.length; i++) {
    movers[i] = new Mover(140, 31, 71, random(10));
  }
}

void draw() {
  background(22, 20, 38);
  for (int i = 0; i < movers.length; i++) {
    movers[i].update();
    movers[i].display();
  }
}

class Mover {
  PVector location, velocity, acceleration, wind, helium, gravity;
  int r, g, b;
  float offset, mass;

  Mover(int r, int g, int b, float mass) {
    location = new PVector(0, height);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
    helium = new PVector(0, -0.2*mass);
    gravity = new PVector(0, 0.1*mass);
    wind = new PVector(0, 0);
    offset = random(8888);
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
    float stepsize = montecarlo()*1.5;
    offset += stepsize;
    wind.x = map(noise(offset), 0, 1, 0, 0.01);

    applyForce(wind);
    applyForce(helium);
    applyForce(gravity);

    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0);

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
  }
  
  void checkEdges() {
    if (location.y < 0) {
      location.y = 0;
      velocity.y *= -1;
    }
    if (location.y > height) {
      location.y = height;
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
  
  float montecarlo() {
    while (true) {
      float r1 = random(-1, 1);
      float p = pow(1.0 - r1, 2.0);
      float r2 = random(1);
      if (r2 < p) {
        return r1;
      }
    }
  }
}