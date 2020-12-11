class Function {
  float smallestItem, largestItem;


  Function(float largest, float smallest)
  {
    largestItem = largest;
    smallestItem = smallest;
  }

  Function()
  {
  }

  String findingData()
  {
    int da[] = new int[6];
    String date[] = new String[6];

    da[0] = second();
    da[1] = minute();
    da[2] = hour();
    da[3] = day();
    da[4] = month();
    da[5] = year();

    for (int i = 0; i < 6; i++)
    {
      date[i] = twoDate(da[i]);
    }    

    return date[0] + date[1] + date[2] + date[3] + date[4] + date[5];
  }

  String twoDate(int lo)
  {
    String convert = str(lo);

    if (convert.length() == 1)
    {
      convert = "0" + convert;
    }
    
    return convert;
  }

  void findingTheItem(float item_)
  {
    if (item_<smallestItem)
    {
      smallestItem = item_;
    } else if (item_>largestItem)
    {
      largestItem = item_;
    }
  }
}
