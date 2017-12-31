Particle p;

void setup () {
  size(640, 640);
  
  p = new Particle(width/2, height/2, 3);
}

void draw () {
  background(0);
  
  PVector force = new PVector(0, random(0, 1));
  p.applyForce(force);
  if (!p.isDead()) {
    p.update();
    p.display();
  }
}

class Particle {
  PVector acceleration;
  float lifespan;
  PVector location;
  float mass;
  PVector velocity;
  Particle (float x, float y, float m) {
    location = new PVector(x, y);
    mass = m;
    acceleration = new PVector(0, 0);
    lifespan = 100;
    velocity = new PVector(random(-1, 0), 0);
  }
  
  void applyForce (PVector f) {
    acceleration = PVector.div(f, mass); 
  }
  
  void display () {
    stroke(185);
    fill(125, map(lifespan, 0, 1, 0, 255));
    ellipse(location.x, location.y, 3*mass, 3*mass); 
  }
  
  void update () {
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0);
    lifespan -= 1.0;
  }
  
  boolean isDead () {
    return lifespan < 0; 
  }
}