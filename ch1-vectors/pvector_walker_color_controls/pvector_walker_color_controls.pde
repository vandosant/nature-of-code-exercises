int width = 640;
int height = 640;
PVector offset;
Walker w;

void setup() 
{
  size(640, 640);
  w = new Walker();
  offset = new PVector(0, 8888);
  background(22, 20, 38);
  println("Hold up or down to change color");
}

void draw() {
  w.step();
  w.display();
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      w.r = w.r + 10;
      w.g = w.g + 10;
      w.b = w.b + 10;
    } else if (keyCode == DOWN) {
      w.r = w.r - 10;
      w.g = w.g - 10;
      w.b = w.b - 10;
    } 
  }
}

class Walker {
  PVector v, prev;
  int r, g, b;

  Walker() {
    v = new PVector(width/2, height/2);
    prev = new PVector(v.x, v.y);
    r = 140;
    g = 31;
    b = 71;
  }

  void display() {
    stroke(r, g, b);
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
}