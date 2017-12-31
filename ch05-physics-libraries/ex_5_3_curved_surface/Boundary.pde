class Boundary  {
  ArrayList<Vec2> boundary;
  Body body;
  float w,h;

  // Constructor
  Boundary(float _x, float _y, float _w, float _h) {
    w = _w;
    h = _h;
    
    boundary = new ArrayList<Vec2>();
    float angle = 0.0;
    float angleVel = 0.015;
    for (int i = 0; i < w; i++) {
      float y = map(sin(angle), -1, 1, _y, _y + h);
      boundary.add(new Vec2(_x+i, y));
      angle += angleVel;
    }

    ChainShape chain = new ChainShape();
    Vec2[] vertices = new Vec2[boundary.size()];
    for (int i = 0; i < vertices.length; i++) {
      vertices[i] = box2d.coordPixelsToWorld(boundary.get(i));
    }

    chain.createChain(vertices, vertices.length);
    
    BodyDef bd = new BodyDef();
    body = box2d.world.createBody(bd);
    body.createFixture(chain, 1);
  }

  void display() {
    noFill();
    stroke(204, 102, 0);
    strokeWeight(2);
    beginShape();
    for (Vec2 v: boundary) {
      vertex(v.x,v.y);
    }
    endShape();
  }
}