int width = 640;
int height = 640;
Mover w;

void setup() 
{
  size(640, 640);
  w = new Mover(140, 31, 71);
}

void draw() {
  background(22, 20, 38);
  w.update();
  w.display();
}

class Mover {
  PVector location, velocity, acceleration, wind, helium;
  int r, g, b;
  float offset;
  float mass = 10.0;

  Mover(int r, int g, int b) {
    location = new PVector(0, height);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
    helium = new PVector(0, -0.1);
    wind = new PVector(0, 0);
    offset = random(8888);
    this.r = r;
    this.g = g;
    this.b = b;
  }

  void display() {
    stroke(r, g, b);
    noFill();
    ellipse(
      location.x, location.y,
      10, 10
    );
    smooth();
  }

  void update() {
    float stepsize = montecarlo()*1.5;
    offset += stepsize;
    wind.x = map(noise(offset), 0, 1, 0, 0.01);

    applyForce(wind);
    applyForce(helium);

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