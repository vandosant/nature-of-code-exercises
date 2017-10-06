int canvaswidth = 640;
int canvasheight = 640;
Walker[] walkers = {
  new Walker(140, 31, 71, canvaswidth/4, canvasheight/4, canvaswidth/2, canvasheight/2),
  new Walker(217, 34, 59, canvaswidth/4, canvasheight/4, canvaswidth/2, canvasheight/2),
  new Walker(242, 195, 53, canvaswidth/4, canvasheight/4, canvaswidth/2, canvasheight/2),
  new Walker(242, 123, 39, canvaswidth/4 * 2, canvasheight/4 * 2,
  canvaswidth/2 + canvaswidth/2,
  canvasheight/2 + canvasheight/2)
};

void setup() 
{
  size(640, 640);
  background(22, 20, 38);
}

void draw() {
  for (Walker w : walkers) {
    w.step();
    w.display();
  }
} 

class Walker {
  float x, y, prevX, prevY, xoff, yoff;
  int r, g, b, width, height;

  Walker(int r, int g, int b, float x, float y, int width, int height) {
    this.r = r;
    this.g = g;
    this.b = b;
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
    xoff = random(8888);
    yoff = random(8888);
  }

  void display() {
    stroke(r, g, b);
    point(x, y);
    line(prevX, prevY, x, y);
  }

  void step() {
    prevX = x;
    prevY = y;
    float stepsize = montecarlo();
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