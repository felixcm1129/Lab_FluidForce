class Helium{
  PVector location;
  PVector velocity;
  PVector acceleration;
  float mass;
  float topSpeed;
  float r;
  
  Helium(){
  this.location = new PVector(random(width), random(height));
  this.velocity = new PVector (0, 0);
  this.acceleration = new PVector (0 , 0);
    
  this.mass = 1;
  }
  
  Helium (PVector loc, PVector vel) {
    this.location = loc;
    this.velocity = vel;
    this.acceleration = new PVector (0 , 0);
    
    this.topSpeed = 100;
  }
  
  Helium (float m, float x, float y) {
    mass = m;
    location = new PVector (x, y);
    
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
    r = 16/2;
  }
  
  void update () {
    velocity.add (acceleration);
    location.add (velocity);

    acceleration.mult (0);
  }
  
  void display () {
    stroke (0);
    fill (0, 0, 255);
    ellipse (location.x, location.y, mass * 16, mass * 16); // Dimension à l'échelle de la masse
  }
  
   void checkEdges() {
    if (location.x > width - r) {
      location.x = width - r;
      velocity.x *= -0.9;
    } else if (location.x < r) {
      velocity.x *= -0.9;
      location.x = r;
    }
    
    if (location.y < r) {
      velocity.y *= -0.9;
      location.y = r;
    }
  }
  
  
  void applyForce (PVector force) {
    PVector f = PVector.div (force, mass);
   
    this.acceleration.add(f);
  }
}
