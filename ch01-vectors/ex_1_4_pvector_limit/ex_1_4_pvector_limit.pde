int width = 640;
int height = 640;
Mover w;

void setup() 
{
  size(640, 640);
  w = new Mover();
  background(22, 20, 38);
}

void draw() {
  w.update();
  w.display();
}

class Mover {
  PVector location, velocity, prev, acceleration;
  int r, g, b;
  float topspeed;

  Mover() {
    location = new PVector(width/2, height/2);
    velocity = new PVector(0, 0);
    acceleration = new PVector(-0.001, 0.01);
    prev = new PVector(location.x, location.y);
    r = 140;
    g = 31;
    b = 71;
    topspeed = 5;
  }

  void display() {
    stroke(r, g, b);
    point(location.x, location.y);
    smooth();
  }

  void update() {
    checkEdges();
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
    if (location.y > height) {
      location.y = 0; 
    }
    if (location.x < 0) {
      location.x = width;
    }
  }
}