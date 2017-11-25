int width = 1440;
int height = 855;
Mover[] movers = new Mover[50];
Liquid liquid;

void setup() 
{
  size(1440, 855);
  for (int i = 0; i < movers.length; i++) {
    movers[i] = new Mover(140, 31, 71, random(2, 8));
  }
  liquid = new Liquid(0, height / 3 + height / 3, width, height / 3, 0.1);
}

void draw() {
  background(22, 20, 38);

  liquid.display();
  PVector gravity = new PVector(0, 1);
  for (int i = 0; i < movers.length; i++) {
    if (movers[i].isInside(liquid)) {
      movers[i].drag(liquid);
    };
    movers[i].applyForce(gravity);

    movers[i].update();
    movers[i].display();
  }
}

class Mover {
  PVector location, velocity, acceleration, wind, helium, gravity, window;
  int r, g, b;
  float offset, mass;

  Mover(int r, int g, int b, float mass) {
    location = new PVector(random(0, width), random(0, height / 2));
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
    this.r = r;
    this.g = g;
    this.b = b;
    this.mass = mass;
  }

  void display() {
    stroke(22);
    fill(r, g, b);
    rect(
      location.x, location.y,
      10*mass, 10*mass
    );
    smooth();
  }

  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0);
    limit(50);
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
    if (location.y > height - 10*mass) {
      location.y = height - 10*mass;
    }

    if (location.y < 0) {
      location.y = 0;
    }

    if (location.x > width - 10*mass) {
      location.x = width - 10*mass;
    }

    if (location.x < 0) {
      location.x = 0;
    }
  }
  
  boolean isInside(Liquid l) {
    if (location.x > l.x && location.x < l.x + l.w && location.y > l.y && location.y < l.y + l.h) {
      return true;
    }
    return false;
  }
  
  void drag(Liquid l) {
    float speed = velocity.mag();
    float surfaceArea = 4 * 10 * mass;
    float dragMagnitude = speed * speed * l.c * (surfaceArea * 0.009);
    
    PVector drag = velocity.copy();
    drag.mult(-1);
    drag.normalize();
    drag.mult(dragMagnitude);
    
    applyForce(drag);
  }
}

class Liquid {
  float x, y, w, h, c;
  
  Liquid(float x, float y, float w, float h, float c) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.c = c;
  }
  
  void display() {
    noStroke();
    fill(0, 95, 155);
    rect(x, y, w, h);
  }
}