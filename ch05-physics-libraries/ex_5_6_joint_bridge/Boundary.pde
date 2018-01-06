class Boundary  {
  ArrayList<Rect> boundary;
  Body body;
  float w,h;

  Boundary(float _x, float _y, float _w, float _h) {
    w = _w;
    h = _h;
    
    boundary = new ArrayList<Rect>();
    float rectWidth = 5;
    for (int i = 0; i < w; i+=5) {
      Rect r = new Rect(_x+i,_y,rectWidth*1.5,rectWidth*1.5,i==0||i>w-10);
      boundary.add(r);
    }
    
    for (int i = 0; i < boundary.size() - 1; i++) {
      DistanceJointDef djd = new DistanceJointDef();
      djd.bodyA = boundary.get(i).body;
      djd.bodyB = boundary.get(i+1).body;
      djd.length = box2d.scalarPixelsToWorld(rectWidth/2);
      djd.frequencyHz = 15;
      djd.dampingRatio = 10;
      box2d.world.createJoint(djd);
    }
  }

  void display() {
    noFill();
    stroke(204, 102, 0);
    strokeWeight(2);
    for (int i = 0; i < boundary.size() - 1; i++) {
      boundary.get(i).display();
    }
  }
}