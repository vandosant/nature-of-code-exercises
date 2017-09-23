int width = 640;
int height = 240;
Walker w1;

void setup() 
{
  size(640, 240);
  w1 = new Walker();
  background(255);
}

void draw() {
  w1.step();
  w1.display();
} 

class Walker {
  int x;
  int y;
  Walker() {
    x = width/2;
    y = height/2;
  }

  void display() {
    stroke(0);
    point(x, y);
  }

  void step() {
    float stepsize = montecarlo()*50;
    float stepx = random(-1,1);
    float stepy = random(-1,1);
    x += stepx * stepsize;
    y += stepy * stepsize;
    x = constrain(x, 0, width - 1);
    y = constrain(y, 0, height - 1);
  }
}

float montecarlo() {
  while (true) {
    float r1 = random(1);
    float p = pow(1.0 - r1, 8);
    float r2 = random(1);
    if (r2 < p) {
      return r1;
    }
  }
}