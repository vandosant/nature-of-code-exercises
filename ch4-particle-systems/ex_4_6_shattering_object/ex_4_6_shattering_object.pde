import java.util.ArrayList;
import java.util.Iterator;
ArrayList<ParticleSystem> systems;

void setup () {
  size(640, 640);
  systems = new ArrayList<ParticleSystem>();
  systems.add(new ParticleSystem(new PVector(width/2, height/2)));
  ParticleSystem p = systems.get(0);
  p.addParticle(p.origin.x, p.origin.y, 50);
}

void mousePressed () {
  Iterator<ParticleSystem> it = systems.iterator();
  while (it.hasNext()) {
    ParticleSystem p = it.next();
    p.splitParticle(mouseX, mouseY);
  }
}

void draw () {
  background(0);
  Iterator<ParticleSystem> it = systems.iterator();
  while (it.hasNext()) {
    ParticleSystem p = it.next();
    p.run();
  }
}

class Particle {
  PVector acceleration;
  float angle;
  PVector location;
  float mass;
  PVector velocity;
  Particle (float x, float y, float m) {
    location = new PVector(x, y);
    mass = m;
    angle = random(0, TWO_PI*2);
    acceleration = new PVector(0, 0);
    velocity = new PVector(random(-1, 1), 0);
  }

  void applyForce (PVector f) {
    acceleration = PVector.div(f, mass);
  }

  void display () {
    pushMatrix();
    translate(location.x, location.y);
    rotate(angle);
    noStroke();
    fill(125);
    triangle(
      0, 0, 
      1.5*mass, 3*mass, 
      -1.5*mass, 3*mass
      );
    popMatrix();
  }

  void update () {
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0);
  }
}

class ParticleSystem {
  PVector origin;
  ArrayList<Particle> particles;

  ParticleSystem(PVector location) {
    origin = location.copy();
    particles = new ArrayList<Particle>();
  }

  void addParticle (float x, float y, float m) {
    particles.add(new Particle(x, y, m));
  }

  void splitParticle (float x, float y) {
    PVector clickLocation = new PVector(x, y);
    Iterator<Particle> it = particles.iterator();
    boolean isSplit = false;
    float splitMass = 0;
    PVector splitLocation = new PVector(0, 0);
    while (it.hasNext()) {
      Particle p = it.next();
      PVector location = p.location.copy();
      if (clickLocation.dist(location) < p.mass) {
        it.remove();
        isSplit = true;
        splitLocation = location.copy();
        splitMass = p.mass * 0.75;
      }
    }
    if (isSplit) {
      addParticle(splitLocation.x, splitLocation.y, splitMass);
      addParticle(splitLocation.x, splitLocation.y, splitMass);
    }
  }

  void run () {
    PVector force = new PVector(0, 0.4);
    Iterator<Particle> it = particles.iterator();
    while (it.hasNext()) {
      Particle p = it.next();
      p.applyForce(force);
      p.update();
      p.display();
    }
  }

  boolean isEmpty () {
    return particles.size() == 0;
  }
}