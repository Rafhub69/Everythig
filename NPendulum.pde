class NPendulum {

  int tier;
  ArrayList<Pendulum> singlePen;
  float damping = 0.998, g = 7.848; 
  PVector[] point = new PVector[300]; 
  int l = 0, current = l, iko = 0, index = 0;     
  ArrayList<LotsOfFunctions> colorDetermination;
  PVector origin = new PVector(width / 2, height/4); 
  HashMap<String, Float> fieldVariables = new HashMap<String, Float>();


  NPendulum(int _tier)
  {
    tier = _tier;   
    singlePen = new ArrayList<Pendulum>(tier);
    colorDetermination = new ArrayList<LotsOfFunctions>(tier);
    reset();

    for (int i = 0; i<point.length; i++)
    {
      point[i] = new PVector(singlePen.get(tier - 1).position.x, singlePen.get(tier - 1).position.y);
    }
  }

  NPendulum(int tier_, FloatList mas, FloatList angles, FloatList lenghts, FloatList radiuses, FloatList velocities, FloatList accelerations, FloatList positionX, FloatList positionY)
  {        
    tier = tier_; 
    singlePen = new ArrayList<Pendulum>(tier);
    colorDetermination = new ArrayList<LotsOfFunctions>(tier);

    for (int i = 0; i<tier; i++)
    {

      singlePen.add(new Pendulum(origin, radiuses.get(i), g, damping, angles.get(i), velocities.get(i), lenghts.get(i)));
      singlePen.get(i).mass = mas.get(i);
      singlePen.get(i).penAcc = accelerations.get(i);
      singlePen.get(i).position = new PVector(positionX.get(i), positionY.get(i));
      colorDetermination.add(new LotsOfFunctions(singlePen.get(i).penVel, singlePen.get(i).penAcc, singlePen.get(i).angle));

      fieldVariables.put("mas" + i, singlePen.get(i).mass);
      fieldVariables.put("angles" + i, singlePen.get(i).angle);
      fieldVariables.put("length" + i, singlePen.get(i).lengh);
      fieldVariables.put("radius" + i, singlePen.get(i).radius);
      fieldVariables.put("velocities" + i, singlePen.get(i).penVel);      
      fieldVariables.put("accelerations" + i, singlePen.get(i).penAcc);
      fieldVariables.put("position[" + i +"].x", singlePen.get(i).position.x);
      fieldVariables.put("position[" + i +"].y", singlePen.get(i).position.y);
    }

    for (int j = 0; j<point.length; j++)
    {
      point[j] = new PVector(singlePen.get(tier - 1).position.x, singlePen.get(tier - 1).position.y);
    }
  }

  void reset()
  {
    fieldVariables.put("gravity", g);
    fieldVariables.put("tier", float (tier));

    for (int i =0; i<tier; i++)
    {
      float mass = random(20, 50);

      singlePen.add(new Pendulum(origin, mass, g, damping, random(PI), 0, random(mass + 12, height/tier)));
      singlePen.get(i).mass = mass;
      singlePen.get(i).position = new PVector(singlePen.get(i).lengh * sin(singlePen.get(i).angle) + origin.x, singlePen.get(i).lengh * cos(singlePen.get(i).angle) + origin.y);
      colorDetermination.add(new LotsOfFunctions(singlePen.get(i).penVel, singlePen.get(i).penAcc, singlePen.get(i).angle));
    }

    setingFieldVariables();
    calculations();
  }

  void calculations()
  {
    float den = 0;
    float num1 = 0;
    float num2 = 0;
    float num3 = 0;

    for (int j = 0; j < tier; j++) {
      //denominator 
      for (int k = 0; k < tier; k++) {
        den += singlePen.get(k).mass * singlePen.get(k).lengh * singlePen.get(k).lengh * (j <= k? 1 : 0);
      }


      for (int k = 0; k < tier; k++) {
        //first numerator
        num1 = g * singlePen.get(j).lengh * sin(singlePen.get(j).angle) * singlePen.get(j).mass * (j <= k? 1 : 0);

        //second numerator
        float inner_sum = 0;
        // inner sum
        for (int q = k+1; q < tier; q++) {
          inner_sum += singlePen.get(q).mass * (j <= q? 1 : 0);
        }
        num2 = inner_sum * singlePen.get(j).lengh * singlePen.get(k).lengh * sin(singlePen.get(j).angle - singlePen.get(k).angle) * singlePen.get(j).penVel * singlePen.get(k).penVel;

        //Third numerator
        //The inner sum is the same as in the num2
        num3 = inner_sum * singlePen.get(j).lengh * singlePen.get(k).lengh * (sin(singlePen.get(k).angle - singlePen.get(j).angle) * (singlePen.get(j).penVel * singlePen.get(k).penVel) * singlePen.get(k).penVel 
          + (j != k ? 1 : 0) * cos(singlePen.get(j).angle - singlePen.get(k).angle) * singlePen.get(k).penAcc);
      }
      float result = - (num1 + num2 + num3) / den;

      singlePen.get(j).penAcc = result;
    }

    accToAngle();
  }

  void accToAngle()
  {
    singlePen.get(0).penVel += singlePen.get(0).penAcc * delta_time;
    singlePen.get(0).angle += singlePen.get(0).penVel;
    singlePen.get(0).position.set(singlePen.get(0).lengh * sin(singlePen.get(0).angle) + origin.x, singlePen.get(0).lengh * cos(singlePen.get(0).angle) + origin.y);
    singlePen.get(0).penVel *= damping;

    for (int i = 1; i < tier; i++)
    {
      singlePen.get(i).penVel += singlePen.get(i).penAcc * delta_time;
      singlePen.get(i).angle += singlePen.get(i).penVel;
      singlePen.get(i).position.set(singlePen.get(i).lengh * sin(singlePen.get(i).angle) + singlePen.get(i - 1).position.x, singlePen.get(i).lengh * cos(singlePen.get(i).angle) + singlePen.get(i - 1).position.y);
      singlePen.get(i).penVel *= damping;
    }
  }

  void trace(int k, int ile)
  {
    iko = k;
    calculations();
    point[l].y = singlePen.get(tier - 1).position.y;
    point[l].x =  singlePen.get(tier - 1).position.x;

    l++;

    if (l == point.length)
    {
      l = 0;
    }

    stroke(100, 0, 100);
    strokeWeight(6);
    noFill();

    current = l;

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
    fieldVariables.put("gravity", g);
    fieldVariables.put("tier", float (tier));

    for (int i = 0; i < tier; i++)
    {
      fieldVariables.replace("mas" + i, singlePen.get(i).mass);
      fieldVariables.replace("angles" + i, singlePen.get(i).angle);
      fieldVariables.replace("length" + i, singlePen.get(i).lengh);
      fieldVariables.replace("radius" + i, singlePen.get(i).radius);
      fieldVariables.replace("velocities" + i, singlePen.get(i).penVel);      
      fieldVariables.replace("accelerations" + i, singlePen.get(i).penAcc);
      fieldVariables.replace("position[" + i +"].x", singlePen.get(i).position.x);
      fieldVariables.replace("position[" + i +"].y", singlePen.get(i).position.y);
    }
  }

  void drawing()
  {
    colorDetermination.get(0).findingSmallestAndBiggestValue(singlePen.get(0).penVel, singlePen.get(0).penAcc, singlePen.get(0).angle);

    strokeWeight(2);
    stroke(255, 0, 0);
    circle(origin.x, origin.y, 20);
    stroke(255, 255, 0);
    fill(colorDetermination.get(0).valueMapping(0, singlePen.get(0).penVel, 10, 255), colorDetermination.get(0).valueMapping(1, singlePen.get(0).penAcc, 10, 255), colorDetermination.get(0).valueMapping(2, singlePen.get(0).angle, 10, 255));
    line(origin.x, origin.y, singlePen.get(0).position.x, singlePen.get(0).position.y);
    circle( singlePen.get(0).position.x, singlePen.get(0).position.y, singlePen.get(0).radius);

    for (int i = 1; i<tier; i++)
    {
      colorDetermination.get(i).findingSmallestAndBiggestValue(singlePen.get(i).penVel, singlePen.get(i).penAcc, singlePen.get(i).angle);
      fill(colorDetermination.get(i).valueMapping(0, singlePen.get(i).penVel, 10, 255), colorDetermination.get(i).valueMapping(1, singlePen.get(i).penAcc, 10, 255), colorDetermination.get(i).valueMapping(2, singlePen.get(i).angle, 10, 255));
      stroke(255, 255, 0);
      line(singlePen.get(i - 1).position.x, singlePen.get(i - 1).position.y, singlePen.get(i).position.x, singlePen.get(i).position.y);
      stroke(255, 0, 0);
      circle(singlePen.get(i).position.x, singlePen.get(i).position.y, singlePen.get(i).radius);
    }
  }
}
