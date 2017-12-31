import java.util.ArrayList;
import java.util.Iterator;
ArrayList<ParticleSystem> systems;

void setup () {
  size(640, 640);
  systems = new ArrayList<ParticleSystem>();
}

void mousePressed () {
  systems.add(new ParticleSystem(new PVector(mouseX, mouseY)));
  Iterator<ParticleSystem> it = systems.iterator();
  while (it.hasNext()) {
    ParticleSystem p = it.next();
    p.addParticle();
  }
}

void draw () {
  background(0);
  Iterator<ParticleSystem> it = systems.iterator();
  while (it.hasNext()) {
    ParticleSystem p = it.next();
    p.run();
    if (p.isEmpty()) {
      it.remove();
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
    angle = random(0, TWO_PI*2);
    acceleration = new PVector(0, 0);
    lifespan = 255;
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
    fill(125, lifespan);
    triangle(
      0, 0, 
      1.5*mass, 3*mass, 
      -1.5*mass, 3*mass
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

  void addParticle () {
    particles.add(new Particle(origin.x, origin.y, 5));
  }

  void run () {
    PVector force = new PVector(0, 0.4);
    Iterator<Particle> it = particles.iterator();
    while (it.hasNext()) {
      Particle p = it.next();
      p.applyForce(force);
      if (p.isDead()) {
        it.remove();
      }
      if (!p.isDead()) {
        p.update();
        p.display();
      }
    }
  }

  boolean isEmpty () {
    return particles.size() == 0;
  }
}