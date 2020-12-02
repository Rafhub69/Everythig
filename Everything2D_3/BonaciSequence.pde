class BonaciSequence
{
  int many = 100, much = 1000;
  long[] tab = new long[many];
  int control = many;
  float scene = 100.0000;
  boolean reflection = true;
  Function[] fun = new Function[3];

  BonaciSequence()
  {
    tab[0] = 0;
    tab[1] = 1;
    many = control;

    fun[0] = new Function(scene + 1, scene - 1);
    fun[1] = new Function(i, i);
    fun[2] = new Function(tab[0], tab[0]);
  }

  void reset()
  {
    tab[0] = 0;
    tab[1] = 1;
    scene = 100.0000;
    much = 1000;
    many = control;
    reflection = true;

    for (int j = 2; j < many; j++)
    {
      tab[j] = 0;
    }
  }


  void drawing()
  {
    pushMatrix();
    translate(width/2, height/2);
    noFill();

    for (int i = 1; i <=much; i++)
    {
      for (int j = 2; j < many; j++)
      {

        tab[j] = i * tab[j - 1] + tab[j - 2];

        if (tab[j] <= 0 || tab[j] >= 1070 )
        {
          break;
        }

        //finding the smallest and largest limit values used to change the color of objects
        fun[0].findingTheItem(scene);
        fun[1].findingTheItem(i);
        fun[2].findingTheItem(tab[j]);

        strokeWeight(1);
        stroke((map(scene, fun[0].smallestItem, fun[0].largestItem, 100, 200)), (map(i, fun[1].smallestItem, fun[1].largestItem, 50, 255)), (map(tab[j], fun[2].smallestItem, fun[2].largestItem, 100, 200)) );
        pushMatrix();

        rotate( j * (PI/2));

        rect(0, 0, scene * tab[j], scene * tab[j]);
        // scene * tab[j],scene * tab[j], scene * tab[j],scene * tab[j]
        strokeWeight(10);

        popMatrix();
      }

      if (millis()%100 == 0)
      {
        much++;
        many++;

        if (many >= control)
        {
          many = 5;
        }

        if (much >= 10000000)
        {
          much = 100;
        }
      }
    }


    if (scene < -100)
    {
      reflection = false;
    } else if (scene > 100)
    {
      reflection = true;
    }
    
    if (nBonaciAction)
    {
      if ( reflection == true)
      {

        scene -=0.04000;
      } else if (reflection == false)
      {
        scene +=0.04000;
      }
    }
    popMatrix();
  }
}
