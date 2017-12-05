Oscillator[] oscillators = new Oscillator[width];
float startAngle = 0;
float angleVel = 0.1;

void setup () {
  size(1040,640);
  for (int i = 0; i < oscillators.length; i += 1) {
    oscillators[i] = new Oscillator(new PVector(i*14, 0), new PVector(10, height), 255);
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
  PVector location, size;
  float amplitude, angle, x, h;

  Oscillator(PVector origin, PVector size, float amplitude)  {
    this.angle = 0;
    this.h = 0;
    this.amplitude = amplitude;
    this.location = origin;
    this.size = size;
  }

  void oscillate(float angle)  {
    h = map(sin(angle), -1, 1, 0, amplitude);
  }

  void display()  {
    float alpha = map(h, 0, 1, 0, 100);
    pushMatrix();
    translate(location.x, location.y);
    noStroke();
    smooth();
    fill(h, 0, 0, alpha);
    rect(0, 0, size.x, size.y);
    popMatrix();
  }
}