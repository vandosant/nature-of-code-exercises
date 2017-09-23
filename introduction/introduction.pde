int width = 640;
int height = 640;
float xoff, yoff;
Walker w1;

void setup() 
{
  size(640, 640);
  background(22, 20, 38);
  w1 = new Walker();
  xoff = 0;
  yoff = 8888;
}

void draw() {
  w1.step();
  w1.display();
} 

class Walker {
  float x, y, prevX, prevY;

  Walker() {
    x = width/2;
    y = height/2;
  }

  void display() {
    stroke(140, 31, 71);
    point(x, y);
    line(prevX, prevY, x, y);
  }

  void step() {
    prevX = x;
    prevY = y;
    float stepsize = montecarlo()*1.5;
    xoff += stepsize;
    yoff += stepsize;
    x = map(noise(xoff), 0, 1, 0, width);
    y = map(noise(yoff), 0, 1, 0, height);
  }
}

float montecarlo() {
  while (true) {
    float r1 = random(1);
    float p = pow(1.0 - r1, 24);
    float r2 = random(1);
    if (r2 < p) {
      return r1;
    }
  }
}