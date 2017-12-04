Oscillator[] oscillators = new Oscillator[width];
float startAngle = 0;
float angleVel = 0.1;

void setup () {
  size(1040,640);
  for (int i = 0; i < oscillators.length; i += 1) {
    oscillators[i] = new Oscillator(new PVector(i*14, -0), 255);
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

  startAngle += 0.008;
}

class Oscillator  {
  PVector origin;
  float amplitude, angle, x, g;

  Oscillator(PVector origin, float amplitude)  {
    this.angle = 0;
    this.g = 0;
    this.amplitude = amplitude;
    this.origin = origin;
  }

  void oscillate(float angle)  {
    g = map(sin(angle), -1, 1, 0, amplitude);
  }

  void display()  {
    float alpha = map(g, 0, 1, 0, 100);
    pushMatrix();
    noStroke();
    smooth();
    fill(0, g, 0, alpha);
    ellipse(origin.x,height/2,10,10);
    popMatrix();
  }
}