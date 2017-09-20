int width = 200;
int height = 200;
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
    stroke(1);
    point(x, y);
  }

  void step() {
    float rand = random(1);
    if (rand < 0.5) {
      if (mouseX > x) {
        x+=1;
      } else {
        x-=1;
      }
      if (mouseY > y) {
        y+=1;
      } else {
        y-=1;
      }
    }
  }
}