void singlePendulum()
{
  
  for (int i = 0; i< pend.size(); i++)
  {
    if (singleAction)
    {
      pend.get(i).update();
    }
    pend.get(i).drawing();
  }
  circle(0, 0, 10);
 
}

void dublePendulum()
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
