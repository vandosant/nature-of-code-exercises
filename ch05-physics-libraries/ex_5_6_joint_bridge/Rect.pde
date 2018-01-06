class Rect {

  Body body;
  float w,h;

  // Constructor
  Rect(float _x, float _y, float _w, float _h, boolean _fixed) {
    w = _w;
    h = _h;
    BodyDef bd = new BodyDef();
    if (_fixed) bd.type = BodyType.STATIC;
    else bd.type = BodyType.DYNAMIC;
    bd.position.set(box2d.coordPixelsToWorld(_x,_y));
    body = box2d.createBody(bd);

    PolygonShape ps = new PolygonShape();
    float boxW = box2d.scalarPixelsToWorld(w/2);
    float boxH = box2d.scalarPixelsToWorld(h/2);
    ps.setAsBox(boxW,boxH);
    
    FixtureDef fd = new FixtureDef();
    fd.shape = ps;
    fd.density = 1;
    fd.friction = 0.3;
    fd.restitution = 0.8;
    body.createFixture(fd);
  }

  void display() {
    Vec2 pos = box2d.getBodyPixelCoord(body);
    float a = body.getAngle();
    pushMatrix();
    fill(255,204,0);
    stroke(204, 102, 0);
    strokeWeight(w/4);
    rectMode(CENTER);
    translate(pos.x,pos.y);
    rotate(-a);
    rect(0,0,w,h);
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