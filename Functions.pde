class Function {
  float smallestItem, largestItem;

  Function(float largest, float smallest) 
  {
    largestItem = largest;
    smallestItem = smallest;
  }

  Function() {
  }

  String findingData() 
  {
    int dateInt[] = new int[6];
    String dateString[] = new String[6];

    dateInt[0] = second();
    dateInt[1] = minute();
    dateInt[2] = hour();
    dateInt[3] = day();
    dateInt[4] = month();
    dateInt[5] = year();

    for (int i = 0; i <= 5; i++)
    {
      dateString[i] = twoDate(dateInt[i]);
    }    

    return dateString[0] + dateString[1] + dateString[2] + dateString[3] + dateString[4] + dateString[5];
  }

  String twoDate(int lo) 
  {
    String convert = str(lo);
    return (convert.length() == 1) ? ("0" + convert) : convert;
  }

  void findingTheItem(float item_)
  {
    if (item_ < smallestItem)
    {
      smallestItem = item_;
    } else if (item_ > largestItem)
    {
      largestItem = item_;
    }
  }
}

class LotsOfFunctions 
{

  Function[] fun = new Function[3];

  LotsOfFunctions(float velocity, float acceleration, float angle)
  {
    fun[0] = new Function(velocity, velocity);
    fun[1] = new Function(acceleration, acceleration);
    fun[2] = new Function(angle, angle);
  }

  void findingSmallestAndBiggestValue(float velocity, float acceleration, float angle)
  {
    fun[0].findingTheItem(velocity);
    fun[1].findingTheItem(acceleration);
    fun[2].findingTheItem(angle);
  }

  float valueMapping(int index, float value, int smallestValue, int biggestValue)
  {   
    float average = (biggestValue + smallestValue)/2;
    boolean equal = (fun[index].largestItem == fun[index].smallestItem);
    boolean outOfRange = value > fun[index].largestItem || value < fun[index].smallestItem;
    
    
    if(equal)
   {
     fun[index].largestItem += (fun[index].largestItem * 0.1) + 0.001;
     fun[index].smallestItem -= (fun[index].smallestItem * 0.1) + 0.001; 
   }

    float mappedValue = map(value, fun[index].smallestItem, fun[index].largestItem, smallestValue, biggestValue);
    
    //mappedValue
    
    
    return outOfRange ? average : mappedValue;
  }
}
