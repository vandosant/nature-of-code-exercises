Oscillator[] oscillators1 = new Oscillator[1240/5];
Oscillator[] oscillators2 = new Oscillator[520/5];
float startAngle1 = 0;
float angleVel1 = 0.1;

float startAngle2 = 0;
float angleVel2 = 0.1;

void setup () {
  size(1040,640);
  for (int i = 0; i < oscillators1.length; i += 1) {
    oscillators1[i] = new Oscillator(new PVector(i*2, 0), 640);
  }
  for (int i = 0; i < oscillators2.length; i += 1) {
    oscillators2[i] = new Oscillator(new PVector(width/2 + i*2, height / 2), 100);
  }
}

void draw() {
  background(0);
    
  float angle1 = startAngle1;
  float angle2 = startAngle2;

  for (int i = 0; i < oscillators1.length; i += 1) {
    oscillators1[i].oscillate(angle1);
    oscillators1[i].display();
    angle1 += angleVel1;
  }

  for (int i = 0; i < oscillators2.length; i += 1) {
    oscillators2[i].oscillate(angle2);
    oscillators2[i].display();
    angle2 += angleVel2;
  }

  startAngle1 += 0.005;
  startAngle2 += 0.08;
}

class Oscillator  {
  float amplitude, angle, y;
  PVector origin;

  Oscillator(PVector origin, float amplitude)  {
    this.origin = origin;
    this.amplitude = amplitude;
    this.angle = 0;
    this.y = 0;
  }

  void oscillate(float angle)  {
    y = map(sin(angle),-1,1,origin.y + 0, origin.y + amplitude);
  }

  void display()  {
    pushMatrix();
    smooth();
    noStroke();
    fill(141, 31, 71, 95);
    ellipse(origin.x,y,12,12);
    popMatrix();
  }
}