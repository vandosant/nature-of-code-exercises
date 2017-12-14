PVector g;
Bob bob;
Spring spring;

void setup () {
  size(640, 640);
  g = new PVector(0, 4);
  spring = new Spring(width/2, 10, 100);
  bob = new Bob(width, 110, 10);
}

void draw () {
  background(0);
  
  bob.applyForce(g);
  spring.connect(bob);
  
  bob.update();
  bob.display();
  spring.display(bob);
}

class Spring {
  PVector anchor;
  float k;
  float len;

  Spring (float x, float y, float l) {
    anchor = new PVector(x, y);
    k = 0.1;
    len = l;
  }
  
  void display (Bob b) {
    fill(255);
    rectMode(CENTER);
    rect(anchor.x, anchor.y, 5, 5);
    stroke(255);
    line(anchor.x, anchor.y, b.location.x, b.location.y);
  }
  
  void connect (Bob b) {
    PVector force = PVector.sub(anchor, bob.location);
    
    float dir = force.mag();
    float extension = len - dir;

    force.normalize();
    force.mult(-k * extension);
    b.applyForce(force);
  }
}

class Bob {
  PVector acceleration;
  PVector location;
  float mass;
  PVector velocity;
  
  Bob (float x, float y, float m) {
    acceleration = new PVector(0, 0);
    location = new PVector(x, y);
    mass = m;
    velocity = new PVector(0, 0);
  }
  
  void display () {
    fill(125);
    ellipse(location.x, location.y, mass*5, mass*5); 
  }
  
  void update () {
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0);
  }
  
  void applyForce (PVector force) {
     PVector f = PVector.div(force, mass);
     acceleration.add(f);
  }
}