Oscillator[] oscillators1 = new Oscillator[1040/5];
Oscillator[] oscillators2 = new Oscillator[520/5];
float startAngle1 = 0;
float angleVel1 = 0.1;
float amplitude1 = 640;

float startAngle2 = 0;
float angleVel2 = 0.1;
float amplitude2 = 640;

void setup () {
  size(1040,640);
  for (int i = 0; i < oscillators1.length; i += 1) {
    oscillators1[i] = new Oscillator(i*5, 0);
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
  startAngle1 += 0.018;
}

class Oscillator  {
  float angle, x, y;

  Oscillator(float x, float y)  {
    angle = 0;
    this.x = x;
    this.y = y;
  }

  void oscillate(float angle)  {
    y = map(sin(angle),-1,1,0,amplitude1);
  }

  void display()  {
    pushMatrix();
    smooth();
    noStroke();
    fill(141, 31, 71, 95);
    ellipse(x,y,16,16);
    popMatrix();
  }
}