class Pendulum {

  PVector origin = new PVector(width / 2, height/3); 
  PVector position; // position of pendulum ball
  float penAcc, penVel, angle = PI;
  float lengh = 250, radius = 24, mass = 1;
  float gravity = 1.9620000000000000, damping = 0.998;       // Arbitary damping amount
  LotsOfFunctions colorDetermination;
  HashMap<String, Float> fieldVariables = new HashMap<String, Float>(8);
  ControlP5 cp5;


  Pendulum(float a1_, PVector origin_) {

    angle = a1_;
    inicjalization(origin_);
  }

  Pendulum(PVector origin_, float radius_, float gravity_, float damping_, float angle_, float penVel_, float acc_, float lengh_)
  {
    radius = radius_;
    gravity = gravity_;
    damping = damping_;
    angle = angle_;
    penVel = penVel_;
    lengh = lengh_;
    penAcc  = acc_;

    inicjalization(origin_);
  }

  void inicjalization(PVector origin_)
  {
    position = new PVector(lengh*sin(angle), lengh*cos(angle));
    position.add(origin_);

    colorDetermination = new LotsOfFunctions(penVel, penAcc, angle);

    fieldVariables.put("radius", radius);
    fieldVariables.put("gravity", gravity);
    fieldVariables.put("damping", damping);
    fieldVariables.put("angle", angle);
    fieldVariables.put("origin.x", origin.x);
    fieldVariables.put("origin.y", origin.y);
    fieldVariables.put("penVel", penVel);
    fieldVariables.put("lengh", lengh);
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
    fieldVariables.replace("radius", radius);
    fieldVariables.replace("gravity", gravity);
    fieldVariables.replace("damping", damping);
    fieldVariables.replace("angle", angle);
    fieldVariables.replace("origin.x", origin.x);
    fieldVariables.replace("origin.y", origin.y);
    fieldVariables.replace("penVel", penVel);
    fieldVariables.replace("lengh", lengh);

    return 3;
  }

  void drawing()
  {

    //finding the smallest and largest limit values used to change the color of objects
    colorDetermination.findingSmallestAndBiggestValue(penVel, penAcc, angle);

    stroke(255);
    fill(colorDetermination.valueMapping(0, penVel, 10, 255), colorDetermination.valueMapping(1,penAcc, 10, 255), colorDetermination.valueMapping(2, angle, 10, 255));
    line(origin.x, origin.y, position.x, position.y);
    circle( position.x, position.y, 2 * radius);
  }
}
