// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

import java.util.ArrayList;
import java.util.Iterator;
import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;

Box2DProcessing box2d;

// A list for all of our rectangles
ArrayList<Box> boxes;

void setup() {
  size(640,360);
  // Create ArrayLists
  boxes = new ArrayList<Box>();
  
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
}

void draw() {
  background(255);

  if (mousePressed) {
    boxes.add(new Box(mouseX, mouseY, random(8,16), random(8,16)));
    boxes.add(new Box(mouseX, mouseY, random(6,8), random(6,8)));
  }
  
  box2d.step();

  // Display all the boxes
  for (Box b: boxes) {
    b.display();
  }

  Iterator<Box> it = boxes.iterator();
  while (it.hasNext()) {
    Box b = it.next();
    Vec2 pos = box2d.getBodyPixelCoord(b.body);
    if (pos.y > height/2) {
      b.killBody();
      it.remove();
    }
  }
}