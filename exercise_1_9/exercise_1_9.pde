int height = 640;
int width = 640;
float t = 0.0;

void setup() 
{
  size(640, 640);
}

void draw() {
  loadPixels();
  float xoff = t;
  for (int x = 0; x < width; x+=1) {
    float yoff = t;
    for (int y = 0; y < height; y+=1) {
      noiseDetail(4,0.6);
      float brightness = map(noise(xoff,yoff),0,1,0,255);
      pixels[x+y*width] = color(brightness, brightness / 2, brightness / 2);
      yoff += 0.05;
    }
    xoff += 0.05;
  }
  t += 0.1;
  updatePixels();
}