
// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// A rectangular box
class Box  {

  Body body;
  float w,h;

  // Constructor
  Box(float _x, float _y, float _w, float _h) {
    w = _w;
    h = _h;
    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    bd.position.set(box2d.coordPixelsToWorld(_x,_y));
    body = box2d.createBody(bd);

    CircleShape s = new CircleShape();
    s.m_radius = box2d.scalarPixelsToWorld(w/2);
    
    FixtureDef fd = new FixtureDef();
    fd.shape = s;
    fd.density = 1;
    fd.friction = 0.9;
    fd.restitution = 0.8;
    body.createFixture(fd);
  }

  // Drawing the box
  void display() {
    Vec2 pos = box2d.getBodyPixelCoord(body);
    float a = body.getAngle();
    pushMatrix();
    fill(255,204,0);
    stroke(204, 102, 0);
    strokeWeight(2);
    rectMode(CENTER);
    translate(pos.x,pos.y);
    rotate(-a);
    ellipse(0,0,w,w);
    popMatrix();
  }
  
  void killBody() {
    Vec2 pos = box2d.getBodyPixelCoord(body);
    float a = body.getAngle();
    pushMatrix();
    fill(255,204,0);
    stroke(204, 102, 0);
    strokeWeight(w/2);
    rectMode(CENTER);
    translate(pos.x,pos.y);
    rotate(-a);
    rect(0,0,w*2,h*2);
    popMatrix();
    box2d.destroyBody(body);
  }
}