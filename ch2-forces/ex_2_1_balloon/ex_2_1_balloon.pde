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
  line(0,100,width,100);
  w.update();
  w.display();
}

class Mover {
  PVector location, velocity, prev, acceleration, wind, helium;
  int r, g, b;
  float topspeed, offset;

  Mover(int r, int g, int b) {
    location = new PVector(width/2, height);
    velocity = new PVector(0, 0);
    acceleration = new PVector(-0.001, 0.001);
    prev = new PVector(location.x, location.y);
    helium = new PVector(0, -0.22);
    wind = new PVector(0, 0);
    offset = random(8888);
    this.r = r;
    this.g = g;
    this.b = b;
    topspeed = random(1, 3.5);
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
    float stepsize = montecarlo()*1.5;
    offset += stepsize;
    wind.x = map(noise(offset), 0, 1, 0, 0.1);
    applyForce(wind);
    applyForce(helium);
    checkEdges();
    velocity.add(acceleration);
    velocity.limit(topspeed);
    location.add(velocity);
    acceleration.mult(0);
  }
  
  void applyForce(PVector force) {
    acceleration.add(force);
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
    if (location.y == 100) {
      velocity.y = 0;
      if (acceleration.y < 0) {
        acceleration.y = 0; 
      }
    }
    if (location.y <= 100) {
      acceleration.y = acceleration.y * -1;
    }
  }
  
  float montecarlo() {
    while (true) {
      float r1 = random(-1, 1);
      float p = pow(1.0 - r1, topspeed);
      float r2 = random(1);
      if (r2 < p) {
        return r1;
      }
    }
  }
}