Spaceship ship;

float sizeShip = 16;

void setup() {
  size(600, 600);
  ship = new Spaceship();
}

void draw() {
  background(0);

  fill(255);
  text("LEFT and RIGHT to turn", 10, 15);
  text("SPACE to thrust", 10, 30);
  text("B to thrust backwards", 10, 45);
  text("L and R to spin", 10, 60);
  text("Z to stop", 10, 75);

  rect(random(width), random(height), random(0, 10), random(0, 10));

  ship.update();
  ship.bounce();
  ship.display();

  fill(0);

  if (keyPressed) {
    if (key == CODED && keyCode == LEFT) {
      ship.turn(-0.05);
    } 
    else if (key == CODED && keyCode == RIGHT) {
      ship.turn(0.05);
    } 
    else if (key == ' ') {
      ship.thrust();
      fill(175);
    }
    else if ((key == 'b') || (key == 'B')) {
      ship.back();
    }
    else if ((key == 'z') || (key == 'Z')) {
      ship.stopForce();
    }
    else if ((key == 'r') || (key == 'R')) {
      ship.turn(0.5);
    }
    else if ((key == 'l') || (key == 'L')) {
      ship.turn(-0.5);
    }
  }
}

class Spaceship { 

  PVector location;
  PVector velocity;
  PVector acceleration;

  float damping = 0.995;
  float topspeed = 20;

  float heading = 0;
  float size = 16;

  boolean thrusting = false;
  boolean backwards = false;

  Spaceship() {
    location = new PVector(width/2, height/2);
    velocity = new PVector();
    acceleration = new PVector();
  } 

  void update() { 
    velocity.add(acceleration);
    velocity.mult(damping);
    velocity.limit(topspeed);
    location.add(velocity);
    acceleration.mult(0);
  }

  void applyForce(PVector force) {
    PVector f = force.get();
    acceleration.add(f);
  }

  void stopForce() {
    velocity.mult(0);
  }

  void turn(float a) {
    heading += a;
  }

  void thrust() {
    float angle = heading - PI/2;
    PVector force = new PVector(cos(angle), sin(angle));
    force.mult(0.1);
    applyForce(force); 
    thrusting = true;
  }

  void back() {
    float angle = heading - PI/2;
    PVector force = new PVector(cos(angle), sin(angle));
    force.mult(-0.1);
    applyForce(force); 
    backwards = true;
  }

  void bounce() {
    if ((location.x > width) || (location.x < 0)) {
      velocity.x *= -1;
    }

    if ((location.y > height) || (location.y < 0)) {
      velocity.y *= -1;
    }
  }

  void display() { 
    stroke(0);
    strokeWeight(2);
    pushMatrix();
    translate(location.x, location.y+size);
    rotate(heading);
    fill(175);
    if (thrusting) fill(0, 255, 0);
    if (backwards) fill(255, 0, 0);

    beginShape();
    vertex(-size, size);
    vertex(0, -size);
    vertex(size, size);
    endShape(CLOSE);
    rectMode(CENTER);
    popMatrix();

    thrusting = false;
    backwards = false;
  }
}


