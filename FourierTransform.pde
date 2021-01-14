class FourierTransform {

  int USER = 0;
  int FOURIER = 1;
  int state = -1;
  int epicycles;

  float time;
  float phase;
  float diameter;
  float interval;
  float frequency;
  float amplitude;  

  //PVector variables
  PVector pos;
  PVector prev;

  //arrays and arraylists
  ArrayList<Complex> x;
  ArrayList<PVector> path;
  ArrayList<PVector> drawing;
  ArrayList<Complex> Fourier;

  FourierTransform()
  {
    pos = new PVector();
    prev = new PVector();
    //initialize the ArrayLists
    x = new ArrayList<Complex>();
    path = new ArrayList<PVector>();
    Fourier = new ArrayList<Complex>();   
    drawing = new ArrayList<PVector>();
  }

  //--selection sort algorithm for sorting complex numbers by amplitude--//
  void SortComplex(ArrayList<Complex> c)
  {
    int n = c.size();

    for (int i = 0; i < n-1; i++)
    {
      int mindex = i;

      for (int j = i+1; j < n; j++)
      {
        if (c.get(j).amplitude > c.get(mindex).amplitude)
          mindex = j;
      }
      swap(c, mindex, i);
    }
  }

  //simple algorithm to swap two items in an array
  void swap(ArrayList<Complex> c, int i, int j)
  {
    Complex temp = c.get(i);
    c.set(i, c.get(j));
    c.set(j, temp);
  }

  ArrayList<Complex> dft(ArrayList<Complex> x)
  {
    int N = x.size();
    ArrayList<Complex> X = new ArrayList<Complex>(N);

    for (int k = 0; k < N; k++)
    {

      Complex sum = new Complex(0, 0);

      for (int n = 0; n < N; n++)
      {
        float phi = (TWO_PI * k * n) / N;
        Complex c = new Complex(cos(phi), -sin(phi));
        sum = sum.add(x.get(n).mult(c));
      }

      sum = sum.div(N);

      float freq = k;
      float amp = sum.mag();
      float phase = sum.heading();
      X.add(new Complex(sum.re, sum.im, freq, amp, phase));
    }
    return X;
  }


  void reset()
  {

    int xSize = x.size(), fourierSize = Fourier.size(), pathSize = path.size(), drawingSize = drawing.size();

    for (int i = xSize-1; i == 0; i--)
    {
      x.get(i).reset();
    }

    for (int i = fourierSize-1; i == 0; i--)
    {
      Fourier.get(i).reset();
    }

    for (int i = pathSize-1; i == 0; i--)
    {
      path.get(i).set(0, 0);
    }

    for (int i = drawingSize-1; i == 0; i--)
    {
      drawing.get(i).set(0, 0);
    }

    pos.set(0, 0);
    prev.set(0, 0);
  }

  //shows the epicycles and the generates each point in the path drawn by them
  PVector showfourier(float x, float y, ArrayList<Complex> fourier)
  {
    pos.x = x;
    pos.y = y;
    interval = TWO_PI/fourier.size();

    for (int i = 0; i < fourier.size(); i++)
    {
      prev.x = pos.x;
      prev.y = pos.y;

      Complex epicycle = fourier.get(i);
   
      phase = epicycle.phase;
      frequency = epicycle.frequency;  
      amplitude = epicycle.amplitude;
      diameter = amplitude * 2;
      

      float theta = frequency * time + phase;

      pos.x += amplitude * cos(theta);
      pos.y += amplitude * sin(theta); 
      noFill();
      stroke(255, 150);
      //ellipse(prev.x, prev.y, diameter, diameter);
      stroke(255);
      line(prev.x, prev.y, pos.x, pos.y);
    }
    return new PVector(pos.x, pos.y);
  }

  void mousePress()
  {
    x.clear();
    state = USER; 
    path.clear();
    drawing.clear();   
    time = 0;
  }

  void mouseRelis()
  {
    state = FOURIER; 

    //the number of epicycles is the number of points in the drawing
    epicycles = drawing.size()-1;

    //increasing the skip reduces the resolution of the fourier drawn image
    int skip = 1;

    //Populate the x arraylist with all the points in the drawing
    if (skip > 0)  //<-- avoids accidental infinite loops
    {
      for (int i = 0; i < epicycles; i += skip)
      {
        PVector point = drawing.get(i);
        Complex c = new Complex(point.x, point.y);
        x.add(c);
      }

      //perform discrete fourier transform on the x arraylist and sort it by amplitude
      Fourier = dft(x);
      SortComplex(Fourier);
    }
  }

  void show()
  {
    //if the user is drawing
    if (state == USER)
    {
      PVector point = new PVector(mouseX-(width/2), mouseY-(height/2));
      drawing.add(point);
    }

    //if the fourier transforms are drawing
    else if (state == FOURIER)
    {
      PVector vertex = showfourier(width/2, height/2, Fourier);

      path.add(vertex.copy());

      beginShape();
      for (int i = path.size()-1; i > 0; i--)
      {
        PVector p = path.get(i);
        vertex(p.x, p.y);
      }
      endShape();

      time += interval;

      if (time > TWO_PI)
      {
        time = 0;
        path.clear();
      }
      stroke(255, 25);
    }

    beginShape();
    for (PVector p : drawing)
    {
      vertex(p.x + width/2, p.y + height/2);
    }
    endShape();
  }
}
