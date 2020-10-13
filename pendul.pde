class pendulum {

  PVector origin = new PVector(width / 2, height/3); 
  PVector position; // position of pendulum ball
  float a1_a, a1_vel, angle =PI;
  float lengh = 250, radius = 24;
  float gravity = 0.4905, damping = 0.998;       // Arbitary damping amount
  Function[] fun = new Function[3];
  String[] fieldName = new String[3];
  float[] fieldValue = new float[3];
  ControlP5 cp5;


  pendulum(float a1_, PVector origin_) {

    angle = a1_;
    position = new PVector(lengh*sin(angle), lengh*cos(angle));
    position.add(origin_); 

    fun[0] = new Function(angle, angle);
    fun[1] = new Function(a1_vel, a1_vel);
    fun[2] = new Function(a1_a, a1_a);
  }


  void update()
  {

    a1_a = (-gravity / lengh) * sin(angle);

    a1_vel += a1_a;
    angle += a1_vel;

    position.set(lengh*sin(angle), lengh*cos(angle));
    position.add(origin);   
    a1_vel *= damping;
  }

void setSpeed(PVector force) {
    PVector f = force.copy();
    a1_a = mag(PVector.div(f, mass).x, PVector.div(f, mass).y);
    a1_vel += a1_a;
    position.add(a1_vel,a1_vel);
    //a1_a = 0;
}

  int showingData()
  {  
    fieldName[0]  = "radius";
    fieldValue[0] = radius;
    fieldName[1]  = "gravity";
    fieldValue[1] = gravity;
    fieldName[2]  = "damping";
    fieldValue[2] = damping;

    return 3;
  }

  void drawing()
  {

    //finding the smallest and largest limit values used to change the color of objects
    fun[0].findingTheItem(angle);
    fun[1].findingTheItem(a1_vel);
    fun[2].findingTheItem(a1_a);

    stroke(255);
    fill((map(angle, fun[0].smallestItem, fun[0].largestItem, 10, 255)), (map(a1_vel, fun[1].smallestItem, fun[1].largestItem, 10, 255)), (map(a1_a, fun[2].smallestItem, fun[2].largestItem, 10, 255)));
    line(origin.x, origin.y, position.x, position.y);
    circle( position.x, position.y, 2 * radius);
  }
}
