Oscillator[] oscillators = new Oscillator[10];

void setup () {
  size(640,640);
  for (int i = 0; i < oscillators.length; i++) {
    oscillators[i] = new Oscillator(
      new PVector(0.003*i, 0.008*i),
      new PVector(10*i, 10*i)
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
    float x = sin(angle.x)*amplitude.x;
    // Oscillating on the y-axis
    float y = sin(angle.y)*amplitude.y;

    pushMatrix();
    translate(width/2,height/2);
    stroke(255);
    strokeWeight(2);
    fill(175);
    smooth();
    // Drawing the Oscillator as a line connecting a circle
    line(0,0,x,y);
    smooth();
    ellipse(x,y,16,16);
    popMatrix();
  }
}