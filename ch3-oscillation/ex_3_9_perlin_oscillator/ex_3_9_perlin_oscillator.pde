float startAngle = 0;
float angleVel = 0.1;
float amplitude = 200;

void setup() {
  size(400,200);
  background(255);
}

void draw() {
  background(255);
  
  float angle = startAngle;

  for (int x = 0; x <= width; x += 5) {
    float y = map(noise(angle),-1,1,0,amplitude);
    smooth();
    noStroke();
    fill(141, 31, 71, 95);
    ellipse(x,y,16,16);
    angle += angleVel;
  }
  startAngle += 0.018;
}