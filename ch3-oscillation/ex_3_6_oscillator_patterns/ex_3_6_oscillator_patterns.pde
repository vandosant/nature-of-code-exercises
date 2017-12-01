Oscillator[] oscillators = new Oscillator[200];

void setup () {
  size(640,640);
  for (int i = 0; i < oscillators.length; i++) {
    oscillators[i] = new Oscillator(
      new PVector(0.003 + i*0.001, 0.008 + i*0.001),
      new PVector(10 + i*2, 10 + i*2)
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

  Oscillator(PVector velocity, PVector amplitude)  {
    angle = new PVector();
    this.velocity = velocity;
    this.amplitude = amplitude;
  }

  void oscillate()  {
    angle.add(velocity);
  }

  void display()  {
    // Oscillating on the x-axis
    float x = cos(angle.x) * amplitude.x;
    // Oscillating on the y-axis
    float y = cos(angle.y) * amplitude.y;

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