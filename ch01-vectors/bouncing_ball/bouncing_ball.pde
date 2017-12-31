  
PVector v1, v2, velocity;

void setup() {
  v1 = new PVector(40, 20);
  v2 = new PVector(25, 50);
  velocity = new PVector(1, 1);
  smooth();
}

void draw() {
  background(255);
  stroke(0);
  fill(175);
  v1.add(velocity);
  v2.add(velocity);
  ellipse(v1.x, v1.y, 12, 12);
  ellipse(v2.x, v2.y, 12, 12);
}