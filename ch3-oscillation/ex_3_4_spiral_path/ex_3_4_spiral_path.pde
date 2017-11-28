float r = 6;
float theta = 0;

void setup () {
  size(640,640);
  background(255);
}

void draw() {
  float x = r * cos(theta);
  float y = r * sin(theta);

  noStroke();
  fill(0);
  smooth();
  ellipse(x+width/2, y+height/2, 16, 16);
 
  theta += 0.01;
  r += 0.05;
}