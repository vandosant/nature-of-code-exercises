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

  for (int i = 0; i < movers.length; i++) {
    if (keyPressed) {
      if (key == CODED) {
        if (keyCode == LEFT) {
          movers[i].turn(-0.05);
        } else if (keyCode == RIGHT) {
          movers[i].turn(0.05);
        }
        if (keyCode == UP) {
          movers[i].accelerate();
        }
      }
    }

    movers[i].update();
    movers[i].display();
  }
}

class Mover {
  PVector location, velocity, acceleration, wind, helium, gravity, window;
  int r, g, b;
  float offset, mass;
  float angle, radians, theta;

  Mover(int r, int g, int b, float mass) {
    location = new PVector(width/2, height/2);
    velocity = new PVector(0.0, 0.0);
    acceleration = new PVector(0.0, 0.0);
    this.r = r;
    this.g = g;
    this.b = b;
    this.mass = mass;
    this.angle = 0;
    this.radians = 10;
    this.theta = 90;
  }

  void display() {
    fill(r, g, b);
    stroke(r, g, b);
    smooth();
    pushMatrix();
    translate(location.x, location.y);
    rotate(theta);
    triangle(
      0, 0,
      -5*mass, 5*mass,
      5*mass, 5*mass
    );
    popMatrix();
  }

  void update() {
    angle = atan2(velocity.y, velocity.x);
    velocity.add(acceleration);
    location.add(velocity);   
    acceleration.mult(0);
    checkEdges();
    limit(1);
  }
  
  void applyForce(PVector force) {
    PVector f = PVector.div(force, mass);
    acceleration.add(f);
  }
  
  void turn(float delta) {
    theta += delta;
  }
  
  void accelerate() {
    float x = 10 * cos(theta);
    float y = 10 * sin(theta);
    PVector force = new PVector(x, y);
    applyForce(force);
  }

  void limit(float max) {
    if (velocity.x > max) {
      velocity.x = max; 
    }
    if (velocity.x < -1 * max) {
      velocity.x = -1 * max; 
    }
    if (velocity.y > max) {
      velocity.y = max; 
    }
    if (velocity.y < -1 * max) {
      velocity.y = -1 * max; 
    }
  }
  
  void checkEdges() {
    if (location.y < 0) {
      location.y = 0;
    }

    if (location.y > height) {
      location.y = height;
    }
    
    if (location.x < 0) {
      location.x = 0;
    }
    
    if (location.x > width) {
      location.x = width;
    }
  }
}