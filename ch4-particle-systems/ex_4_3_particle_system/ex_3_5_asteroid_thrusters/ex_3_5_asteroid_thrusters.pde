import java.util.ArrayList;
import java.util.Iterator;
int width = 1440;
int height = 840;
Mover mover;
ParticleSystem p;
boolean[] keys;

void setup() {
  size(1440, 840);
  mover = new Mover(140, 31, 71, 4);
  p = new ParticleSystem(new PVector(width/2, height/2));
  keys = new boolean[3];
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == LEFT) {
      keys[0] = true;
    }
    if (keyCode == RIGHT) {
      keys[1] = true;
    }
    if (keyCode == UP) {
      keys[2] = true;
    }
  }
}

void keyReleased() {
  if (key == CODED) {
    if (keyCode == LEFT) {
      keys[0] = false;
    }
    if (keyCode == RIGHT) {
      keys[1] = false;
    }
    if (keyCode == UP) {
      keys[2] = false;
    }
  }
}

void draw() {
  background(22, 20, 38);

  if (keys[0]) {
    mover.turn(-0.05);
  }
  if (keys[1]) {
    mover.turn(0.05);
  }
  if (keys[2]) {
    mover.accelerate();
    p.origin.set(new PVector(mover.location.x, mover.location.y));
    p.add();
  }

  p.update();
  p.display();
  mover.update();
  mover.display();
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
    this.theta = 0;
  }

  void display() {
    fill(r, g, b);
    stroke(r, g, b);
    smooth();
    pushMatrix();
    translate(location.x, location.y);
    rotate(theta);
    triangle(
      0, -5*mass,
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
    limit(2);
  }
  
  void applyForce(PVector force) {
    PVector f = PVector.div(force, mass);
    acceleration.add(f);
  }
  
  void turn(float delta) {
    theta += delta;
  }
  
  void accelerate() {
    float angle = theta - PI/2;
    float x = cos(angle);
    float y = sin(angle);
    PVector force = new PVector(x, y);
    force.mult(0.3);
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
    angle = random(0, 90);
    acceleration = new PVector(0, 0);
    lifespan = 255;
    velocity = new PVector(mover.velocity.x, mover.velocity.y);
  }
  
  void applyForce (PVector f) {
    acceleration = PVector.div(f, mass); 
  }
  
  void display () {
    pushMatrix();
    translate(location.x, location.y);
    rotate(angle);
    noStroke();
    fill(125, lifespan);
    triangle(
      0, 0,
      1.5*mass, mass,
      -1.5*mass, mass
     );
     popMatrix();
  }
  
  void update () {
    angle += map(lifespan, 0, 1, 0, 0.0005);
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0);
    lifespan -= 2.0;
  }
  
  boolean isDead () {
    return lifespan <= 0; 
  }
}

class ParticleSystem {
  PVector origin;
  ArrayList<Particle> particles;

  ParticleSystem(PVector location) {
    origin = location.copy();
    particles = new ArrayList<Particle>();
  }

  void add () {
    particles.add(new Particle(origin.x, origin.y, 5));
  }

  void display () {
    Iterator<Particle> it = particles.iterator();
    while (it.hasNext()) {
      Particle p = it.next();
      if (!p.isDead()) {
        p.display();
      }
    }
  }

  void update () {
    PVector force = new PVector(mover.acceleration.x, mover.acceleration.y);
    Iterator<Particle> it = particles.iterator();
    while (it.hasNext()) {
      Particle p = it.next();
      p.applyForce(force);
      if (p.isDead()) {
        it.remove();
      }
      if (!p.isDead()) {
        p.update();
      }
    }
  }
}