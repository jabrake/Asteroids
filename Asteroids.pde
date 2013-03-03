import java.util.Iterator;

Spaceship ship;
ParticleSystem ps;
float sizeShip = 16;
float heading = 0;

void setup() {
  size(600, 600);
  ship = new Spaceship();
  ps = new ParticleSystem(new PVector(width/2, 50));
}

void draw() {
  background(0);
  
  PVector particleThrust = new PVector(0,0.05);
  ps.applyForce(particleThrust);

  fill(255);
  text("LEFT and RIGHT to turn", 10, 15);
  text("SPACE to thrust", 10, 30);
  text("B to thrust backwards", 10, 45);
  text("L and R to spin", 10, 60);
  text("Z to stop", 10, 75);

  //Stars
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
      float angle = heading - PI/2;
      ps.addParticle();
      ps.run();
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

