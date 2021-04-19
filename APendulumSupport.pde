void creatingRandomPendulums(int howManySinglePendulum)
{
  float a1 = PI / (randa.nextFloat() + 0.5);
  singlePend.add(new Pendulum(a1, new PVector(width / 2, height/3)));

  for (int i = 1; i < howManySinglePendulum; i++)
  {
    a1 = PI / (randa.nextFloat() + 0.6);
    singlePend.add(new Pendulum(a1, singlePend.get(i - 1).position));
  }
}

void creatingRandomDoublePendulums(int howManyDoublePendulum)
{
  float length1 = 350, length2 = 200, mas1 = 40, mas2 = 20, a1, a2;

  for (int i = 0; i < howManyDoublePendulum; i++)
  {
    a1 = PI / (randa.nextFloat() + 1);
    a2 = PI / (randa.nextFloat() + 3); 
    doublePend.add(new DoublePendulum( a1, a2, length1, length2, mas1, mas2));
  }
}

void creatingRandomNPendulums()
{
  for (int i = 0; i < numberOfNpendulum; i++)
  {
    nPend.add(new NPendulum(degreeOfPendulum));
  }
}

void pendulumManagement()
{
  if (pendul) {
    singlePendulumManagement();
  } else {
    dublePendulumManagement();
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
    if (doubleAction) 
    {
      noFill(); 
      strokeWeight(6); 
      doublePend.get(i).trace(i, doublePend.size());
    }    
    doublePend.get(i).drawing();
  }
  //drawing center ball
  fill(82, 0, 14);
  stroke(153, 0, 26);
  circle(0, 0, 20);
}

void nPendulManagement()
{
  background(120);

  for (int i= 0; i < nPend.size(); i++)
  {
    if (nPendulumAction)
    {
      nPend.get(i).trace(i, numberOfNpendulum);
    }
    nPend.get(i).drawing();
  }
}
