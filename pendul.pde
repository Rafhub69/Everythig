class Pendulum {
    
  LotsOfFunctions colorDetermination;
  float lengh = 250, radius = 24, mass = 1;
  float acceleration, velocity, angle = PI;
  PVector position; // position of pendulum ball
  PVector origin = new PVector(width / 2, height/3); 
  float gravity = 1.9620000000000000, damping = 0.998; 
  HashMap<String, Float> fieldVariables = new HashMap<String, Float>(9);

  Pendulum(float a1_, PVector origin_) 
  {
    angle = a1_;
    inicjalization(origin_);
  }
  
  Pendulum(float a1_, float lengh_, float mass_, PVector origin_) 
  {

    angle = a1_;
    mass = mass_;
    lengh = lengh_;   
    inicjalization(origin_);
  }

  Pendulum(PVector origin_, float radius_, float gravity_, float damping_, float angle_, float penVel_, float penAcc_, float lengh_, float mass_)
  {
    mass = mass_;
    angle = angle_;
    lengh = lengh_;
    radius = radius_;
    velocity = penVel_;  
    gravity = gravity_;
    damping = damping_;
    acceleration = penAcc_;    

    inicjalization(origin_);
  }

  void inicjalization(PVector origin_)
  {
    position = new PVector(lengh * sin(angle), lengh * cos(angle));
    position.add(origin_);

    colorDetermination = new LotsOfFunctions(velocity, acceleration, angle);
    
    fieldVariables.put("mass", mass);
    fieldVariables.put("angle", angle);
    fieldVariables.put("lengh", lengh);    
    fieldVariables.put("radius", radius);
    fieldVariables.put("penVel", velocity);
    fieldVariables.put("gravity", gravity);
    fieldVariables.put("damping", damping);    
    fieldVariables.put("origin.x", origin.x);
    fieldVariables.put("origin.y", origin.y);        
  }


  void update()
  {

    acceleration = (-gravity / lengh) * sin(angle);

    velocity += acceleration * delta_time;
    angle += velocity;

    position.set(lengh * sin(angle), lengh * cos(angle));
    position.add(origin);   
    velocity *= damping;
  }

  void setSpeed(PVector force) 
  {
    PVector f = force.copy();
    acceleration = mag(PVector.div(f, mass).x, PVector.div(f, mass).y);
    velocity += acceleration;
    position.add(velocity, velocity);
  }

  void setingFieldVariables()
  {  
    fieldVariables.replace("angle", angle);
    fieldVariables.replace("lengh", lengh);
    fieldVariables.replace("radius", radius);
    fieldVariables.replace("penVel", velocity);
    fieldVariables.replace("gravity", gravity);
    fieldVariables.replace("damping", damping);    
    fieldVariables.replace("origin.x", origin.x);
    fieldVariables.replace("origin.y", origin.y);
  }

  void drawing()
  {

    //finding the smallest and largest limit values used to change the color of objects
    colorDetermination.findingSmallestAndBiggestValue(velocity, acceleration, angle);

    stroke(255);
    fill(colorDetermination.valueMapping(0, velocity, 10, 255), colorDetermination.valueMapping(1, acceleration, 10, 255), colorDetermination.valueMapping(2, angle, 10, 255));
    line(origin.x, origin.y, position.x, position.y);
    circle( position.x, position.y, 2 * radius);
  }
}
