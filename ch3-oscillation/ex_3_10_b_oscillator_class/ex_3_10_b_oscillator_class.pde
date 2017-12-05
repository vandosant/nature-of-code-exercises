Oscillator[] oscillators = new Oscillator[width];
float startAngle = 0;
float angleVel = 0.1;

void setup () {
  size(1040,640);
  for (int i = 0; i < oscillators.length; i += 1) {
    oscillators[i] = new Oscillator(new PVector(i*14, 0), new PVector(10, height), 320);
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
  float amplitude, angle, x, y;

  Oscillator(PVector origin, PVector size, float amplitude)  {
    this.angle = 0;
    this.y = 0;
    this.amplitude = amplitude;
    this.location = origin;
    this.size = size;
  }

  void oscillate(float angle)  {
    y = map(sin(angle), -1, 1, 0, amplitude);
  }

  void display()  {
    float alpha = map(y, 0, 1, 0, 100);
    pushMatrix();
    translate(location.x, location.y);
    noStroke();
    smooth();
    fill(y, 0, 0, alpha);
    rect(0, y, size.x, size.y - y * 2);
    popMatrix();
  }
}