import java.util.Random;

int width = 640;
int height = 240;
float randx, randy;
float sd = 2;
float mean = 0.5;
Walker w1;
Random generatorx;
Random generatory;

void setup() 
{
  size(640, 240);
  w1 = new Walker();
  generatorx = new Random();
  generatory = new Random();
  background(255);
}

void draw() {
  randx = (float) generatorx.nextGaussian();
  randy = (float) generatorx.nextGaussian();
  w1.step(randx, randy);
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

  void step(float randx, float randy) {
    x+=sd * randx + mean;
    y+=sd * randy + mean;
  }
}