
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

    Vec2[] vertices = new Vec2[5];
    vertices[0] = box2d.vectorPixelsToWorld(new Vec2(0,25));
    vertices[1] = box2d.vectorPixelsToWorld(new Vec2(20,0));
    vertices[2] = box2d.vectorPixelsToWorld(new Vec2(10,-10));
    vertices[3] = box2d.vectorPixelsToWorld(new Vec2(-10,-10));
    vertices[4] = box2d.vectorPixelsToWorld(new Vec2(-20,0));
    PolygonShape s = new PolygonShape();
    s.set(vertices, vertices.length);
    
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
    Fixture f = body.getFixtureList();
    PolygonShape s = (PolygonShape) f.getShape();

    fill(255,204,0);
    stroke(204, 102, 0);
    strokeWeight(2);
    rectMode(CENTER);
    pushMatrix();
    translate(pos.x,pos.y);
    rotate(-a);
    beginShape();
    for (int i = 0; i < s.getVertexCount(); i++) {
      Vec2 v = box2d.vectorWorldToPixels(s.getVertex(i));
      vertex(v.x,v.y);
    }
    endShape(CLOSE);
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