int height = 640;
int width = 640;

void setup() 
{
  size(640, 640);
}

void draw() {
  loadPixels();
  float xoff = 0.0;
  for (int x = 0; x < width; x+=1) {
    float yoff = 0.0;
    for (int y = 0; y < height; y+=1) {
      noiseDetail(8,0.6);
      float brightness = map(noise(xoff,yoff),0,1,0,255);
      pixels[x+y*width] = color(brightness, brightness / 2, brightness / 2);
      yoff += 0.01;
    }
    xoff += 0.01;
  }
  updatePixels();
}