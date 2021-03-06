int width = 940;
int height = 640;
float slope = 0.3;
PVector g = new PVector(0, 0.4);
Mover[] movers = new Mover[5];

void setup() 
{
  size(940, 640);
  for (int i = 0; i < movers.length; i++) {
    movers[i] = new Mover(140, 31, 71, 3);
  }
}

void draw() {
  background(22, 20, 38);
  line(0, 0, width, (-sin(30)) * height);
  for (int i = 0; i < movers.length; i++) {  
    float angle = tan(movers[i].location.y/movers[i].location.x);

    movers[i].applyForce(g);
    if (1 - angle < slope) {
      movers[i].applyForce(PVector.mult(g, -1));
      movers[i].velocity.y = 0;
      movers[i].turn(0.3);
      float angularForce = 30;
      float x = cos(angularForce);
      float y = sin(angularForce);
      PVector force = new PVector(x, y);
      force.mult(0.3);
      movers[i].applyForce(force);
    }

    movers[i].update();
    movers[i].checkEdges();
    movers[i].display();
  }
}

class Mover {
  PVector location, velocity, acceleration, gravity;
  int r, g, b;
  float angle, offset, mass;

  Mover(int r, int g, int b, float mass) {
    location = new PVector(random(0, width), 0);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
    this.r = r;
    this.g = g;
    this.b = b;
    this.mass = mass;
    this.angle = 0;
  }

  void display() {
    stroke(r, g, b);
    noFill();
    
    pushMatrix();
    translate(location.x, location.y);
    rotate(angle);
    rect(
      0, 0,
      10*mass, 10*mass
    );
    popMatrix();
  }

  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0);
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
    if (location.y > height - 10*mass) {
      location.y = height - 10*mass;
    }
    if (location.y < 0) {
      location.y = 0;
    }
    if (location.x > width) {
      location.x = width;
    }
    if (location.x < 0) {
      location.x = 0;
    }
  }

  void turn(float a) {
    println(a);
    angle = a;
  }
}