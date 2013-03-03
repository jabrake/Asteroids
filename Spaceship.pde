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
