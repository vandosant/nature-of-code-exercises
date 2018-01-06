import java.util.ArrayList;
import java.util.Iterator;
import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.joints.*;

Box2DProcessing box2d;

ArrayList<Box> boxes;
ArrayList<Boundary> boundaries;

void setup() {
  size(940,360);

  boxes = new ArrayList<Box>();
  boundaries = new ArrayList<Boundary>();
  
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  
  boundaries.add(new Boundary(0, height*0.7, width, height*0.3));
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
}