class LisajousTable {

  int size = 100, cols, rows;
  float centerX = 0, centerY = 0, x = 0, y = 0;  
  ArrayList<ArrayList<Curve>> curves = new ArrayList<ArrayList<Curve>>();
  boolean whatLine = true; //true - horizontal line, false - vertical line
  float angle = 0, angleChange1 = 0, angleChange2 = 0.05;    
  float diameter = size - 0.2 * size, radius = diameter/2, offset = size/2;

  LisajousTable()
  {
    //Calculation of the number of circles vertically and horizontally
    cols = (width - int(offset)) / size;
    rows = (height - int(offset)) / size;

    for (int j = 0; j < rows; j++) {
      curves.add(new ArrayList<Curve>());
      for (int i = 0; i < cols; i++) {
        curves.get(j).add(new Curve());
      }
    }
  }

  void reset(float change)
  {

    angleChange1 = 0;
    angleChange2 = change;

    for (int j = 0; j < rows; j++) 
    {
      for (int i = 0; i < cols; i++) 
      {
        curves.get(j).get(i).reset();
      }
    }

    offset = size/2;
    diameter = size - 0.2 * size;
    radius = diameter/2;

    cols = (width - int(offset)) / size;
    rows = (height - int(offset)) / size;

    for (int j = 0; j < rows; j++) {
      curves.add(new ArrayList<Curve>());
      for (int i = 0; i < cols; i++) {
        curves.get(j).add(new Curve());
      }
    }

    angle = 0;
  }

  void calculations()
  {
    float line1 = 0, plane = 0, line2 = 0, inside = 0, sizePlusOfset = size + offset;

    if (whatLine)
    {
      line1 = cols;
      line2 = rows;
      plane = height;
      centerY = offset;
    } else
    {
      line1 = rows;
      line2 = cols;
      plane = width;
      centerX = offset;
    }

    for (int i = 0; i < line1; i++) 
    {
      if (whatLine)
      {
        centerX = sizePlusOfset + i * size;
      } else
      { 
        centerY = sizePlusOfset + i * size;
      }
       
       inside = angle * (i + 1) - HALF_PI;
       
      x = radius * cos(inside);
      y = radius * sin(inside);

      for (int j = 0; j < line2; j++) 
      {

        if (whatLine)
        {
          curves.get(j).get(i).setX(centerX + x);
        } else
        {
          curves.get(i).get(j).setY(centerY + y);
        }
      }

      strokeWeight(1);
      stroke(255, 230);
      ellipse(centerX, centerY, diameter, diameter);
      strokeWeight(8);
      point(centerX + x, centerY + y);
      stroke(255, 150);
      strokeWeight(1);
      //stroke((map(i, 0, line1 - 1, 0, 255)), (map(angle, -TWO_PI, TWO_PI, 50, 255)), (map(float(int(whatLine)), 0, 1, 100, 255)));
      
      if (whatLine)
      {        
        line(centerX + x, 0, centerX + x, plane);
      } else
      {
        line(0, centerY + y, plane, centerY + y);
      }
    }
  }

  void show(boolean action)
  {
    for (int i = 0; i < 2; i++)
    {
      calculations();
      whatLine = !whatLine;
    }    

    for (int j = 0; j < rows; j++) {
      for (int i = 0; i < cols; i++) {
        if (action)
        {
          curves.get(j).get(i).addPoint();
        }

        curves.get(j).get(i).show();
      }
    }

    angle -= angleChange1 * delta_time;

    // If the angle is - two pi, the first circle has traveled the entire lap.
    if (angle < -TWO_PI) {

      for (int j = 0; j < rows; j++) {
        for (int i = 0; i < cols; i++) {
          curves.get(j).get(i).reset();
        }
      }      
      //saveFrame("###lissajous.png");
      angle = 0;
    }
  }
}
