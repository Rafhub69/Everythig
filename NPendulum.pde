class NPendulum {

  int tier = 0;
  FloatList mass;  
  FloatList angles;
  FloatList lenghts;
  FloatList radiuses;
  FloatList velocities; 
  FloatList accelerations;
  int l = 0, current = l, iko = 0;
  float damping = 0.998, g = 3.924; 
  PVector[] point = new PVector[300];  
  ArrayList<LotsOfFunctions> colorDetermination;
  PVector origin = new PVector(width / 2, height/3); 
  HashMap<String, Float> fieldVariables = new HashMap<String, Float>();
  PVector[] position;

  NPendulum(int _tier)
  {
    tier = _tier;   
    mass = new FloatList(tier);
    position = new PVector[tier];
    angles = new FloatList(tier);
    lenghts = new FloatList(tier);   
    radiuses = new FloatList(tier);  
    velocities = new FloatList(tier); 
    accelerations = new FloatList(tier);    
    colorDetermination  = new ArrayList<LotsOfFunctions>(tier);
    reset();

    for (int i = 0; i<point.length; i++)
    {
      point[i] = new PVector(position[position.length - 1].x, position[position.length - 1].y);
    }
  }

  NPendulum()
  {
  }

  void reset()
  {
    mass.clear();
    angles.clear();
    lenghts.clear();
    radiuses.clear();
    velocities.clear(); 
    accelerations.clear();
    fieldVariables.put("gravity", g);
    fieldVariables.put("tier", float (tier));

    for (int i =0; i<tier; i++)
    {
      velocities.append(0);
      accelerations.append(0);
      mass.append(random(10, 50));
      radiuses.append(mass.get(i));
      angles.append(random(PI));
      lenghts.append(random(radiuses.get(i) + 12, height/(2 * tier))); 
      position[i] = new PVector(lenghts.get(i) * sin(angles.get(i)) + origin.x, lenghts.get(i) * cos(angles.get(i)) + origin.y);
      colorDetermination.add(new LotsOfFunctions(velocities.get(i), accelerations.get(i), angles.get(i)));

      fieldVariables.put("mas" + i, mass.get(i));
      fieldVariables.put("angles" + i, angles.get(i));
      fieldVariables.put("length" + i, lenghts.get(i));
      fieldVariables.put("radius" + i, radiuses.get(i));
      fieldVariables.put("velocities" + i, velocities.get(i));
      fieldVariables.put("position[" + i +"].x", position[i].x);
      fieldVariables.put("position[" + i +"].y", position[i].y);
      fieldVariables.put("accelerations" + i, accelerations.get(i));
    }

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
        den += mass.get(k) * lenghts.get(k) * lenghts.get(k) * (j <= k? 1 : 0);
      }


      for (int k = 0; k < tier; k++) {
        //first numerator
        num1 = g * lenghts.get(j) * sin(angles.get(j)) * mass.get(j) * (j <= k? 1 : 0);

        //second numerator
        float inner_sum = 0;
        // inner sum
        for (int q = k+1; q < tier; q++) {
          inner_sum += mass.get(q) * (j <= q? 1 : 0);
        }
        num2 = inner_sum * lenghts.get(j) * lenghts.get(k) * sin(angles.get(j) - angles.get(k)) * velocities.get(j) * velocities.get(k);

        //Third numerator
        //The inner sum is the same as in the num2
        num3 = inner_sum * lenghts.get(j) * lenghts.get(k) * (sin(angles.get(k) - angles.get(j)) * (velocities.get(j) * velocities.get(k)) * velocities.get(k) + (j != k ? 1 : 0) * cos(angles.get(j) - angles.get(k))*accelerations.get(k));
      }
      float result = - (num1 + num2 + num3) / den;

      accelerations.set(j, result);
    }

    accToAngle();
  }

  void accToAngle()
  {
    velocities.set(0, velocities.get(0) + accelerations.get(0) * delta_time);
    angles.set(0, angles.get(0) + velocities.get(0));
    position[0].set(lenghts.get(0) * sin(angles.get(0)) + origin.x, lenghts.get(0) * cos(angles.get(0)) + origin.y);
    velocities.set(0, velocities.get(0) * damping);

    for (int i = 1; i < tier; i++)
    {
      velocities.set(i, velocities.get(i) + accelerations.get(i) * delta_time);
      angles.set(i, angles.get(i) + velocities.get(i));
      position[i].set(lenghts.get(i) * sin(angles.get(i)) + position[i - 1].x, lenghts.get(i) * cos(angles.get(i)) + position[i - 1].y);
      velocities.set(i, velocities.get(i) * damping);
    }
  }

  void trace(int k, int ile)
  {
    iko = k;
    calculations();
    point[l].x = position[position.length - 1].x;
    point[l].y = position[position.length - 1].y;

    l++;

    if (l==point.length)
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
    
    for (int i =0; i<tier; i++)
    {
      fieldVariables.replace("mas" + i, mass.get(i)); 
      fieldVariables.replace("angles" + i, angles.get(i));
      fieldVariables.replace("length" + i, lenghts.get(i));        
      fieldVariables.replace("radius" + i, radiuses.get(i));
      fieldVariables.replace("velocities" + i, velocities.get(i));        
      fieldVariables.replace("position[" + i +"].x", position[i].x);
      fieldVariables.replace("position[" + i +"].y", position[i].y);
      fieldVariables.replace("accelerations" + i, accelerations.get(i));
    }
  }

  void drawing()
  {
    colorDetermination.get(0).findingSmallestAndBiggestValue(velocities.get(0), accelerations.get(0), angles.get(0));

    strokeWeight(2);
    stroke(255, 0, 0);
    circle(origin.x, origin.y, 20);
    stroke(255, 255, 0);
    fill(colorDetermination.get(0).valueMapping(0, velocities.get(0), 10, 255), colorDetermination.get(0).valueMapping(1, accelerations.get(0), 10, 255), colorDetermination.get(0).valueMapping(2, angles.get(0), 10, 255));
    line(origin.x, origin.y, position[0].x, position[0].y);
    circle(position[0].x, position[0].y, radiuses.get(0));

    for (int i = 1; i<tier; i++)
    {
      colorDetermination.get(i).findingSmallestAndBiggestValue(velocities.get(i), accelerations.get(i), angles.get(i));
      fill(colorDetermination.get(i).valueMapping(0, velocities.get(i), 10, 255), colorDetermination.get(i).valueMapping(1, accelerations.get(i), 10, 255), colorDetermination.get(i).valueMapping(2, angles.get(i), 10, 255));
      stroke(255, 255, 0);
      line(position[i - 1].x, position[i - 1].y, position[i].x, position[i].y);
      stroke(255, 0, 0);
      circle(position[i].x, position[i].y, radiuses.get(i));
    }
  }
}
