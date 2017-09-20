int width = 200;
int height = 200;
Walker w1;

void setup() 
{
  size(200, 200);
  frameRate(30);
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
    stroke(10);
    point(x, y);
  }

  void step() {
    int stepx = int(random(4)) - 1;
    int stepy = int(random(3)) - 1;
    x+=stepx;
    y+=stepy;
  }
}