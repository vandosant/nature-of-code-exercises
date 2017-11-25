float angle, r, x1, y1, x2, y2;

void setup () {
  angle = 0;
  r = 10;
  x1 = -70;
  y1 = 0;
  x2 = 70;
  y2 = 0;
  size(300,300);
}

void draw () {
  background(0);
  translate(width/2, height/2);
  rotate(radians(angle));
  stroke(255);
  strokeWeight(3);
  line(x1,y1,x2,y2);
  ellipse(x1,y1,r,r);
  ellipse(x2,y2,r,r);
  smooth();
  angle += 2;
}