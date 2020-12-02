class Function {
  float smallestItem, largestItem;

  Function(float largest, float smallest)
  {
    largestItem = largest;
    smallestItem = smallest;
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
