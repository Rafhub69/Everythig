class Pendulum {
  
  float penAcc, penVel, angle = PI;
  LotsOfFunctions colorDetermination;
  float lengh = 250, radius = 24, mass = 1;
  PVector position; // position of pendulum ball
  PVector origin = new PVector(width / 2, height/3); 
  float gravity = 1.9620000000000000, damping = 0.998; 
  HashMap<String, Float> fieldVariables = new HashMap<String, Float>(8);

  Pendulum(float a1_, PVector origin_) {
    angle = a1_;
    inicjalization(origin_);
  }
  
  Pendulum(float a1_, float lengh_, float mass_, PVector origin_) {

    angle = a1_;
    mass = mass_;
    lengh = lengh_;   
    inicjalization(origin_);
  }

  Pendulum(PVector origin_, float radius_, float gravity_, float damping_, float angle_, float penVel_, float lengh_)
  {
    angle = angle_;
    lengh = lengh_;
    radius = radius_;
    penVel = penVel_;  
    gravity = gravity_;
    damping = damping_;

    inicjalization(origin_);
  }

  void inicjalization(PVector origin_)
  {
    position = new PVector(lengh*sin(angle), lengh*cos(angle));
    position.add(origin_);

    colorDetermination = new LotsOfFunctions(penVel, penAcc, angle);

    fieldVariables.put("angle", angle);
    fieldVariables.put("lengh", lengh);
    fieldVariables.put("penVel", penVel);
    fieldVariables.put("radius", radius);
    fieldVariables.put("gravity", gravity);
    fieldVariables.put("damping", damping);    
    fieldVariables.put("origin.x", origin.x);
    fieldVariables.put("origin.y", origin.y);        
  }


  void update()
  {

    penAcc = (-gravity / lengh) * sin(angle);

    penVel += penAcc * delta_time;
    angle += penVel;

    position.set(lengh*sin(angle), lengh*cos(angle));
    position.add(origin);   
    penVel *= damping;
  }

  void setSpeed(PVector force) {
    PVector f = force.copy();
    penAcc = mag(PVector.div(f, mass).x, PVector.div(f, mass).y);
    penVel += penAcc;
    position.add(penVel, penVel);
  }

  int setingFieldVariables()
  {  
    fieldVariables.replace("angle", angle);
    fieldVariables.replace("lengh", lengh);
    fieldVariables.replace("radius", radius);
    fieldVariables.replace("penVel", penVel);
    fieldVariables.replace("gravity", gravity);
    fieldVariables.replace("damping", damping);    
    fieldVariables.replace("origin.x", origin.x);
    fieldVariables.replace("origin.y", origin.y);
    
    return 3;
  }

  void drawing()
  {

    //finding the smallest and largest limit values used to change the color of objects
    colorDetermination.findingSmallestAndBiggestValue(penVel, penAcc, angle);

    stroke(255);
    fill(colorDetermination.valueMapping(0, penVel, 10, 255), colorDetermination.valueMapping(1, penAcc, 10, 255), colorDetermination.valueMapping(2, angle, 10, 255));
    line(origin.x, origin.y, position.x, position.y);
    circle( position.x, position.y, 2 * radius);
  }
}
