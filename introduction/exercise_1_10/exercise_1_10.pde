int height = 640;
int width = 640;
float[][] z = new float[height][width];

void setup() 
{
  size(640, 640, P3D);
}

void draw() {
  camera(width / 2.0 + 100, height + 120, (height/2.0) / tan(PI*30.0 / 180.0),
    width/2.0, height/2.0, 0, 0, 1, 0.5);
  rotateX(-PI/8);
  rotateY(PI/3);
  rotateZ(-PI/8);
  float xoff = 0.0;
  for (int x = 0; x < width; x+=10) {
    float yoff = 0.0;
    for (int y = 0; y < height; y+=10) {
      noiseDetail(4,0.6);
      z[x][y] = map(
        noise(
          xoff,
          yoff)
          ,0,1,0,50);
      yoff += 0.1;
    }
    xoff += 0.1;
  }

  for (int x = 0; x < width; x+=10) {
    for (int y = 0; y < height; y+=10) {
      beginShape(TRIANGLES);
      vertex(x - 10, y - 10, z[x][y]);
      vertex(x, y - 10, z[x][y]);
      vertex(x, y, 0);
      
      vertex(x, y - 10, z[x][y]);
      vertex(x, y, z[x][y]);
      vertex(x, y, 0);
      
      vertex(x, y, z[x][y]);
      vertex(x - 10, y, z[x][y]);
      vertex(x, y, 0);
      
      vertex(x - 10, y, z[x][y]);
      vertex(x - 10, y - 10, z[x][y]);
      vertex(x, y, 0);
      endShape(CLOSE);
    }
  }
}