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
    if (stopStart)
    {
      nPend.get(i).trace(i, ile);
    }
    nPend.get(i).drawing();
  }
}
