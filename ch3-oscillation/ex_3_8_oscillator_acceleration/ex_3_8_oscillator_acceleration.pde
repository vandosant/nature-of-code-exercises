Oscillator[] oscillators = new Oscillator[500];

void setup () {
  size(1040,1040);
  for (int i = 0; i < oscillators.length; i++) {
    oscillators[i] = new Oscillator(
      new PVector(0.002 + i*0.001, 0.007 + i*0.001),
      new PVector(i, i)
    );
  }
}

void draw() {
  background(0);
  
  for (int i = 0; i < oscillators.length; i++) {
    oscillators[i].oscillate();
    oscillators[i].display();
  }
}

class Oscillator  {
  PVector angle;
  PVector velocity;
  PVector amplitude;
  float aVelocity = 0;
  PVector acceleration = new PVector(0.001, 0.001);

  Oscillator(PVector velocity, PVector amplitude)  {
    angle = new PVector();
    this.velocity = velocity;
    this.amplitude = amplitude;
  }

  void oscillate()  {
    velocity.add(acceleration);
    angle.add(velocity);
  }

  void display()  {
    // Oscillating on the x-axis
    float x = sin(angle.x) * amplitude.x;
    // Oscillating on the y-axis
    float y = sin(angle.y) * amplitude.y;

    pushMatrix();
    translate(width/2,height/2);
    noStroke();
    fill(141, 31, 71, 95);
    smooth();
    smooth();
    ellipse(x,y,16,16);
    popMatrix();
  }
}