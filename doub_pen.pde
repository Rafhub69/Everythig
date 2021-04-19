class DoublePendulum {

  float gravity = 3.924;
  Pendulum pendul0, pendul1;
  int traceIterator = 0, currentPoint = traceIterator;
  PVector[]  point = new PVector[500];
  PVector[]  position = new PVector[2];
  ArrayList<LotsOfFunctions> colorDetermination;
  PVector origin = new PVector(width / 2, height/3);  
  HashMap<String, Float> fieldVariables = new HashMap<String, Float>(17);

  DoublePendulum(float a1_, float a2_, float length1_, float length2_, float mas1_, float mas2_)
  {   
    pendul0 = new Pendulum(a1_, length1_, mas1_, origin);
    pendul1 = new Pendulum(a2_, length2_, mas2_, origin);

    pendul0.radius = 30;
    pendul1.radius = 20;

    colorDetermination  = new ArrayList<LotsOfFunctions>(2);

    update();
    inicjalization();
  }

  DoublePendulum(float a1_, float a2_, float a1_vel_, float a2_vel_, float a1_acc_, float a2_acc_, float length1_, float length2_, float mas1_, float mas2_, float radius1_, float radius2_, float g_, PVector position0, PVector position1)
  {
    pendul0 = new Pendulum(origin, radius1_, g_, 0.998, a1_, a1_vel_, a1_acc_, length1_, mas1_);
    pendul1 = new Pendulum(origin, radius2_, g_, 0.998, a2_, a2_vel_, a2_acc_, length2_, mas2_);

    pendul0.position = new PVector(position0.x, position0.y);
    pendul1.position = new PVector(position1.x, position1.y);

    inicjalization();
  }

  void inicjalization()
  {

    for (int i = 0; i < point.length; i++)
    {
      point[i] = new PVector(pendul1.position.x, pendul1.position.y);
    }

    colorDetermination.add(new LotsOfFunctions(pendul0.velocity, pendul0.acceleration, pendul0.angle));
    colorDetermination.add(new LotsOfFunctions(pendul1.velocity, pendul1.acceleration, pendul1.angle));

    fieldVariables.put("gravity", gravity);
    fieldVariables.put("a0", pendul0.angle);
    fieldVariables.put("a1", pendul1.angle);
    fieldVariables.put("mas0", pendul0.mass);
    fieldVariables.put("mas1", pendul1.mass);
    fieldVariables.put("length0", pendul0.lengh);
    fieldVariables.put("length1", pendul1.lengh);   
    fieldVariables.put("radius0", pendul0.radius); 
    fieldVariables.put("radius1", pendul1.radius);
    fieldVariables.put("a0_vel", pendul0.velocity);
    fieldVariables.put("a1_vel", pendul1.velocity);
    fieldVariables.put("a0_a", pendul0.acceleration);
    fieldVariables.put("a1_a", pendul1.acceleration);
    fieldVariables.put("position[0].x", pendul0.position.x);
    fieldVariables.put("position[0].y", pendul0.position.y);
    fieldVariables.put("position[1].x", pendul1.position.x);
    fieldVariables.put("position[1].y", pendul1.position.y);
  }

  void set0()
  {
    pendul0.velocity = 0;
    pendul1.velocity = 0;
    pendul0.acceleration = 0;
    pendul1.acceleration = 0;

    pendul0.angle = PI / (randa.nextInt(5) + 1);
    pendul1.angle = PI / (randa.nextInt(8) + 1);

    while (pendul0.angle == PI || pendul1.angle == PI)
    {
      pendul0.angle += 0.01;
      pendul1.angle += randa.nextFloat();
    }
    update();

    for (int j = 0; j < point.length; j++)
    {
      point[j].set(pendul1.position);
    }

    pendul0.velocity = 0;
    pendul1.velocity = 0;
    pendul0.acceleration = 0;
    pendul1.acceleration = 0;
  }


  void update()
  {
    float[] counter = new float[8];
    float den = 0, den2 = 0, damping = 0.998;    

    //calculation of acceleration, velocity and position of double pendulum
    counter[0] = -(gravity) * (2 * pendul0.mass + pendul1.mass) * sin(pendul0.angle);
    counter[1] = -pendul1.mass * (gravity) * sin(pendul0.angle - 2 * pendul1.angle);
    counter[2] = -2 * sin(pendul0.angle - pendul1.angle) * pendul1.mass;
    counter[3] = pendul1.velocity * pendul1.velocity * pendul1.lengh + pendul0.velocity * pendul0.velocity * pendul0.lengh * cos(pendul0.angle - pendul1.angle);
    den = pendul0.lengh * (2 * pendul0.mass + pendul1.mass - pendul1.mass * cos(2 * pendul0.angle - 2 * pendul1.angle));
    pendul0.acceleration = (counter[0] +  counter[1] + counter[2] * counter[3]) / den;

    counter[4] = 2 * sin(pendul0.angle - pendul1.angle);
    counter[5] = (pendul0.velocity * pendul0.velocity * pendul0.lengh * (pendul0.mass + pendul1.mass));
    counter[6] = (gravity) * (pendul0.mass + pendul1.mass) * cos(pendul0.angle);
    counter[7] = pendul1.velocity * pendul1.velocity * pendul1.lengh * pendul1.mass * cos(pendul0.angle - pendul1.angle);
    den2 = pendul1.lengh * (2 * pendul0.mass + pendul1.mass - pendul1.mass * cos(2 * pendul0.angle - 2 * pendul1.angle));
    pendul1.acceleration = (counter[4] * (counter[5] + counter[6] + counter[7])) / den2;  

    pendul0.velocity += pendul0.acceleration * delta_time;
    pendul1.velocity += pendul1.acceleration * delta_time;
    pendul0.angle += pendul0.velocity;
    pendul1.angle += pendul1.velocity;

    pendul0.position.x = pendul0.lengh * sin(pendul0.angle);
    pendul0.position.y = pendul0.lengh * cos(pendul0.angle);
    pendul0.position.add(origin); 
    pendul1.position.x = pendul0.position.x + pendul1.lengh * sin(pendul1.angle);
    pendul1.position.y = pendul0.position.y + pendul1.lengh * cos(pendul1.angle);

    pendul0.velocity *= damping;
    pendul1.velocity *= damping;
  }

  void setSpeed(PVector force, int number) 
  {
    PVector f = force.copy();

    switch(number) {

    case 0:
      pendul0.acceleration = mag(PVector.div(f, pendul0.mass).x, PVector.div(f, pendul0.mass).y);
      pendul0.velocity += pendul0.acceleration;
      pendul0.position.add(pendul0.velocity, pendul0.velocity);
      break;
    case 1:
      pendul1.acceleration = mag(PVector.div(f, pendul1.mass).x, PVector.div(f, pendul1.mass).y);
      pendul1.velocity += pendul1.acceleration;
      pendul1.position.add(pendul1.velocity, pendul1.velocity);
    }
  }

  void trace(int pendulIndex, int ile)
  {
    update();
    point[traceIterator].set(pendul1.position);

    traceIterator++;

    if (traceIterator == point.length)
    {
      traceIterator = 0;
    }     

    currentPoint = traceIterator;

    //drawing a trace
    beginShape();
    for (int j = 0; j < point.length; j++)
    {

      currentPoint++;

      if (currentPoint > point.length - 1) 
      {
        currentPoint = 0;
      }

      stroke((map(j, 0, point.length - 1, 8, 255)), (map(pendulIndex, 0, ile, 20, 250)), (map(currentPoint, 0, point.length, 12, 252)));
      curveVertex(point[currentPoint].x, point[currentPoint].y);
    }
    endShape();
  }

  void setingFieldVariables()
  {    
    fieldVariables.replace("a0", pendul0.angle);
    fieldVariables.replace("a1", pendul1.angle);
    fieldVariables.replace("mas0", pendul0.mass);
    fieldVariables.replace("mas1", pendul1.mass);
    fieldVariables.replace("gravity", gravity);
    fieldVariables.replace("length0", pendul0.lengh);
    fieldVariables.replace("length1", pendul1.lengh);   
    fieldVariables.replace("radius0", pendul0.radius); 
    fieldVariables.replace("radius1", pendul1.radius);
    fieldVariables.replace("a0_vel", pendul0.velocity);
    fieldVariables.replace("a1_vel", pendul1.velocity);
    fieldVariables.replace("a0_a", pendul0.acceleration);
    fieldVariables.replace("a1_a", pendul1.acceleration);
    fieldVariables.replace("position[0].x", pendul0.position.x);
    fieldVariables.replace("position[0].y", pendul0.position.y);
    fieldVariables.replace("position[1].x", pendul1.position.x);
    fieldVariables.replace("position[1].y", pendul1.position.y);
  }


  void drawing()
  {

    //finding the smallest and largest limit values used to change the color of objects
    colorDetermination.get(0).findingSmallestAndBiggestValue(pendul0.velocity, pendul0.acceleration, pendul0.angle);
    colorDetermination.get(1).findingSmallestAndBiggestValue(pendul1.velocity, pendul1.acceleration, pendul1.angle);

    //drawing double pendulum
    strokeWeight(2);
    stroke(255, 255, 0);
    //drawing line conecting center to first ball, and to second
    line(origin.x, origin.y, pendul0.position.x, pendul0.position.y);
    line(pendul0.position.x, pendul0.position.y, pendul1.position.x, pendul1.position.y);
    //drawing first ball
    stroke(255, 0, 0);
    fill(colorDetermination.get(0).valueMapping(0, pendul0.velocity, 10, 255), colorDetermination.get(0).valueMapping(1, pendul0.acceleration, 10, 255), colorDetermination.get(0).valueMapping(2, pendul0.angle, 10, 255));
    circle(pendul0.position.x, pendul0.position.y, pendul0.radius * 2);
    //drawing second ball
    stroke(0, 0, 255);
    fill(colorDetermination.get(1).valueMapping(0, pendul1.velocity, 10, 255), colorDetermination.get(1).valueMapping(1, pendul1.acceleration, 10, 255), colorDetermination.get(1).valueMapping(2, pendul1.angle, 10, 255));
    circle(pendul1.position.x, pendul1.position.y, pendul1.radius * 2);
    stroke(0, 0, 255);
    fill(255, 0, 0);
    circle(origin.x, origin.y, 10);
  }
}
