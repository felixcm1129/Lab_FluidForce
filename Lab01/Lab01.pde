int nbMovers = 50;

Mover[] movers;

Helium helium;

Fluid fluid;

Boolean fluidForce = false;

void setup () {
  size (800, 600);
  movers = new Mover[nbMovers];
  
  fluidForce = false;
  
  fluid = new Fluid();
  
  for (int i = 0; i < movers.length; i++) {
    movers[i] = new Mover(random(0.1, 5), 0, 0);
  }
  
  helium = new Helium(1, width/2, height/4);
  
}

void setFluid()
{
  float heightFluid = random(0.1 * height, 0.4 * height);
  float y_fluid = height - heightFluid;
  float x_fluid = random(0, 400);
  fluid.density = random(1.5, 3);
  
  fluid.setRectangle(new Rectangle(0, y_fluid, width, heightFluid));
}

void draw () {
  update();
  
  background (255);

  for (int i = 0; i < movers.length; i++) {
    movers[i].display();
  }
  
  helium.display();
   
   if(fluidForce)
  {
    fill(0, 0, 150, 50);
    fluid.display();
    String density = str(fluid.density);
    Rectangle rec = fluid.getRectangle();
    fill(0);
    float center_x = (rec.x + rec.w) / 2;
    float center_y = (rec.y + (rec.h / 2));
    text(density, center_x - 4, center_y);
    text("Félix Carle-Milette", center_x - 24, center_y + 15);
    println(center_y);
    println(rec.y);
  }
    
}

void update() {
  for (int i = 0; i < movers.length; i++) {
    
    if(mousePressed)
    {
      if(mouseButton == LEFT)
      {
        PVector wind = new PVector (0.1, 0);
        movers[i].applyForce(wind);
        helium.applyForce(wind);
      }
      else if(mouseButton == RIGHT)
      {
        PVector wind = new PVector (-0.1, 0);
        movers[i].applyForce(wind);
        helium.applyForce(wind);
      }
    }
    
    float m = movers[i].mass;

    if(fluidForce)
    {
      if (fluid.getRectangle().intersect(movers[i].getRectangle())) 
      {   
        PVector fForce = fluid.draggingForce(movers[i].velocity, movers[i].mass);
        movers[i].applyForce(fForce);
      }
    }
    
    
    PVector gravity = new PVector (0, 0.1 * m);

    movers[i].applyForce(gravity);
    movers[i].update();
    movers[i].checkEdges();
  } 
    
  float mHelium = helium.mass;
    
  PVector gravityHelium = new PVector (0, -0.01 * mHelium);

  helium.applyForce(gravityHelium);
    
  helium.update();
  helium.checkEdges();
  
}

void keyReleased()
{
  if(key == ' ')
  {
    fluidForce = !fluidForce;
    setFluid();
  }
  
  if(key == 'r')
  {
    setup();
  }
}
