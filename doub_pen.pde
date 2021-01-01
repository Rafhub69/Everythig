class DoublePendulum {

  PVector[]  point = new PVector[500];
  PVector[]  position = new PVector[2];
  PVector origin = new PVector(width / 2, height/3); 
  float g = 3.924;
  float length1, length2; // lenght of pendulums
  float mas1, mas2; //mass of pendulum
  float a1_vel = 0, a2_vel = 0; // angular velocity
  float a1_acc = 0, a2_acc = 0; //angular acceleration 
  float a1, a2; //angle
  float radius1 = 30, radius2 = 20; //radius
  float cx = 0, cy = 0;
  float px2 = -1, py2 = -1;
  int i = 0, current = i, iko = 0;
  HashMap<String, Float> fieldVariables = new HashMap<String, Float>(17);
  ArrayList<LotsOfFunctions> colorDetermination;
  ControlP5 cp5;

  DoublePendulum(float a1_, float a2_, float length1_, float length2_, float mas1_, float mas2_)
  {
    a1 = a1_;
    a2 = a2_;
    length1 = length1_;
    length2 = length2_;
    mas1 = mas1_;
    mas2 = mas2_;

    position[0] = new PVector(0, 0);
    position[1] = new PVector(0, 0);
    colorDetermination  = new ArrayList<LotsOfFunctions>(2);

    for (int i = 0; i<point.length; i++)
    {
      point[i] = new PVector(position[1].x, position[1].y);
    }

    update();
    inicjalization();
  }

  DoublePendulum(float a1_, float a2_, float a1_vel_, float a2_vel_, float a1_acc_, float a2_acc_, float length1_, float length2_, float mas1_, float mas2_, float radius1_, float radius2_, float g_, PVector position0, PVector position1)
  {
    a1 = a1_;
    a2 = a2_;
    length1 = length1_;
    length2 = length2_;
    mas1 = mas1_;
    mas2 = mas2_;
    radius1 = radius1_;
    radius2 = radius2_; 
    a1_vel = a1_vel_;
    a2_vel = a2_vel_; 
    a1_acc = a1_acc_;
    a2_acc = a2_acc_;
    g = g_;

    position[0] = new PVector(position0.x, position0.y);
    position[1] = new PVector(position1.x, position1.y);

    for (int i = 0; i<point.length; i++)
    {
      point[i] = new PVector(position[1].x, position[1].y);
    }

    inicjalization();
  }

  void inicjalization()
  {
    colorDetermination.add(new LotsOfFunctions(a1_vel, a1_acc, a1));
    colorDetermination.add(new LotsOfFunctions(a2_vel, a2_acc, a2));

    fieldVariables.put("radius1", radius1);
    fieldVariables.put("mas1", mas1);
    fieldVariables.put("gravity", g);
    fieldVariables.put("length1", length1);
    fieldVariables.put("position[0].x", position[0].x);
    fieldVariables.put("position[0].y", position[0].y);
    fieldVariables.put("a1_vel", a1_vel);
    fieldVariables.put("a1", a1);
    fieldVariables.put("a1_a", a1_acc);
    fieldVariables.put("radius2", radius2);
    fieldVariables.put("mas2", mas2);
    fieldVariables.put("length2", length2);
    fieldVariables.put("position[1].x", position[1].x);
    fieldVariables.put("position[1].y", position[1].y);
    fieldVariables.put("a2_vel", a2_vel);
    fieldVariables.put("a2", a2);
    fieldVariables.put("a2_a", a2_acc);
  }

  void set0()
  {
    position[0].set(origin.x, origin.y);
    position[1].set(position[0].x, position[0].y);

    a1_vel = 0;
    a2_vel = 0;
    a1_acc = 0;
    a2_acc = 0;
    a1 = PI / (randa.nextInt(5) + 1);
    a2 = PI / (randa.nextInt(5) + 1);

    while ( a1==PI||a2 == PI)
    {
      a1+=0.01;
      a2+=randa.nextFloat();
    }
    update();

    for (int j = 0; j<point.length; j++)
    {
      point[j].x = position[1].x;
      point[j].y = position[1].y;
    }

    a1_vel = 0;
    a2_vel = 0;
    a1_acc = 0;
    a2_acc = 0;
  }


  void update()
  {
    float den = 0, den2 = 0;
    float[] counter = new float[8];

    //calculation of acceleration, velocity and position of double pendulum
    counter[0] = -(g) * (2 * mas1 + mas2) * sin(a1);
    counter[1] = -mas2 * (g)*sin(a1 - 2 * a2);
    counter[2] = -2 * sin(a1 - a2) * mas2;
    counter[3] = a2_vel * a2_vel * length2 + a1_vel * a1_vel * length1 * cos(a1 - a2);
    den = length1 * (2 * mas1 + mas2 - mas2 * cos(2 * a1 - 2 * a2));
    a1_acc = (counter[0] +  counter[1] + counter[2] * counter[3]) / den;

    counter[4] = 2 * sin(a1 - a2);
    counter[5] = (a1_vel * a1_vel * length1 * (mas1 + mas2));
    counter[6] = (g) * (mas1 + mas2) * cos(a1);
    counter[7] = a2_vel * a2_vel * length2 * mas2 * cos(a1 - a2);
    den2 = length2 * (2 * mas1 + mas2 - mas2 * cos(2 * a1 - 2 * a2));
    a2_acc = (counter[4] * (counter[5] + counter[6] + counter[7])) / den2;

    position[0].x = length1 * sin(a1);
    position[0].y = length1 * cos(a1);
    position[0].add(origin); 
    position[1].x = position[0].x + length2 * sin(a2);
    position[1].y = position[0].y + length2 * cos(a2);

    a1_vel += a1_acc * delta_time;
    a2_vel += a2_acc * delta_time;
    a1 += a1_vel;
    a2 += a2_vel;

    a1_vel *= 0.999;
    a2_vel *= 0.999;
    px2 = position[1].x;
    py2 = position[1].y;
  }

  void setSpeed(PVector force, int number) {
    PVector f = force.copy();

    switch(number) {

    case 0:
      a1_acc = mag(PVector.div(f, mas1).x, PVector.div(f, mas1).y);
      a1_vel += a1_acc;
      position[0].add(a1_vel, a1_vel);

    case 1:
      a2_acc = mag(PVector.div(f, mas2).x, PVector.div(f, mas2).y);
      a2_vel += a2_acc;
      position[1].add(a2_vel, a2_vel);
    }
  }

  void trace(int k, int ile)
  {
    iko = k;
    update();
    point[i].x = position[1].x;
    point[i].y = position[1].y;

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

  int setingFieldVariables()
  {
    fieldVariables.replace("radius1", radius1);
    fieldVariables.replace("mas1", mas1);
    fieldVariables.replace("gravity", g);
    fieldVariables.replace("length1", length1);
    fieldVariables.replace("position[0].x", position[0].x);
    fieldVariables.replace("position[0].y", position[0].y);
    fieldVariables.replace("a1_vel", a1_vel);
    fieldVariables.replace("a1", a1);
    fieldVariables.replace("a1_a", a1_acc);
    fieldVariables.replace("radius2", radius2);
    fieldVariables.replace("mas2", mas2);
    fieldVariables.replace("length2", length2);
    fieldVariables.replace("position[1].x", position[1].x);
    fieldVariables.replace("position[1].y", position[1].y);
    fieldVariables.replace("a2_vel", a2_vel);
    fieldVariables.replace("a2", a2);
    fieldVariables.replace("a2_a", a2_acc);

    return 3;
  }


  void drowing(int k, int ile)
  {
    //calculation of trace
    if (doubleAction)
    {
      trace(k, ile);
    }

    //finding the smallest and largest limit values used to change the color of objects
    colorDetermination.get(0).findingSmallestAndBiggestValue(a1_vel, a1_acc, a1);
    colorDetermination.get(1).findingSmallestAndBiggestValue(a2_vel, a2_acc, a2);

    //drawing double pendulum
    strokeWeight(2);
    stroke(255, 255, 0);
    //drawing line conecting center to first ball, and to second
    line(origin.x, origin.y, position[0].x, position[0].y);
    line(position[0].x, position[0].y, position[1].x, position[1].y);
    //drawing first ball
    stroke(255, 0, 0);
    fill(colorDetermination.get(0).valueMapping(0, a1_vel, 10, 255), colorDetermination.get(0).valueMapping(1, a1_acc, 10, 255), colorDetermination.get(0).valueMapping(2, a1, 10, 255));
    circle(position[0].x, position[0].y, radius1 * 2);
    //drawing second ball
    stroke(0, 0, 255);
    fill(colorDetermination.get(1).valueMapping(0, a2_vel, 10, 255), colorDetermination.get(1).valueMapping(1, a2_acc, 10, 255), colorDetermination.get(1).valueMapping(2, a2, 10, 255));
    circle(position[1].x, position[1].y, radius2 * 2);
    stroke(0, 0, 255);
    fill(255, 0, 0);
    circle(origin.x, origin.y, 10);
  }
}
