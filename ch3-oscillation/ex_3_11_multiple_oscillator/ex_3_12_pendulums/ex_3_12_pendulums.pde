Pendulum p;

void setup () {
  size(640, 640);
  p = new Pendulum(
    new PVector(width/2, height/2),
    height / 4,
    64
   );
}

void draw () {
  background(0);
  p.update();
  p.display();
}

class Pendulum {
  float armLength;
  PVector bobLocation;
  float bobRadius;
  PVector pivotLocation;
  float gravity = 0.3;
  float aVelocity = 0.0;
  float aAcceleration = 0.0;
  float angle = PI / 2;

  Pendulum (PVector pivotLocation, float armLength, float bobRadius) {
    this.armLength = armLength;
    this.bobRadius = bobRadius;
    this.pivotLocation = pivotLocation;
  }
  
  void display () {
    smooth();
    strokeWeight(bobRadius / 10);
    stroke(100);
    line(pivotLocation.x, pivotLocation.y, bobLocation.x, bobLocation.y);
    ellipse(bobLocation.x, bobLocation.y, bobRadius, bobRadius);
  }
  
  void update () {
    aAcceleration = (-1 * gravity * sin(angle)) / armLength;
    aVelocity += aAcceleration;
    angle += aVelocity;
    aVelocity *= 0.999;
    
    bobLocation = new PVector(armLength * sin(angle), armLength * cos(angle));
    bobLocation.add(pivotLocation);
  }
}