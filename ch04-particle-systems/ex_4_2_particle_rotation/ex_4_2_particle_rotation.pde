Particle p;

void setup () {
  size(640, 640);
  
  p = new Particle(width/2, height/2, 3);
}

void draw () {
  background(0);
  
  PVector force = new PVector(0, random(0, 0.5));
  p.applyForce(force);
  if (!p.isDead()) {
    p.update();
    p.display();
  }
}

class Particle {
  PVector acceleration;
  float angle;
  float lifespan;
  PVector location;
  float mass;
  PVector velocity;
  Particle (float x, float y, float m) {
    location = new PVector(x, y);
    mass = m;
    angle = 0;
    acceleration = new PVector(0, 0);
    lifespan = 100;
    velocity = new PVector(random(-1, 0), 0);
  }
  
  void applyForce (PVector f) {
    acceleration = PVector.div(f, mass); 
  }
  
  void display () {
    pushMatrix();
    translate(location.y, location.y);
    rotate(angle);
    stroke(185);
    fill(125, map(lifespan, 0, 1, 0, 255));
    triangle(
      0, 0,
      1.5*mass, 3*mass,
      -1.5*mass, 3*mass
     );
     popMatrix();
  }
  
  void update () {
    angle += map(lifespan, 0, 1, 0, 0.007);
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0);
    lifespan -= 1.0;
  }
  
  boolean isDead () {
    return lifespan < 0; 
  }
}