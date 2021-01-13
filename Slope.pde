class Slope
{
  float sideA = 250, sideB = 200, sideC = 100;
  float x1 = -8, y1 = (-sideB - 26), spot = 0;
  float a1_acc = 0, a1_vel = 0, gravity = 9.81, delta_t = 0.003; 

  Slope()
  {
  }

  void kula()
  {
    delay(30);

    a1_vel += a1_acc;
    x1 += (a1_vel * (sideA / sideC)) * delta_t;
    y1 += (a1_vel * (sideB / sideC)) * delta_t;
  }

  void drawing()
  {
    a1_acc = (5 * gravity * (sideA / sideC)) / 7;
    triangle(spot, -sideB, spot, spot, sideA, spot);
    line(-20, -sideB - 15, spot, -sideB);
    line(sideA, spot, sideA + 30, spot);
    kula();

    if (x1 >= (sideA + 10) || y1 >= -15) 
    {
      x1 = -8;
      y1 = (-sideB - 26);
      a1_acc = 0;
      a1_vel = 0;
      kula();
    }

    circle(x1, y1, 30);
  }
}
