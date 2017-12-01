Oscillator[] oscillators = new Oscillator[640/10];
float startAngle = 0;
float angleVel = 0.1;
float amplitude = 300;

void setup () {
  size(640,640);
  for (int i = 0; i < oscillators.length; i += 1) {
    oscillators[i] = new Oscillator(i*10, 0);
  }
}

void draw() {
  background(0);
    
  float angle = startAngle;

  for (int i = 0; i < oscillators.length; i += 1) {
    oscillators[i].oscillate(angle);
    oscillators[i].display();
    angle += angleVel;
  }
  startAngle += 0.018;
}

class Oscillator  {
  float angle, x, y;

  Oscillator(float x, float y)  {
    angle = 0;
    this.x = x;
    this.y = y;
  }

  void oscillate(float angle)  {
    y = map(sin(angle),-1,1,0,amplitude);
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