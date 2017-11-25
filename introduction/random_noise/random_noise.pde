int height = 640;
int width = 640;
void setup() 
{
  size(640, 640);
}

void draw() {
  loadPixels();
  for (int x = 0; x < width; x+=1) {
    for (int y = 0; y < height; y+=1) {
      float brightness = random(255);
      pixels[x+y*width] = color(brightness);
    }
  }
  updatePixels();
}