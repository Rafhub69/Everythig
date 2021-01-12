class Slope
{
  float a = 250, b = 200, c = 100;
  float x1 = -8, y1 = (-b - 26), spot = 0;
  float a1_a = 0, a1_vel = 0, g = 9.81, delta_t = 0.003; 

  Slope()
  {
  }

  void kula()
  {
    delay(30);

    a1_vel += a1_a;
    x1 += (a1_vel * (a / c)) * delta_t;
    y1 += (a1_vel * (b / c)) * delta_t;
  }

  void drawing()
  {
    a1_a = (5 * g * (a / c)) / 7;
    triangle(spot, -b, spot, spot, a, spot);
    line(-20, -b - 15, spot, -b);
    line(a, spot, a + 30, spot);
    kula();

    if (x1 >= (a + 10) || y1 >= -15) 
    {
      x1 = -8;
      y1 = (-b - 26);
      a1_a = 0;
      a1_vel = 0;
      kula();
    }

    circle(x1, y1, 30);
  }
}
