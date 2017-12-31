PVector u, v, w;

void setup() {
  background(0);
  size(18,18);
  stroke(255,255,255);
  u = new PVector(1, 5);
  v = PVector.mult(u, 2);
  w = PVector.sub(v, u);
  w.div(2);
}

void draw() {
  point(v.x, v.y);
  point(u.x, u.y);
  point(w.x, w.y);
}