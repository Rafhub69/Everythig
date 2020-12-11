void checkForCollision()
{
  for (int i = 0; i<cir.size() -1; i++)
  {
    for (int j = i + 1; j<cir.size(); j++)
    {
      //calculating distance between object
      PVector lengthFrom_i_to_j= PVector.sub( cir.get(j).point, cir.get(i).point);
      float oldDist = lengthFrom_i_to_j.mag();
      float min_dyst = cir.get(j).radius + cir.get(i).radius;
      //checking for collision
      if (oldDist <= min_dyst)
      {    
        collision(cir.get(i), cir.get(j), oldDist, min_dyst, lengthFrom_i_to_j);
      }
    }
  }
}

void collision(Circum con1, Circum con2, float dist_, float min_, PVector lock)
{
  float u1, u2, distance = dist_, min_dyst = min_;

  //static collision
  float distanceCorrection = (min_dyst-distance)/2.0;
  PVector correctionVector = lock.normalize().mult(distanceCorrection);
  con2.point.add(correctionVector);
  con1.point.sub(correctionVector);

  //dynamic collision

  // Defining the X axis
  PVector dirX = lock.copy();
  dirX.normalize();
  // Defining the Y axis
  PVector dirY = new PVector(dirX.y, -dirX.x);

  // X coordinates of velocities
  float vx1 = dirX.dot(con1.velocity);
  float vx2 = dirX.dot(con2.velocity);
  // Y coordinates of velocities
  float vy1 = dirY.dot(con1.velocity);
  float vy2 = dirY.dot(con2.velocity);

  // Applying the collision to X coordinates
  u1 = (2 * vx2 * con2.mass + vx1 * (con1.mass - con2.mass)) / (con1.mass + con2.mass);
  u2 = (2 * vx1 * con1.mass + vx2 * (con2.mass - con1.mass)) / (con1.mass + con2.mass);

  // Turning velocities back into vectors
  PVector vel1 = PVector.mult(dirX, u1);
  PVector vel2 = PVector.mult(dirX, u2);
  vel1.add(PVector.mult(dirY, vy1));
  vel2.add(PVector.mult(dirY, vy2));

  con1.velocity = vel1;
  con2.velocity = vel2;
}

void centralFieldManagement()
{
  float dem = 0, dividerx = 0, dividery = 0, Distance;
  PVector grav_atract = new PVector(0, 0);
  ArrayList<PVector> reverseGravity = new ArrayList<PVector>(cir.size());

  if (centralAction)
  {
    for (int i = 0; i < cir.size(); i++)
    {
      reverseGravity.add(new PVector(0, 0));
    }

    for (int i = 0; i<cir.size(); i++)
    {
      //Calculation of the mass center
      dem += cir.get(i).mass;
      dividerx += cir.get(i).mass * cir.get(i).point.x;
      dividery += cir.get(i).mass * cir.get(i).point.y;

      for (int j = i + 1; j<cir.size(); j++)
      {

        //calculating distance between object
        PVector lengthFrom_i_to_j= PVector.sub( cir.get(j).point, cir.get(i).point);
        PVector lengthFrom_j_to_i= PVector.sub( cir.get(i).point, cir.get(j).point);

        Distance = lengthFrom_i_to_j.mag();
        lengthFrom_i_to_j.normalize();
        lengthFrom_j_to_i.normalize();

        //adding gravity
        float strength = (G_const * cir.get(i).mass * cir.get(j).mass)/(Distance * Distance);
        lengthFrom_i_to_j.mult(strength);
        lengthFrom_j_to_i.mult(strength);

        reverseGravity.get(j).add(lengthFrom_j_to_i);

        grav_atract.add(lengthFrom_i_to_j);
      }

      grav_atract.add(reverseGravity.get(i));
      cir.get(i).setSpeed(grav_atract);
      grav_atract.mult(0);

      for (int k = 0; k<reverseGravity.size(); k++)
      {
        reverseGravity.get(k).mult(0);
      }
    }
  }

  checkForCollision();

  for (int i = 0; i<cir.size(); i++)
  {   
    cir.get(i).drawing();
    
    fill(50, 0, 255 );
    stroke(255, 0, 50);
    textAlign(CENTER, CENTER);
    text(i, cir.get(i).point.x, cir.get(i).point.y);
  }

  //Drawing a center of mass
  pushMatrix();
  strokeWeight(6);
  fill(50, 0, 255 );
  stroke(255, 0, 50);
  point((dividerx/dem), (dividery/dem));
  popMatrix();
}

void homogeneousFieldManagement()
{
  PVector  air_replica = new PVector(0.004, 0.004);
  PVector  grav = new PVector(0.00, 3.00);
  PVector air;

  if (homogeneousAction)
  {
    for (int i = 0; i<cir.size(); i++)
    {//Adding gravity
      cir.get(i).setSpeed(grav);
      air = air_replica.copy(); 

      if (cir.get(i).velocity.x>0 ||cir.get(i).velocity.y>0)
      {
        air.mult(-1);
      }
      //adding motion resistance
      cir.get(i).setSpeed(air);
    }
  }

  checkForCollision();

  for (int j = 0; j<cir.size(); j++)
  {
    cir.get(j).drawing();
    strokeWeight(6);
    fill(50, 0, 255 );
    stroke(255, 0, 50);
    textAlign(CENTER, CENTER);
    text(j, cir.get(j).point.x, cir.get(j).point.y);
  }
}
