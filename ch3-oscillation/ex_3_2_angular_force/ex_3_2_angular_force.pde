int width = 1440;
int height = 840;
Mover[] movers = new Mover[1];

void setup() 
{
  size(1440, 840);
  for (int i = 0; i < movers.length; i++) {
    movers[i] = new Mover(140, 31, 71, 4);
  }
}

void draw() {
  background(22, 20, 38);
  PVector gravity = new PVector(0, 2);
  PVector wind = new PVector(0.01, 0);

  for (int i = 0; i < movers.length; i++) {
    float x = movers[i].location.x;
    float y = movers[i].location.x;
    
    float c = 0.1;
    PVector friction = movers[i].velocity.copy();
    friction.mult(-1);
    friction.normalize();
    friction.mult(c);
    movers[i].applyForce(friction);
    movers[i].applyForce(gravity);
    movers[i].applyForce(wind);

    movers[i].update();
    movers[i].display();
  }
}

class Mover {
  PVector location, velocity, acceleration, wind, helium, gravity, window;
  int r, g, b;
  float offset, mass;
  float angle, aVelocity, aAcceleration;

  Mover(int r, int g, int b, float mass) {
    location = new PVector(0, height);
    velocity = new PVector(25, -20);
    acceleration = new PVector(0, 0);
    this.r = r;
    this.g = g;
    this.b = b;
    this.mass = mass;
    this.angle = 0;
    this.aVelocity = 0;
    this.aAcceleration = 0.001;
  }

  void display() {
    stroke(r, g, b);
    fill(r, g, b);

    pushMatrix();
    translate(location.x, location.y);
    rotate(angle);
    ellipse(
      0, 0,
      10*mass, 8*mass
    );
    popMatrix();
  }

  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    
    aAcceleration = -1 * (velocity.y / 50);
    aVelocity += aAcceleration;
    
    limit(50);

    angle += aVelocity;
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
    if (velocity.x < 0.1) {
      velocity.x = 0.1;
    }
    
    if (aVelocity > 0.1) {
      aVelocity = 0.1;
    }
    if (aVelocity < -0.1) {
      aVelocity = -0.1;
    }
  }
  
  void checkEdges() {
    if (location.y > height) {
      location.y = height;
    }
  }
}