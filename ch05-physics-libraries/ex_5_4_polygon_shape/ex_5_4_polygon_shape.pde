import java.util.ArrayList;
import java.util.Iterator;
import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;

Box2DProcessing box2d;

ArrayList<Box> boxes;
ArrayList<Boundary> boundaries;

void setup() {
  size(940,360);

  boxes = new ArrayList<Box>();
  boundaries = new ArrayList<Boundary>();
  
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  
  boundaries.add(new Boundary(0, height/2, width, height/2));
}

void draw() {
  background(255);

  if (mousePressed) {
    boxes.add(new Box(mouseX, mouseY, random(8,16), random(8,16)));
  }
  
  box2d.step();

  for (Box b: boxes) {
    b.display();
  }
  
  for (Boundary b: boundaries) {
    b.display();
  }

  Iterator<Box> it = boxes.iterator();
  while (it.hasNext()) {
    Box b = it.next();
    Vec2 pos = box2d.getBodyPixelCoord(b.body);
    if (pos.y > height) {
      b.killBody();
      it.remove();
    }
  }
}