class StrengeCircles
{
  float angle = 0.0001;  
  float radius = 0.01, angleChange = 0.1;
  int amount = 1000, numberOfCircles = 30;
  PVector[]  point = new PVector[amount];
  PVector[]  center = new PVector[numberOfCircles];  
  
  Function[] fun = new Function[3];

  StrengeCircles(float rad, float angleChange_, int amo)
  {
    amount = amo;
    radius = rad;
    angleChange = angleChange_;
    
    for (int i = 0; i <numberOfCircles; i++)
    {
      center[i] = new PVector(0, 0);
    }

    for (int i = 0; i<amount; i++)
    {
      point[i] = new PVector(1, 1);
    }

    fun[0] = new Function(angle, angle);
    fun[1] = new Function(point[curIndex].x, point[curIndex].x);
    fun[2] = new Function(point[curIndex].y, point[curIndex].y);
  }

  void strange()
  {
    if (strangeCirclesAction)
    {
      for (int i = 0; i <amount; i++)
      {
        point[i].x = radius * cos(angle);
        point[i].y = radius * sin(angle);
        angle+=angleChange;
      }
    }

    for (int i = 0; i <amount; i++)
    {
      translate(point[i].y, point[i].x);
      
      //finding the smallest and largest limit values used to change the color of objects
      fun[0].findingTheItem(angle);
      fun[1].findingTheItem(point[i].x);
      fun[2].findingTheItem(point[i].y);

      stroke((map(angle, fun[0].smallestItem, fun[0].largestItem, 10, 255)), (map(point[i].x, fun[1].smallestItem, fun[1].largestItem, 10, 255)), (map(point[i].y, fun[2].smallestItem, fun[2].largestItem, 10, 255)));
      point(point[i].x, point[i].y);
    }
  }

  void reset()
  {
    angle = 0.0000;
    for (int i = 0; i<point.length; i++)
    {
      point[i] = new PVector(0, 0);
    }
  }
}
