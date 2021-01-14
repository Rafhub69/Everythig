void creatingRandomPendulums()
{
  a1 = PI / (4 * randa.nextFloat() + 0.5);
  singlePend.add(new Pendulum(a1, new PVector(width / 2, height/3)));

  for (int i = 1; i <ile_pend; i++)
  {
    a1 = PI / (randa.nextFloat() + 0.5);
    singlePend.add(new Pendulum(a1, singlePend.get(i - 1).position));
  }
}

void creatingRandomDoublePendulums()
{
  for (int i = 0; i< ile; i++)
  {
    mas1 = 40;
    mas2 = 20;
    length1 = 350;
    length2 = 200;
    a1 = PI / (randa.nextFloat() + 1);
    a2 = PI / (randa.nextFloat() + 3); 
    doublePend.add(new DoublePendulum( a1, a2, length1, length2, mas1, mas2));
  }
}

void creatingRandomNPendulums()
{
  for (int i= 0; i <numberOfNpendulum; i++)
  {
    nPend.add(new NPendulum(degreeOfPendulum));
  }
}

void singlePendulumManagement()
{

  for (int i = 0; i< singlePend.size(); i++)
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

  for (int i = 0; i< doublePend.size(); i++)
  { 
    doublePend.get(i).drowing(i, ile);
  }
  //drawing center ball
  fill(82, 0, 14);
  stroke(153, 0, 26);
  circle(0, 0, 20);
}

void nPendulManagement()
{
  for (int i= 0; i <nPend.size(); i++)
  {
    if (nPendulumAction)
    {
      nPend.get(i).trace(i, ile);
    }

    nPend.get(i).drawing();
  }
}
