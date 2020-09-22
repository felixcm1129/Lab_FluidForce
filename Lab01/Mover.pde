class Mover {
  PVector location;
  PVector velocity;
  PVector acceleration;
  
  PVector size;
  float topSpeed;
  float mass;
  
  float rayon;
  
  Mover () {
    
    this.location = new PVector (random (width), random (height));    
    this.velocity = new PVector (0, 0);
    this.acceleration = new PVector (0 , 0);
    this.size = new PVector (16, 16);
    
    this.mass = 1;
  }  
  
  Mover (PVector loc, PVector vel) {
    this.location = loc;
    this.velocity = vel;
    this.acceleration = new PVector (0 , 0);
    this.size = new PVector (16, 16);
    this.topSpeed = 100;
  }
  
  Mover (float m, float x, float y) {
    mass = m;
    location = new PVector (x, y);
    
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
    size = new PVector (16, 16);
    
    rayon = (m * 16)/2;
  }
  
  void update () {
    velocity.add (acceleration);
    location.add (velocity);

    acceleration.mult (0);
  }
  
  void display () {
    stroke (0);
    fill (0, 0, 0, 50);
    
    ellipse (location.x, location.y, mass * size.x, mass * size.y); // Dimension à l'échelle de la masse
  }
  
  void checkEdges() {
    if (location.x > width - rayon) {
      location.x = width - rayon;
      velocity.x *= -0.9;
    } else if (location.x < rayon) {
      velocity.x *= -0.9;
      location.x = rayon;
    }
    
    if (location.y > height - rayon) {
      velocity.y *= -0.9;
      location.y = height - rayon;
    }
  }
  
  
  void applyForce (PVector force) {
    PVector f = PVector.div (force, mass);
   
    this.acceleration.add(f);
  }
  
  Rectangle getRectangle() {
    Rectangle r = new Rectangle(location.x, location.y, size.x, size.y);
    
    return r;
  }
}
