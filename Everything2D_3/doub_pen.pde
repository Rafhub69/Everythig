class double_pendulum {

  PVector[]  point = new PVector[500];
  PVector[]  position = new PVector[2];
  PVector origin = new PVector(width / 2, height/3); 
  float g = 0.4905, delta_t = 1;
  float length1, length2; // lenght of pendulums
  float mas1, mas2; //mass of pendulum
  float a1_vel = 0, a2_vel = 0; // angular velocity
  float a1_a = 0, a2_a = 0; //angular acceleration 
  float a1, a2; //angle
  float radius1 = 30, radius2 = 20; //radius
  float counter1 = 0, counter2 = 0, counter3 = 0, counter4 = 0, den = 0;
  float counter5 = 0, counter6 = 0, counter7 = 0, counter8 = 0, den2 = 0;
  float cx = 0, cy = 0;
  float px2 = -1, py2 = -1;
  int i = 0, current = i, iko = 0;
  String[] fieldName = new String[3];
  float[] fieldValue = new float[3];
  Function[] fun = new Function[6];
  ControlP5 cp5;

  double_pendulum(float a1_, float a2_, float length1_, float length2_, float mas1_, float mas2_)
  {
    a1 = a1_;
    a2 = a2_;
    length1 = length1_;
    length2 = length2_;
    mas1 = mas1_;
    mas2 = mas2_;

    position[0] = new PVector(0, 0);
    position[1] = new PVector(0, 0);

    for (int i = 0; i<point.length; i++)
    {
      point[i] = new PVector(position[1].x, position[1].y);
    }

    fun[0] = new Function(a1_vel, a1_vel);
    fun[1] = new Function(a1_a, a1_a);
    fun[2] = new Function(a1, a1);
    fun[3] = new Function(a2_vel, a2_vel);
    fun[4] = new Function(a2_a, a2_a);
    fun[5] = new Function(a2, a2);
  }


  void set0()
  {
    position[0].set(origin.x, origin.y);
    position[1].set(position[0].x, position[0].y);

    a1_vel = 0;
    a2_vel = 0;
    a1_a = 0;
    a2_a = 0;
    a1 = PI / (randa.nextInt(5) + 1);
    a2 = PI / (randa.nextInt(5) + 1);

    if ( a1==PI||a2 == PI)
    {
      a1+=0.01;
      a2+=randa.nextFloat();
    }
    double_pen();

    for (int j = 0; j<point.length; j++)
    {
      point[j].x = position[1].x;
      point[j].y = position[1].y;
    }

    a1_vel = 0;
    a2_vel = 0;
    a1_a = 0;
    a2_a = 0;
  }


  void double_pen()
  {
    //calculation of acceleration, velocity and position of double pendulum
    counter1 = -(g) * (2 * mas1 + mas2) * sin(a1);
    counter2 = -mas2 * (g)*sin(a1 - 2 * a2);
    counter3 = -2 * sin(a1 - a2) * mas2;
    counter4 = a2_vel * a2_vel * length2 + a1_vel * a1_vel * length1 * cos(a1 - a2);
    den = length1 * (2 * mas1 + mas2 - mas2 * cos(2 * a1 - 2 * a2));
    a1_a = (counter1 + counter2 + counter3 * counter4) / den;

    counter5 = 2 * sin(a1 - a2);
    counter6 = (a1_vel * a1_vel * length1 * (mas1 + mas2));
    counter7 = (g) * (mas1 + mas2) * cos(a1);
    counter8 = a2_vel * a2_vel * length2 * mas2 * cos(a1 - a2);
    den2 = length2 * (2 * mas1 + mas2 - mas2 * cos(2 * a1 - 2 * a2));
    a2_a = (counter5 * (counter6 + counter7 + counter8)) / den2;

    position[0].x = length1 * sin(a1);
    position[0].y = length1 * cos(a1);
    position[0].add(origin); 
    position[1].x = position[0].x + length2 * sin(a2);
    position[1].y = position[0].y + length2 * cos(a2);

    a1_vel += a1_a;
    a2_vel += a2_a;
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
      a1_a = mag(PVector.div(f, mass).x, PVector.div(f, mass).y);
      a1_vel += a1_a;
      position[0].add(a1_vel, a1_vel);

    case 1:
      a2_a = mag(PVector.div(f, mass).x, PVector.div(f, mass).y);
      a2_vel += a2_a;
      position[1].add(a2_vel, a2_vel);
    }
  }

  void trace(int k, int ile)
  {
    iko = k;
    double_pen();
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

  int showingData(int whichPart)
  {
    if (whichPart == 3)
    {
      fieldName[0]  = "radius";
      fieldValue[0] = radius1;
      fieldName[1]  = "mass";
      fieldValue[1] = mas1;
      fieldName[2]  = "gravity";
      fieldValue[2] = g;
    } else if (whichPart == 4)
    {
      fieldName[0]  = "radius";
      fieldValue[0] = radius2;
      fieldName[1]  = "mass";
      fieldValue[1] = mas2;
      fieldName[2]  = "gravity";
      fieldValue[2] = g;
    }

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
    fun[0].findingTheItem(a1_vel);
    fun[1].findingTheItem(a1_a);
    fun[2].findingTheItem(a1);
    fun[3].findingTheItem(a2_vel);
    fun[4].findingTheItem(a2_a);
    fun[5].findingTheItem(a2);

    //drawing double pendulum
    strokeWeight(2);
    stroke(255, 255, 0);
    //drawing line conecting center to first ball, and to second
    line(origin.x, origin.y, position[0].x, position[0].y);
    line(position[0].x, position[0].y, position[1].x, position[1].y);
    //drawing first ball
    stroke(255, 0, 0);
    fill((map( a1_vel, fun[0].smallestItem, fun[0].largestItem, 10, 255)), (map( a1_a, fun[1].smallestItem, fun[1].largestItem, 10, 255)), (map(a1, fun[2].smallestItem, fun[2].largestItem, 10, 255)));
    circle(position[0].x, position[0].y, radius1 * 2);
    //drawing second ball
    stroke(0, 0, 255);
    fill( (map(a2_vel, fun[3].smallestItem, fun[3].largestItem, 10, 255)), (map( a2_a, fun[4].smallestItem, fun[4].largestItem, 10, 255)), (map(a2, fun[5].smallestItem, fun[5].largestItem, 10, 255)));
    circle(position[1].x, position[1].y, radius2 * 2);
    stroke(0, 0, 255);
    fill(255, 0, 0);
    circle(origin.x, origin.y, 10);
  }
}
