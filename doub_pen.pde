class DoublePendulum {

  float g = 3.924;
  Pendulum pen1, pen2;
  float cx = 0, cy = 0;
  float prevPosX2 = -1, prevPosY2 = -1;
  int i = 0, current = i, iko = 0;
  PVector[]  point = new PVector[500];
  PVector[]  position = new PVector[2];
  ArrayList<LotsOfFunctions> colorDetermination;
  PVector origin = new PVector(width / 2, height/3);  
  HashMap<String, Float> fieldVariables = new HashMap<String, Float>(17);
  
  DoublePendulum(float a1_, float a2_, float length1_, float length2_, float mas1_, float mas2_)
  {   
    pen1 = new Pendulum(a1_, length1_, mas1_, origin);
    pen2 = new Pendulum(a2_, length2_, mas2_, origin);
    
    pen1.radius = 30;
    pen2.radius = 20;

    pen1.position = new PVector(0, 0);
    pen2.position = new PVector(0, 0);

    colorDetermination  = new ArrayList<LotsOfFunctions>(2);

    update();
    inicjalization();
  }

  DoublePendulum(float a1_, float a2_, float a1_vel_, float a2_vel_, float a1_acc_, float a2_acc_, float length1_, float length2_, float mas1_, float mas2_, float radius1_, float radius2_, float g_, PVector position0, PVector position1)
  {
    pen1 = new Pendulum(origin, radius1_, g_, 0.998, a1_, a1_vel_, length1_);
    pen2 = new Pendulum(origin, radius2_, g_, 0.998, a2_, a2_vel_, length2_);
    
    pen1.radius = 30;
    pen2.radius = 20;
    pen1.mass = mas1_;
    pen2.mass = mas2_;
    pen1.acceleration = a1_acc_;
    pen2.acceleration = a2_acc_;  
    
    pen1.position = new PVector(position0.x, position0.y);
    pen2.position = new PVector(position1.x, position1.y);

    inicjalization();
  }

  void inicjalization()
  {

    for (int i = 0; i<point.length; i++)
    {
      point[i] = new PVector(pen2.position.x, pen2.position.y);
    }

    colorDetermination.add(new LotsOfFunctions(pen1.velocity, pen1.acceleration, pen1.angle));
    colorDetermination.add(new LotsOfFunctions(pen2.velocity, pen2.acceleration, pen2.angle));

    fieldVariables.put("gravity", g);
    fieldVariables.put("a1", pen1.angle);
    fieldVariables.put("a2", pen2.angle);
    fieldVariables.put("mas1", pen1.mass);
    fieldVariables.put("mas2", pen2.mass);       
    fieldVariables.put("length1", pen1.lengh);
    fieldVariables.put("length2", pen2.lengh);   
    fieldVariables.put("radius1", pen1.radius);
    fieldVariables.put("radius2", pen2.radius);  
    fieldVariables.put("a1_vel", pen1.velocity);
    fieldVariables.put("a2_vel", pen2.velocity);
    fieldVariables.put("a1_a", pen1.acceleration);
    fieldVariables.put("a2_a", pen2.acceleration);
    fieldVariables.put("position[0].x", pen1.position.x);
    fieldVariables.put("position[0].y", pen1.position.y);
    fieldVariables.put("position[1].x", pen2.position.x);
    fieldVariables.put("position[1].y", pen2.position.y);   
    
  }

  void set0()
  {
    pen1.velocity = 0;
    pen2.velocity = 0;
    pen1.acceleration = 0;
    pen2.acceleration = 0;
    
    pen1.angle = PI / (randa.nextInt(5) + 1);
    pen2.angle = PI / (randa.nextInt(5) + 1);
    
    pen1.position.set(origin.x, origin.y);
    pen2.position.set(pen1.position.x, pen1.position.y);

    while ( pen1.angle==PI||pen2.angle == PI)
    {
      pen1.angle+=0.01;
      pen2.angle+=randa.nextFloat();
    }
    update();

    for (int j = 0; j<point.length; j++)
    {
      point[j].x = pen2.position.x;
      point[j].y = pen2.position.y;
    }

    pen1.velocity = 0;
    pen2.velocity = 0;
    pen1.acceleration = 0;
    pen2.acceleration = 0;
  }


  void update()
  {
    float den = 0, den2 = 0;
    float[] counter = new float[8];

    //calculation of acceleration, velocity and position of double pendulum
    counter[0] = -(g) * (2 * pen1.mass + pen2.mass) * sin(pen1.angle);
    counter[1] = -mas2 * (g) * sin(pen1.angle - 2 * pen2.angle);
    counter[2] = -2 * sin(pen1.angle - pen2.angle) * pen2.mass;
    counter[3] = pen2.velocity * pen2.velocity * pen2.lengh + pen1.velocity * pen1.velocity * pen1.lengh * cos(pen1.angle - pen2.angle);
    den = length1 * (2 * pen1.mass + pen2.mass - pen2.mass * cos(2 * pen1.angle - 2 * pen2.angle));
    pen1.acceleration = (counter[0] +  counter[1] + counter[2] * counter[3]) / den;

    counter[4] = 2 * sin(pen1.angle - pen2.angle);
    counter[5] = (pen1.velocity * pen1.velocity * pen1.lengh * (pen1.mass + pen2.mass));
    counter[6] = (g) * (pen1.mass + pen2.mass) * cos(pen1.angle);
    counter[7] = pen2.velocity * pen2.velocity * length2 * pen2.mass * cos(pen1.angle - pen2.angle);
    den2 = pen2.lengh * (2 * pen1.mass + pen2.mass - pen2.mass * cos(2 * pen1.angle - 2 * pen2.angle));
    pen2.acceleration = (counter[4] * (counter[5] + counter[6] + counter[7])) / den2;

    pen1.position.x = pen1.lengh * sin(pen1.angle);
    pen1.position.y = pen1.lengh * cos(pen1.angle);
    pen1.position.add(origin); 
    pen2.position.x = pen1.position.x + pen2.lengh * sin(pen2.angle);
    pen2.position.y = pen1.position.y + pen2.lengh * cos(pen2.angle);

    pen1.velocity += pen1.acceleration * delta_time;
    pen2.velocity += pen2.acceleration * delta_time;
    pen1.angle += pen1.velocity;
    pen2.angle += pen2.velocity;

    pen1.velocity *= 0.999;
    pen2.velocity *= 0.999;
    prevPosX2 = pen2.position.x;
    prevPosY2 = pen2.position.y;
  }

  void setSpeed(PVector force, int number) {
    PVector f = force.copy();

    switch(number) {

    case 0:
      pen1.acceleration = mag(PVector.div(f, mas1).x, PVector.div(f, mas1).y);
      pen1.velocity += pen1.acceleration;
      pen1.position.add(pen1.velocity, pen1.velocity);

    case 1:
      pen2.acceleration = mag(PVector.div(f, mas2).x, PVector.div(f, mas2).y);
      pen2.velocity += pen2.acceleration;
      pen2.position.add(pen2.velocity, pen2.velocity);
    }
  }

  void trace(int k, int ile)
  {
    iko = k;
    update();
    point[i].x = pen2.position.x;
    point[i].y = pen2.position.y;

    i++;

    if (i==point.length)
    {
      i = 0;
    }

    stroke(100, 0, 100);
    strokeWeight(6);
    noFill();

    current = i;

    //drawing a trace
    beginShape();
    for (int j = 0; j<point.length; j++)
    {
      current++;

      if (current == point.length) 
      {
        current = 0;
      }

      stroke((map(j, 0, point.length, 50, 255)), (map(iko, 0, ile, 50, 255)), (map(current, 0, point.length, 50, 255)));

      curveVertex(point[current].x, point[current].y);
    }
    endShape();
  }

  void setingFieldVariables()
  {
    fieldVariables.replace("gravity", g);
    fieldVariables.replace("a1", pen1.angle);
    fieldVariables.replace("a2", pen2.angle);
    fieldVariables.replace("mas1", pen1.mass);
    fieldVariables.replace("mas2", pen2.mass);   
    fieldVariables.replace("length1", pen1.lengh);
    fieldVariables.replace("length2", pen2.lengh);   
    fieldVariables.replace("radius1", pen1.radius); 
    fieldVariables.replace("radius2", pen2.radius);
    fieldVariables.replace("a1_vel", pen1.velocity);
    fieldVariables.replace("a2_vel", pen2.velocity);
    fieldVariables.replace("a1_a", pen1.acceleration);
    fieldVariables.replace("a2_a", pen2.acceleration);
    fieldVariables.replace("position[0].x", pen1.position.x);
    fieldVariables.replace("position[0].y", pen1.position.y);
    fieldVariables.replace("position[1].x", pen2.position.x);
    fieldVariables.replace("position[1].y", pen2.position.y);
  }


  void drowing(int k, int ile)
  {
    //calculation of trace
    if (doubleAction)
    {
      trace(k, ile);
    }

    //finding the smallest and largest limit values used to change the color of objects
    colorDetermination.get(0).findingSmallestAndBiggestValue(pen1.velocity, pen1.acceleration, pen1.angle);
    colorDetermination.get(1).findingSmallestAndBiggestValue(pen2.velocity, pen2.acceleration, pen2.angle);

    //drawing double pendulum
    strokeWeight(2);
    stroke(255, 255, 0);
    //drawing line conecting center to first ball, and to second
    line(origin.x, origin.y, pen1.position.x, pen1.position.y);
    line(pen1.position.x, pen1.position.y, pen2.position.x, pen2.position.y);
    //drawing first ball
    stroke(255, 0, 0);
    fill(colorDetermination.get(0).valueMapping(0, pen1.velocity, 10, 255), colorDetermination.get(0).valueMapping(1, pen1.acceleration, 10, 255), colorDetermination.get(0).valueMapping(2, pen1.angle, 10, 255));
    circle(pen1.position.x, pen1.position.y, pen1.radius * 2);
    //drawing second ball
    stroke(0, 0, 255);
    fill(colorDetermination.get(1).valueMapping(0, pen2.velocity, 10, 255), colorDetermination.get(1).valueMapping(1, pen2.acceleration, 10, 255), colorDetermination.get(1).valueMapping(2, pen2.angle, 10, 255));
    circle(pen2.position.x, pen2.position.y, pen2.radius * 2);
    stroke(0, 0, 255);
    fill(255, 0, 0);
    circle(origin.x, origin.y, 10);
  }
}
