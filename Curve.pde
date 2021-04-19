class Curve 
{
  ArrayList<PVector> path;
  PVector current = new PVector(0,0);

  Curve() 
  {
    path = new ArrayList<PVector>();
    current = new PVector();
  }

  void setX(float x) 
  {
    current.x = x;
  }

  void setY(float y) 
  {
    current.y = y;
  }

  void addPoint() 
  {
    path.add(current);
  }

  void reset() 
  {
    path.clear();
  }

  void show() 
  {
    noFill();
    stroke(255);
    strokeWeight(1);  
    beginShape();
    for (PVector v : path) {
       //stroke((map(path.get(i).x, 0, width, 50, 255)), (map(i, 0, path.size(), 0, 255)), (map(path.get(i).y, 0, height, 100, 255)));
       vertex(v.x, v.y);
    }
    
    endShape();
    strokeWeight(8);
    point(current.x, current.y);
    current = new PVector();
  }
}
