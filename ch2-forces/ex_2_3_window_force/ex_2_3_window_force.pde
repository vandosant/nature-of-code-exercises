int width = 940;
int height = 640;
Mover[] movers = new Mover[50];

void setup() 
{
  size(940, 640);
  for (int i = 0; i < movers.length; i++) {
    movers[i] = new Mover(140, 31, 71, random(1.5, 8));
  }
}

void draw() {
  background(22, 20, 38);
  for (int i = 0; i < movers.length; i++) {
    PVector forceX = new PVector(0.001, 0);
    PVector forceY = new PVector(0, 0.001);
    float x = movers[i].location.x;
    float y = movers[i].location.y;

    if (x < height / 2) {
      PVector windowForce = PVector.mult(forceX, (height / 2) + (height - x));
      movers[i].applyForce(windowForce);
    } else {
      PVector windowForce = PVector.mult(forceX, -1 * ((height / 2) + x));
      movers[i].applyForce(windowForce);
    }
    
    if (y < width / 2) {
      PVector windowForce = PVector.mult(forceY, (width / 2) + (width - x));
      movers[i].applyForce(windowForce);
    } else {
      PVector windowForce = PVector.mult(forceY, -1 * ((width / 2) + x));
      movers[i].applyForce(windowForce);
    }

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