int width = 1440;
int height = 855;
Mover[] movers = new Mover[20];

void setup() {
  size(1440, 855);
  for (int i = 0; i < movers.length; i++) {
    movers[i] = new Mover(
      140, 31, 71,
      random(2, 20),
      random(width/2) + width / 4,
      random(height/3) + height/3);
  }
}

void draw() {
  background(22, 20, 38);
  Mover mouse = new Mover(0,0,0, 500, mouseX, mouseY);
  for (int i = 0; i < movers.length; i++) {
    for (int j = 0; j < movers.length; j++) {
      if (i != j) {
        PVector force = movers[i].attract(movers[j]);
        movers[i].applyForce(force);
      }
    }
    
    PVector force = mouse.attract(movers[i]);
    movers[i].applyForce(force);

    movers[i].update();
    movers[i].display();
  }
}

class Mover {
  PVector location, velocity, acceleration;
  int r, g, b;
  float offset, mass, radius, G;

  Mover(int r, int g, int b, float mass, float x, float y) {
    location = new PVector(x, y);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
    this.r = r;
    this.g = g;
    this.b = b;
    this.mass = mass;
    this.radius = mass*3.0;
    this.G = 0.4;
  }

  void display() {
    strokeWeight(mass * 0.2);
    stroke(r, g, b, 10*mass);
    fill(r, g, b, 10*mass);
    ellipse(location.x, location.y, radius, radius);
    smooth();
  }

  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0);
    limit(30);
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
  
  PVector attract(Mover mover) {
    PVector force = PVector.sub(location, mover.location);
    float distance = force.magSq();
    distance = constrain(distance, 5.0, 25.0);
    float strength = G * mass * mover.mass;
    force.normalize();
    return force.mult(strength / (distance * distance));
  }
}