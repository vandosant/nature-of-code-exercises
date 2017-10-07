int width = 640;
int height = 640;
PVector offset;
Walker w1;

void setup() 
{
  size(640, 640);
  background(22, 20, 38);
  w1 = new Walker();
  offset = new PVector(0, 8888);
}

void draw() {
  w1.step();
  w1.display();
} 

class Walker {
  PVector v, prev;

  Walker() {
    v = new PVector(width/2, height/2);
    prev = new PVector(v.x, v.y);
  }

  void display() {
    stroke(140, 31, 71);
    point(v.x, v.y);
    line(prev.x, prev.y, v.x, v.y);
  }

  void step() {
    prev.x = v.x;
    prev.y = v.y;
    float stepsize = montecarlo()*1.5;
    offset.x += stepsize;
    offset.y += stepsize;
    v.x = map(noise(offset.x), 0, 1, 0, width);
    v.y = map(noise(offset.y), 0, 1, 0, height);
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