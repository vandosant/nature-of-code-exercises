Oscillator[] oscillators = new Oscillator[width];
float theta = 0.0;
float angleVel = 0.005;

void setup () {
  size(1040,640);
  
  int oscillatorWidth = 14;
  for (int i = 0; i < oscillators.length; i += 1) {
    oscillators[i] = new Oscillator(
      new PVector(i*oscillatorWidth, 0),
      new PVector(10, height),
      320
    );
  }
}

void draw() {
  background(0);
    
  float angle = theta;
  for (int i = 0; i < oscillators.length; i += 1) {
    oscillators[i].oscillate(angle);
    oscillators[i].display();
    angle += angleVel;
  }
  theta += 0.02;
}

class Oscillator  {
  PVector location, size;
  float amplitude, angle, x, y;
  boolean isSinOscillator;

  Oscillator(PVector origin, PVector size, float amplitude)  {
    this.angle = 0;
    this.y = 0;
    this.amplitude = amplitude;
    this.location = origin;
    this.size = size;
    this.isSinOscillator = random(1) < random(1);
  }

  void oscillate(float angle)  {
    if (isSinOscillator) {
      y = sinOscillate(angle);
    } else {
      y = cosOscillate(angle);
    }
  }
  
  float sinOscillate(float angle)  {
    return map(sin(angle), -1, 1, 0, amplitude);
  }
  
  float cosOscillate(float angle)  {
    return map(cos(angle), -1, 1, 0, amplitude);
  }

  void display()  {
    pushMatrix();
    translate(location.x, location.y);
    noStroke();
    smooth();
    fill(255, 0, 0);
    rect(0, y, size.x, size.y - y * 2);
    popMatrix();
  }
}