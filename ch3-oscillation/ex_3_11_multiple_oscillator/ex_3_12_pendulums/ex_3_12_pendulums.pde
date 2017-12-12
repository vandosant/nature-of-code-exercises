Pendulum[] pendulums = new Pendulum[6];
Pendulum p;

PVector[] origins = new PVector[6];

void setup () {
  size(1040, 840);
  int armLength = width/10;
  for (int i = 0; i < origins.length; i++) {
    origins[i] = new PVector(width/2, height/8);
  }

  for (int i = 0; i < pendulums.length; i++) {
    pendulums[i] = new Pendulum(
      origins[i],
      random(armLength/2, armLength),
      42,
      PI / random(1, 3)
     );
  }
}

void draw () {
  background(0);
  for (int i = 0; i < pendulums.length; i++) {
    if (i == 0) {
      PVector origin = pendulums[i].origin;
      pendulums[i].update(origin);
    } else {
      PVector origin = pendulums[i-1].bobLocation;
      pendulums[i].update(origin);
    }
    pendulums[i].display();
  }
}

class Pendulum {
  float armLength;
  PVector bobLocation;
  float bobRadius;
  PVector origin;
  float gravity = 0.3;
  float aVelocity = 0.0;
  float aAcceleration = 0.0;
  float angle;

  Pendulum (PVector startOrigin, float armLength, float bobRadius, float startAngle) {
    this.armLength = armLength;
    this.bobRadius = bobRadius;
    this.origin = startOrigin;
    this.angle = startAngle;
  }
  
  void display () {
    smooth();
    strokeWeight(bobRadius / 10);
    stroke(100);
    line(origin.x, origin.y, bobLocation.x, bobLocation.y);
    ellipse(bobLocation.x, bobLocation.y, bobRadius, bobRadius);
  }
  
  void update (PVector nextOrigin) {
    this.origin = nextOrigin;
    aAcceleration = (-1 * gravity * sin(angle)) / armLength;
    aVelocity += aAcceleration;
    angle += aVelocity;
    aVelocity *= 0.999;
    
    bobLocation = new PVector(armLength * sin(angle), armLength * cos(angle));
    bobLocation.add(origin);
  }
}