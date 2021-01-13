class Circum {
  int max_velocity = 15;    
  PVector  point = new PVector(0, 0);
  PVector accToDraw = new PVector(0, 0);  
  PVector  acceleration = new PVector(0, 0);
  float radius, mass, springness = 0.9999;
  HashMap<String, Float> fieldVariables = new HashMap<String, Float>(10);
  PVector  velocity = new PVector(new Random().nextInt(max_velocity) + 0.05, -1 * (new Random().nextInt(max_velocity) + 0.05));  
  
  Function[] fun = new Function[6];

  Circum() {
    mass = 5 * new Random().nextFloat() + 1;
    radius = mass * 4;
    point.x = (width * new Random().nextFloat()) - radius;
    point.y =  (height * new Random().nextFloat()) - radius;

    inicialization();
  }

  Circum(float x_, float y_, float radius_, float mass_) {
    this();
    point.x = x_;
    point.y = y_;
    mass = mass_;
    radius = radius_; 

    inicialization();
  }

  Circum(PVector pos_, PVector vel_, PVector acc_, float radius_, float mass_, float springiness_)
  {
    mass = mass_;
    point = pos_;
    velocity = vel_;
    radius = radius_;    
    acceleration = acc_;
    springness = springiness_;

    inicialization();
  }

  void inicialization()
  {
    fun[0] = new Function(velocity.y - 1, velocity.y + 1);
    fun[1] = new Function(accToDraw.y + 0.005, accToDraw.y - 0.005);
    fun[2] = new Function(point.y - 0.05, point.y + 0.1);
    fun[3] = new Function(point.x - 0.1, point.x + 0.1);
    fun[4] = new Function(accToDraw.x + 0.005, accToDraw.x - 0.005);
    fun[5] = new Function(velocity.x - 0.01, max_velocity);

    fieldVariables.put("mass", mass);   
    fieldVariables.put("radius", radius);  
    fieldVariables.put("point.x", point.x);
    fieldVariables.put("point.y", point.y);
    fieldVariables.put("velocity.x", velocity.x);
    fieldVariables.put("velocity.y", velocity.y);
    fieldVariables.put("springness", springness);   
    fieldVariables.put("acceleration.x", acceleration.x);
    fieldVariables.put("acceleration.y", acceleration.y);
  }

  void setSpeed(PVector force) {
    PVector f = force.copy();
    acceleration.add(PVector.div( f, mass));
    acceleration.mult(delta_time);
    velocity.add(acceleration);
    point.add(velocity);
    accToDraw = acceleration.copy();

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

  void showingData()
  {
    fieldVariables.replace("mass", mass);    
    fieldVariables.replace("radius", radius);    
    fieldVariables.replace("point.x", point.x);
    fieldVariables.replace("point.y", point.y);
    fieldVariables.replace("velocity.x", velocity.x);
    fieldVariables.replace("velocity.y", velocity.y);
    fieldVariables.replace("springiness", springness);   
    fieldVariables.replace("acceleration.x", acceleration.x);
    fieldVariables.replace("acceleration.y", acceleration.y);
  }

  void drawing() {

    //finding the smallest and largest limit values used to change the color of objects
    fun[0].findingTheItem(velocity.y);
    fun[1].findingTheItem(accToDraw.y);
    fun[2].findingTheItem(point.y);
    fun[3].findingTheItem(point.x);
    fun[4].findingTheItem(accToDraw.x);
    fun[5].findingTheItem(velocity.x);

    fill((map(velocity.y, fun[0].smallestItem - 0.01, fun[0].largestItem + 0.01, 60, 255)), (map(accToDraw.y, fun[1].smallestItem - 0.01, fun[1].largestItem + 0.01, 50, 100)), (map(point.y, fun[2].smallestItem - 0.01, fun[2].largestItem + 0.01, 1, 255)) );
    stroke((map(point.x, fun[3].smallestItem - 0.01, fun[3].largestItem + 0.01, 100, 255)), (map(accToDraw.x, fun[4].smallestItem - 0.01, fun[4].largestItem + 0.01, 60, 110)), (map(velocity.x, fun[5].smallestItem - 0.01, fun[5].largestItem + 0.01, 50, 255)));
    circle(point.x, point.y, 2 * radius);

    strokeWeight(2);
    stroke(255, 255, 255);
    PVector dir = velocity.copy();
    dir.normalize().mult(radius);
    dir = PVector.add(dir, point);
    line(point.x, point.y, dir.x, dir.y);
  }
}
