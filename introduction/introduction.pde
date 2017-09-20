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
    point(x,y);
  }
  
  void step() {
    int choice = int(random(4));
    if (choice == 0) {
      x++; 
    } else if (choice == 1) {
      x--; 
    } else if (choice == 2) {
      y++; 
    } else {
      y--; 
    }
  }
}