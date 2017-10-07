int width, height, depth, max_velocity;
PVector[] objects = new PVector[50];
PVector[] velocity = new PVector[50];

void setup() {
  width = 640;
  height = 640;
  depth = 640;
  max_velocity = 3;

  for (int i = 0; i < objects.length; i++) {
    objects[i] = new PVector(random(width), random(height), random(depth));
    velocity[i] = new PVector(random(1, max_velocity), random(1, max_velocity), random(1, max_velocity));
  }

  size(640, 640, P3D);
  smooth();
}

void draw() {
  background(0);
  lights();
  stroke(0);
  fill(175);
  pushMatrix();
  noFill();
  stroke(255);
  translate(width/2, height/2, depth/2);
  box(width);
  popMatrix();
  
  camera(width / 2, height / 2, depth*2, width/2, height/2, 0, 0, 1, 0);
  for(int i = 0; i < objects.length; i++) {
    if (objects[i].x > width || objects[i].x < 0) {
      velocity[i].x = velocity[i].x * -1;
    }
    if (objects[i].y > height || objects[i].y < 0) {
      velocity[i].y = velocity[i].y * -1;
    }
    if (objects[i].z > depth || objects[i].z < 0) {
      velocity[i].z = velocity[i].z * -1;
    }
    objects[i].add(velocity[i]);
    pushMatrix();
    translate(objects[i].x, objects[i].y, objects[i].z);
    rotateY(1.25);
    rotateX(-0.4);
    noStroke();
    fill(255, 80, 65);
    sphere(12);
    popMatrix();
  }
}