//reading input from buttons
void Homogen(int n) {

  CentralButton(n, false);
}

void Circle(int n) {

  CentralButton(n, true);
}

void Lisajous(int n) {

  CentralButton(n, true);
}

void Bonaci(int n) {

  CentralButton(n, false);
}

void Central(int n) {

  CentralButton(n, true);
}

void Single(int n) {

  CentralButton(n, true);
}

void Dual(int n) {

  CentralButton(n, false);
}

void FourTrans(int n) {

  CentralButton(n, true);
}

void Menu() 
{
  information = !information;
}

void Reset() 
{
  background(255);
  setting();
}

//buttons for changing various parameters
void Radius(float theValue)
{
  if (mode == 1)
  {
    cir.get(currentIndex).radius = theValue;
  } else if (mode == 2)
  {
    if (pendul)
    {
      pend.get(currentIndex).radius = theValue;
    } else 
    {
      if (doublePenIndex == 0)
      {
        doublePend.get(currentIndex).radius1 = theValue;
      } else if (doublePenIndex == 1)
      {
        doublePend.get(currentIndex).radius2 = theValue;
      }
    }
  }
}

void Mass(float theValue)
{

  if (mode == 1)
  {
    cir.get(currentIndex).mass = theValue;
  } else if (mode == 2)
  {
    if (doublePenIndex == 0)
    {
      doublePend.get(currentIndex).mas1 = theValue;
    } else if (doublePenIndex == 1)
    {
      doublePend.get(currentIndex).mas2 = theValue;
    }
  }
}

void Gravity(float theValue)
{
  if (pendul)
  {
    pend.get(currentIndex).gravity = theValue;
  } else 
  {
    doublePend.get(currentIndex).g = theValue;
  }
}

void Springness(float theValue)
{

  if (mode == 1)
  {
    cir.get(currentIndex).springness = theValue;
  } else if (mode == 2)
  {
    pend.get(currentIndex).damping = theValue;
  }
}
//A function that manages what happens when the program is stopped and started.
void StartStop() {

  stopStart = !stopStart;

  centralAction = stopStart;
  homogeneousAction = stopStart; 
  singleAction = stopStart; 
  doubleAction = stopStart;
  lisajousAction = stopStart;
  nBonaciAction = stopStart;
  strangeCirclesAction = stopStart;
  fourierTransformAction = stopStart;

  if (stopStart)
  {
    cp5.getController("StartStop").setCaptionLabel("Zatrzymanie programu");
  } else
  {
    cp5.getController("StartStop").setCaptionLabel("Uruchomienie programu");
    cp5.get("contextMenu").hide();
    cp5.get(Slider.class, "Gravity").setVisible(false);
    cp5.get(Slider.class, "Mass").setVisible(false);   
    cp5.get(Slider.class, "Radius").setVisible(false);
    cp5.get(Slider.class, "Springness").setVisible(false);
  }
}

void Start() {
  cp5.get(Button.class, "Start").hide();
  cp5.get(Button.class, "Settings").hide();
  cp5.get(Button.class, "Exit").hide();
  stopStart = !stopStart;
  startMenu = !startMenu;
}

void Settings() {
}

void Exit() {
  exit();
}


void Set() 
{
  setting();
}

void CentralButton(int n, boolean switches) 
{

  switch(n)
  {
  case 1:
    field = switches;

    break;
  case 2:

    pendul = switches;
    break;
  case 3:

    wholeScreen = switches;
    break;
  }

  mode  = n;
  setting();
}

void ButtonManagement()
{
  if (information)
  {
    textAlign(LEFT, BOTTOM);
    long DurationMillis = millis() - StartedMillis;
    text(formatMillis(DurationMillis), width - 136, 20);
    text( frameRate, width - 80, 40);
    cp5.get(Button.class, "Homogen").setVisible(true);
    cp5.get(Button.class, "Central").setVisible(true);
    cp5.get(Button.class, "Single").setVisible(true);
    cp5.get(Button.class, "Dual").setVisible(true);
    cp5.get(Button.class, "Lisajous").setVisible(true);
    cp5.get(Button.class, "Bonaci").setVisible(true);
    cp5.get(Button.class, "Circle").setVisible(true);
    cp5.get(Button.class, "FourTrans").setVisible(true);
  } else  if (information == false)
  {
    cp5.get(Button.class, "Homogen").setVisible(false);
    cp5.get(Button.class, "Central").setVisible(false);
    cp5.get(Button.class, "Single").setVisible(false);
    cp5.get(Button.class, "Dual").setVisible(false);
    cp5.get(Button.class, "Lisajous").setVisible(false);
    cp5.get(Button.class, "Bonaci").setVisible(false);
    cp5.get(Button.class, "Circle").setVisible(false);
    cp5.get(Button.class, "FourTrans").setVisible(false);
  }
}

void Disclosures_set(String name)
{
  pozYSet = cp5.getController(name).getPosition();
  cp5.getController("Set").setPosition(pozXSet, pozYSet[1]);
  cp5.getController("input").setPosition(pozXSet, pozYSet[1]+button_height);
  buttonName = name;  
  cp5.getController("Set").show();
  cp5.getController("input").show();
}

int inputChange(String theText) 
{
  Pattern numbers = Pattern.compile("[0-9]+");
  theText.replaceAll("^\\D+", "").split("\\D+");
  Matcher matcher = numbers.matcher(theText);
  int sum = 0;
  while (matcher.find()) {
    sum += Integer.parseInt(matcher.group());
  }

  return sum;
}

// automatically receives results from controller input
void input(String theText) {

  int amount = inputChange(theText);

  if (buttonName == "Homogen")
  {
    control2 = amount;
  } else if (buttonName.equals("Central"))
  {
    control2 = amount;
  } else if (buttonName.equals("Dual"))
  {
    ile2 = amount;
  } else if (buttonName.equals("Single"))
  {
    ile_pend = amount;
  } else if (buttonName.equals("Lisajous"))
  {
    table.w = amount;
  } else if (buttonName.equals(""))
  {
  }

  setting();
}
