class Circum {
  int max_velocity = 15;
  float radius, mass, ref = 0.5, springness = 0.9999;
  PVector  point = new PVector(0, 0);
  PVector  acceleration = new PVector(0, 0);
  PVector  velocity = new PVector(new Random().nextInt(max_velocity) + 0.05, -1 * (new Random().nextInt(max_velocity) + 0.05));
  PVector gre = new PVector(0, 0);
  String[] fieldName = new String[3];
  float[] fieldValue = new float[3];
  Function[] fun = new Function[6];


  Circum() {
    mass = 5 * new Random().nextFloat() + 1;
    radius = mass * 4;
    point.x = (width * new Random().nextFloat()) - radius;
    point.y =  (height * new Random().nextFloat()) - radius;

    fun[0] = new Function(velocity.y - 1, velocity.y + 1);
    fun[1] = new Function(gre.y + 0.005, gre.y - 0.005);
    fun[2] = new Function(point.y - 0.005, point.y + 0.01);
    fun[3] = new Function(point.x - 0.01, point.x + 0.01);
    fun[4] = new Function(gre.x + 0.005, gre.x - 0.005);
    fun[5] = new Function(velocity.x - 0.01, max_velocity);
  }

  Circum(float x_, float y_, float r_, float m_) {
    this();
    point.x = x_;
    point.y = y_;
    radius = r_;
    mass = m_;

    fun[0] = new Function(velocity.y - 1, velocity.y + 1);
    fun[1] = new Function(gre.y + 0.005, gre.y - 0.005);
    fun[2] = new Function(point.y - 0.05, point.y + 0.1);
    fun[3] = new Function(point.x - 0.1, point.x + 0.1);
    fun[4] = new Function(gre.x + 0.005, gre.x - 0.005);
    fun[5] = new Function(velocity.x - 0.01, max_velocity);
  }

  void setSpeed(PVector force) {
    PVector f = force.copy();
    acceleration.add(PVector.div( f, mass));
    velocity.add(acceleration);
    point.add(velocity);
    gre = acceleration.copy();

      // If out of bounds
    if (point.y - radius <= 0) 
    {
      velocity.y *= -springness;
      point.y = 0 + radius;
    } else if (point.y + radius >= height) 
    {
      velocity.y *= -springness;
      point.y = height - radius ;
    }
    if (point.x - radius <= 0)
    {
      velocity.x *= -springness;
      point.x = 0 + radius;
    } else if (point.x + radius >= width)
    {
      velocity.x *= -springness;
      point.x = width - radius;
    }
    acceleration.mult(0);
  }

  int showingData()
  {
    fieldName[0]  = "radius";
    fieldValue[0] = radius;
    fieldName[1]  = "mass";
    fieldValue[1] = mass;
    fieldName[2]  = "springiness";
    fieldValue[2] = springness;
    


    return 3;
  }

  void drawing() {

    //finding the smallest and largest limit values used to change the color of objects
    fun[0].findingTheItem(velocity.y);
    fun[1].findingTheItem(gre.y);
    fun[2].findingTheItem(point.y);
    fun[3].findingTheItem(point.x);
    fun[4].findingTheItem(gre.x);
    fun[5].findingTheItem(velocity.x);

    fill((map(velocity.y, fun[0].smallestItem - 0.01, fun[0].largestItem + 0.01, 60, 255)), (map(gre.y, fun[1].smallestItem - 0.01, fun[1].largestItem + 0.01, 50, 100)), (map(point.y, fun[2].smallestItem - 0.01, fun[2].largestItem + 0.01, 1, 255)) );
    stroke((map(point.x, fun[3].smallestItem - 0.01, fun[3].largestItem + 0.01, 100, 255)), (map(gre.x, fun[4].smallestItem - 0.01, fun[4].largestItem + 0.01, 60, 110)), (map(velocity.x, fun[5].smallestItem - 0.01, fun[5].largestItem + 0.01, 50, 255)));
    circle(point.x, point.y, 2 * radius);

    strokeWeight(2);
    stroke(255, 255, 255);
    PVector dir = velocity.copy();
    dir.normalize().mult(radius);
    dir = PVector.add(dir, point);
    line(point.x, point.y, dir.x, dir.y);
  }
}
