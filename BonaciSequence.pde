class BonaciSequence
{
  int many = 100; 
  int much = 1000;
  int control = many;
  float scene = 100.0000;
  boolean reflection = true;
  long[] tab = new long[many];
  Function[] fun = new Function[3];

  BonaciSequence()
  {
    tab[0] = 0;
    tab[1] = 1;
    many = control;

    fun[0] = new Function(scene + 1, scene - 1);
    fun[1] = new Function(curIndex, curIndex);
    fun[2] = new Function(tab[0], tab[0]);
  }

  void reset()
  {
    tab[0] = 0;
    tab[1] = 1;
    much = 1000;
    many = control;
    scene = 100.0000;       
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

    for (int i = 1; i <= much; i++)
    {

      for (int j = 2; j < many; j++)
      {

        tab[j] = i * tab[j - 1] + tab[j - 2];

        if (tab[j] < 0 || tab[j] >= 1920)
        {
          break;
        }

        //finding the smallest and largest limit values used to change the color of objects
        fun[0].findingTheItem(scene);
        fun[1].findingTheItem(i);
        fun[2].findingTheItem(tab[j]);

        stroke((map(scene, fun[0].smallestItem, fun[0].largestItem, 140, 255)), (map(i, fun[1].smallestItem, fun[1].largestItem, 50, 255)), (map(tab[j], fun[2].smallestItem, fun[2].largestItem, 100, 255)));
        //stroke((map(scene, fun[0].smallestItem, fun[0].largestItem, 150, 255)), (map(i, fun[1].smallestItem, fun[1].largestItem, 50, 200)), (map(tab[j], fun[2].smallestItem, fun[2].largestItem, 50, 250)));
        pushMatrix();
        rotate(j * (PI/2));
        rect(0, 0, scene * tab[j], scene * tab[j]);
        popMatrix();
      }



      if (millis()%10 == 0)
      {
        much++;
        many++;

        if (many >= control)
        {
          many = 5;
        }

        if (much >= 1000000)
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
    
    scene += nBonaciAction ? (reflection ? -0.04000 : 0.04000) : 0;    
    popMatrix();
  }
}
