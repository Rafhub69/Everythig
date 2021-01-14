void creatingRandomPendulums()
{
  float a1 = PI / (4 * randa.nextFloat() + 0.5);
  singlePend.add(new Pendulum(a1, new PVector(width / 2, height/3)));

  for (int i = 1; i < howManySinglePend; i++)
  {
    a1 = PI / (randa.nextFloat() + 0.5);
    singlePend.add(new Pendulum(a1, singlePend.get(i - 1).position));
  }
}

void creatingRandomDoublePendulums()
{
  float length1 = 350, length2 = 200, mas1 = 40, mas2 = 20, a1, a2;
  
  for (int i = 0; i < howManyDoublePen; i++)
  {
    a1 = PI / (randa.nextFloat() + 1);
    a2 = PI / (randa.nextFloat() + 3); 
    doublePend.add(new DoublePendulum( a1, a2, length1, length2, mas1, mas2));
  }
}

void creatingRandomNPendulums()
{
  for (int i= 0; i < numberOfNpendulum; i++)
  {
    nPend.add(new NPendulum(degreeOfPendulum));
  }
}

void singlePendulumManagement()
{

  for (int i = 0; i < singlePend.size(); i++)
  {
    if (singleAction)
    {
      singlePend.get(i).update();
    }
    singlePend.get(i).drawing();
  }
  circle(0, 0, 10);
}

void dublePendulumManagement()
{

  for (int i = 0; i < doublePend.size(); i++)
  { 
    doublePend.get(i).drowing(i, howManyDoublePen);
  }
  //drawing center ball
  fill(82, 0, 14);
  stroke(153, 0, 26);
  circle(0, 0, 20);
}

void nPendulManagement()
{
  for (int i= 0; i < nPend.size(); i++)
  {
    if (nPendulumAction)
    {
      nPend.get(i).trace(i, howManyDoublePen);
    }

    nPend.get(i).drawing();
  }
}
