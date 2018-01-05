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

    PolygonShape s2 = new PolygonShape();
    Vec2 offset = new Vec2(0,-h/2);
    Vec2[] vertices2 = new Vec2[5];
    vertices2[0] = box2d.vectorPixelsToWorld(new Vec2(-20,25+offset.y));
    vertices2[1] = box2d.vectorPixelsToWorld(new Vec2(20,25+offset.y));
    vertices2[2] = box2d.vectorPixelsToWorld(new Vec2(10,-10+offset.y));
    vertices2[3] = box2d.vectorPixelsToWorld(new Vec2(0,-25+offset.y));
    vertices2[4] = box2d.vectorPixelsToWorld(new Vec2(-20,0+offset.y));

    offset = box2d.vectorPixelsToWorld(offset);
    s2.set(vertices2, vertices2.length);

    body.createFixture(s, 1.0);
    body.createFixture(s2, 1.0);
  }

  // Drawing the box
  void display() {
    Vec2 pos = box2d.getBodyPixelCoord(body);
    float a = body.getAngle();
    Fixture f = body.getFixtureList();

    fill(255,204,0);
    stroke(204, 102, 0);
    strokeWeight(2);
    rectMode(CENTER);
    pushMatrix();
    translate(pos.x,pos.y);
    rotate(-a);
    for (int i = 0; i < 2; i++) {
      PolygonShape s = (PolygonShape) f.getShape();
      beginShape();
      for (int j = 0; j < s.getVertexCount(); j++) {
        Vec2 v = box2d.vectorWorldToPixels(s.getVertex(j));
        vertex(v.x,v.y);
      }
      f = f.getNext();
      endShape(CLOSE);
    }
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