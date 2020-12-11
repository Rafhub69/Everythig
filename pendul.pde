class Pendulum {

  PVector origin = new PVector(width / 2, height/3); 
  PVector position; // position of pendulum ball
  float penAcc, penVel, angle = PI;
  float lengh = 250, radius = 24;
  float gravity = 0.49050000000000000, damping = 0.998;       // Arbitary damping amount
  Function[] fun = new Function[3];
  HashMap<String, Float> fieldVariables = new HashMap<String, Float>(8);
  ControlP5 cp5;


  Pendulum(float a1_, PVector origin_) {

    angle = a1_;
    position = new PVector(lengh*sin(angle), lengh*cos(angle));
    position.add(origin_); 

    fun[0] = new Function(angle, angle);
    fun[1] = new Function(penVel, penVel);
    fun[2] = new Function(penAcc, penAcc);
    
    fieldVariables.put("radius", radius);
    fieldVariables.put("gravity", gravity);
    fieldVariables.put("damping", damping);
    fieldVariables.put("angle", angle);
    fieldVariables.put("origin.x", origin.x);
    fieldVariables.put("origin.y", origin.y);
    fieldVariables.put("penVel", penVel);
    fieldVariables.put("lengh", lengh);
  }
  
  Pendulum(PVector origin_, float radius_, float gravity_, float damping_, float angle_, float penVel_,float lengh_)
  {
    radius = radius_;
    gravity = gravity_;
    damping = damping_;
    angle = angle_;
    penVel = penVel_;
    lengh = lengh_;
    
    position = new PVector(lengh*sin(angle), lengh*cos(angle));
    position.add(origin_);
    
    fun[0] = new Function(angle, angle);
    fun[1] = new Function(penVel, penVel);
    fun[2] = new Function(penAcc, penAcc);
    
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

    penVel += penAcc;
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

  int showingData()
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
    fun[0].findingTheItem(angle);
    fun[1].findingTheItem(penVel);
    fun[2].findingTheItem(penAcc);

    stroke(255);
    fill((map(angle, fun[0].smallestItem, fun[0].largestItem, 10, 255)), (map(penVel, fun[1].smallestItem, fun[1].largestItem, 10, 255)), (map(penAcc, fun[2].smallestItem, fun[2].largestItem, 10, 255)));
    line(origin.x, origin.y, position.x, position.y);
    circle( position.x, position.y, 2 * radius);
  }
}
