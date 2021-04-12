class NPendulum {

  int tier;
  ArrayList<Pendulum> singlePendulum;
  float damping = 0.998, gravity = 7.848; 
  PVector[] point = new PVector[300]; 
  int traceIndex = 0, current = traceIndex, iko = 0, index = 0;     
  ArrayList<LotsOfFunctions> colorDetermination;
  PVector origin = new PVector(width / 2, height/4); 
  HashMap<String, Float> fieldVariables = new HashMap<String, Float>();


  NPendulum(int _tier)
  {
    tier = _tier;   
    singlePendulum = new ArrayList<Pendulum>(tier);
    colorDetermination = new ArrayList<LotsOfFunctions>(tier);
    reset();

    for (int i = 0; i < point.length; i++)
    {
      point[i] = new PVector(singlePendulum.get(tier - 1).position.x, singlePendulum.get(tier - 1).position.y);
    }
  }

  NPendulum(int tier_, FloatList mas, FloatList angles, FloatList lenghts, FloatList radiuses, FloatList velocities, FloatList accelerations, FloatList positionX, FloatList positionY)
  {        
    tier = tier_; 
    singlePendulum = new ArrayList<Pendulum>(tier);
    colorDetermination = new ArrayList<LotsOfFunctions>(tier);

    for (int i = 0; i < tier; i++)
    {
      singlePendulum.add(new Pendulum(origin, radiuses.get(i), gravity, damping, angles.get(i), velocities.get(i), lenghts.get(i)));
      singlePendulum.get(i).mass = mas.get(i);
      singlePendulum.get(i).acceleration = accelerations.get(i);
      singlePendulum.get(i).position = new PVector(positionX.get(i), positionY.get(i));
      colorDetermination.add(new LotsOfFunctions(singlePendulum.get(i).velocity, singlePendulum.get(i).acceleration, singlePendulum.get(i).angle));

      fieldVariables.put("mas" + i, singlePendulum.get(i).mass);
      fieldVariables.put("angles" + i, singlePendulum.get(i).angle);
      fieldVariables.put("length" + i, singlePendulum.get(i).lengh);
      fieldVariables.put("radius" + i, singlePendulum.get(i).radius);
      fieldVariables.put("velocities" + i, singlePendulum.get(i).velocity);      
      fieldVariables.put("accelerations" + i, singlePendulum.get(i).acceleration);
      fieldVariables.put("position["+ i +"].x", singlePendulum.get(i).position.x);
      fieldVariables.put("position["+ i +"].y", singlePendulum.get(i).position.y);
    }

    for (int j = 0; j<point.length; j++)
    {
      point[j] = new PVector(singlePendulum.get(tier - 1).position.x, singlePendulum.get(tier - 1).position.y);
    }
  }

  void reset()
  {
    fieldVariables.put("gravity", gravity);
    fieldVariables.put("tier", float (tier));

    for (int i =0; i < tier; i++)
    {
      float mass = random(20, 50);

      singlePendulum.add(new Pendulum(origin, mass, gravity, damping, random(PI), 0, random(mass + 12, height/tier)));
      singlePendulum.get(i).mass = mass;
      singlePendulum.get(i).position = new PVector(singlePendulum.get(i).lengh * sin(singlePendulum.get(i).angle) + origin.x, singlePendulum.get(i).lengh * cos(singlePendulum.get(i).angle) + origin.y);
      colorDetermination.add(new LotsOfFunctions(singlePendulum.get(i).velocity, singlePendulum.get(i).acceleration, singlePendulum.get(i).angle));
    }

    setingFieldVariables();
    calculations();
  }

  void calculations()
  {
    float numerator1 = 0, numerator2 = 0;
    float numerator3 = 0, denominator = 0;

    for (int j = 0; j < tier; j++) {
      //denominator 
      for (int k = 0; k < tier; k++) {
        denominator += singlePendulum.get(k).mass * singlePendulum.get(k).lengh * singlePendulum.get(k).lengh * (j <= k? 1 : 0);
      }


      for (int k = 0; k < tier; k++) {
        //first numerator
        numerator1 = gravity * singlePendulum.get(j).lengh * sin(singlePendulum.get(j).angle) * singlePendulum.get(j).mass * (j <= k? 1 : 0);

        //second numerator
        float inner_sum = 0;
        // inner sum
        for (int q = k+1; q < tier; q++) {
          inner_sum += singlePendulum.get(q).mass * (j <= q? 1 : 0);
        }
        numerator2 = inner_sum * singlePendulum.get(j).lengh * singlePendulum.get(k).lengh * sin(singlePendulum.get(j).angle - singlePendulum.get(k).angle) * singlePendulum.get(j).velocity * singlePendulum.get(k).velocity;

        //Third numerator
        //The inner sum is the same as in the num2
        numerator3 = inner_sum * singlePendulum.get(j).lengh * singlePendulum.get(k).lengh * (sin(singlePendulum.get(k).angle - singlePendulum.get(j).angle) * (singlePendulum.get(j).velocity * singlePendulum.get(k).velocity) * singlePendulum.get(k).velocity 
          + (j != k ? 1 : 0) * cos(singlePendulum.get(j).angle - singlePendulum.get(k).angle) * singlePendulum.get(k).acceleration);
      }
      float result = - (numerator1 + numerator2 + numerator3) / denominator;

      singlePendulum.get(j).acceleration = result;
    }

    accToAngle();
  }

  void accToAngle()
  {
    singlePendulum.get(0).velocity += singlePendulum.get(0).acceleration * delta_time;
    singlePendulum.get(0).angle += singlePendulum.get(0).velocity;
    singlePendulum.get(0).position.set(singlePendulum.get(0).lengh * sin(singlePendulum.get(0).angle) + origin.x, singlePendulum.get(0).lengh * cos(singlePendulum.get(0).angle) + origin.y);
    singlePendulum.get(0).velocity *= damping;

    for (int i = 1; i < tier; i++)
    {
      singlePendulum.get(i).velocity += singlePendulum.get(i).acceleration * delta_time;
      singlePendulum.get(i).angle += singlePendulum.get(i).velocity;
      singlePendulum.get(i).position.set(singlePendulum.get(i).lengh * sin(singlePendulum.get(i).angle) + singlePendulum.get(i - 1).position.x, singlePendulum.get(i).lengh * cos(singlePendulum.get(i).angle) + singlePendulum.get(i - 1).position.y);
      singlePendulum.get(i).velocity *= damping;
    }
  }

  void trace(int k, int howManyNPen)
  {
    iko = k;
    calculations();
    point[traceIndex].y = singlePendulum.get(tier - 1).position.y;
    point[traceIndex].x =  singlePendulum.get(tier - 1).position.x;

    traceIndex++;

    if (traceIndex == point.length)
    {
      traceIndex = 0;
    }

    stroke(100, 0, 100);
    strokeWeight(6);
    noFill();

    current = traceIndex;

    //drawing a trace
    beginShape();
    for (int j = 0; j<point.length; j++)
    {
      current++;

      if (current == point.length) 
      {
        current = 0;
      }

      stroke((map(j, 0, point.length, 50, 255)), (map(iko, 0, howManyNPen, 50, 255)), (map(current, 0, point.length, 50, 255)));

      curveVertex(point[current].x, point[current].y);
    }
    endShape();
  }

  void setingFieldVariables()
  { 
    fieldVariables.put("gravity", gravity);
    fieldVariables.put("tier", float (tier));

    for (int i = 0; i < tier; i++)
    {
      fieldVariables.replace("mas" + i, singlePendulum.get(i).mass);
      fieldVariables.replace("angles" + i, singlePendulum.get(i).angle);
      fieldVariables.replace("length" + i, singlePendulum.get(i).lengh);
      fieldVariables.replace("radius" + i, singlePendulum.get(i).radius);
      fieldVariables.replace("velocities" + i, singlePendulum.get(i).velocity);      
      fieldVariables.replace("accelerations" + i, singlePendulum.get(i).acceleration);
      fieldVariables.replace("position["+ i +"].x", singlePendulum.get(i).position.x);
      fieldVariables.replace("position["+ i +"].y", singlePendulum.get(i).position.y);
    }
  }

  void drawing()
  {
    colorDetermination.get(0).findingSmallestAndBiggestValue(singlePendulum.get(0).velocity, singlePendulum.get(0).acceleration, singlePendulum.get(0).angle);

    strokeWeight(2);
    stroke(255, 0, 0);
    circle(origin.x, origin.y, 20);
    stroke(255, 255, 0);
    fill(colorDetermination.get(0).valueMapping(0, singlePendulum.get(0).velocity, 10, 255), colorDetermination.get(0).valueMapping(1, singlePendulum.get(0).acceleration, 10, 255), colorDetermination.get(0).valueMapping(2, singlePendulum.get(0).angle, 10, 255));
    line(origin.x, origin.y, singlePendulum.get(0).position.x, singlePendulum.get(0).position.y);
    circle( singlePendulum.get(0).position.x, singlePendulum.get(0).position.y, singlePendulum.get(0).radius);

    for (int i = 1; i < tier; i++)
    {
      colorDetermination.get(i).findingSmallestAndBiggestValue(singlePendulum.get(i).velocity, singlePendulum.get(i).acceleration, singlePendulum.get(i).angle);
      fill(colorDetermination.get(i).valueMapping(0, singlePendulum.get(i).velocity, 10, 255), colorDetermination.get(i).valueMapping(1, singlePendulum.get(i).acceleration, 10, 255), colorDetermination.get(i).valueMapping(2, singlePendulum.get(i).angle, 10, 255));
      stroke(255, 255, 0);
      line(singlePendulum.get(i - 1).position.x, singlePendulum.get(i - 1).position.y, singlePendulum.get(i).position.x, singlePendulum.get(i).position.y);
      stroke(255, 0, 0);
      circle(singlePendulum.get(i).position.x, singlePendulum.get(i).position.y, singlePendulum.get(i).radius);
    }
  }
}
