void setup () {
  size(640,640);

}

void draw() {
  background(0);
  float period = 75;
  float amplitude = 100;
  float y = amplitude + amplitude * sin(TWO_PI  * frameCount/period);

  stroke(255);
  fill(255);
  smooth();
  line(width/2, 0, width/2, y);
  ellipse(width/2, y, 16, 16);
}