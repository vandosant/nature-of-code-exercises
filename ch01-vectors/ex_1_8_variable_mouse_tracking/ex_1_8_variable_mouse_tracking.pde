int width = 640;
int height = 640;
Mover w, w1, w2, w3;

void setup() 
{
  size(640, 640);
  w = new Mover(140, 31, 71);
  w1 = new Mover(217, 34, 59);
  w2 = new Mover(242, 195, 53);
  w3 = new Mover(242, 123, 39);
}

void draw() {
  background(22, 20, 38);
  w.update();
  w.display();
  w1.update();
  w1.display();
  w2.update();
  w2.display();
  w3.update();
  w3.display();
}

class Mover {
  PVector location, distance, velocity, multiplier, acceleration, mouse, magnitude;
  int r, g, b;
  float force, topspeed;

  Mover(int r, int g, int b) {
    location = new PVector(width/2, height/2);
    velocity = new PVector(0, 0);
    acceleration = new PVector(-0.001, 0.001);
    this.r = r;
    this.g = g;
    this.b = b;
    topspeed = random(1, 10);
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
    mouse = new PVector(mouseX,mouseY);
    distance = PVector.sub(mouse, location);
    force = distance.magSq() / (width * height);

    acceleration = distance;
    acceleration.normalize();
    println(force);
    acceleration.mult(force);

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