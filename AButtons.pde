//reading input from buttons
void Homogen(int n) {

  CentralButton(n, true, false);
}

void Circle(int n) {

  CentralButton(n, true, false);
}

void Lisajous(int n) {

  wholeScreen = true;
  CentralButton(n, true, false);
}

void Bonaci(int n) {

  wholeScreen = false;
  CentralButton(n, true, false);
}

void Central(int n) {

  CentralButton(n, true, true);
}

void Single(int n) {

  CentralButton(n, false, true);
}

void Dual(int n) {

  CentralButton(n, false, false);
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
      //doublePend.get(currentIndex).radius1 = theValue;
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
    if (pendul)
    {
     // pend.get(currentIndex).mass = theValue;
    } else 
    {
      //doublePend.get(currentIndex).mass = theValue;
    }
  }
}

void Springness(float theValue)
{
  
  if (mode == 1)
  {
    cir.get(currentIndex).springness = theValue;
  } else if (mode == 2)
  {
    if (pendul)
    {
      pend.get(currentIndex).damping = theValue;
    } else 
    {
      //doublePend.get(currentIndex.springness = theValue;fieldName[0]
    }
  }
}

void StartStop() {

  stopStart = !stopStart;

  if (stopStart)
  {
    cp5.getController("StartStop").setCaptionLabel("Zatrzymanie programu");
    centralAction = true;
    homogeneousAction = true; 
    singleAction = true; 
    doubleAction = true;
    lisajousAction = true;
    nBonaciAction = true;
    strangeCirclesAction = true;
  } else
  {
    cp5.getController("StartStop").setCaptionLabel("Uruchomienie programu");
    centralAction = false;
    homogeneousAction = false; 
    singleAction = false; 
    doubleAction = false;
    lisajousAction = false;
    nBonaciAction = false;
    strangeCirclesAction = false;
 
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

void CentralButton(int n, boolean poleOrPendul, boolean i) 
{
  mode  = n;

  if (poleOrPendul) 
  {
    field = i;
  } else 
  {
    pendul = i;
  }

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
  } else  if (information == false)
  {
    cp5.get(Button.class, "Homogen").setVisible(false);
    cp5.get(Button.class, "Central").setVisible(false);
    cp5.get(Button.class, "Single").setVisible(false);
    cp5.get(Button.class, "Dual").setVisible(false);
    cp5.get(Button.class, "Lisajous").setVisible(false);
    cp5.get(Button.class, "Bonaci").setVisible(false);
    cp5.get(Button.class, "Circle").setVisible(false);


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
  }else if (buttonName.equals(""))
  {
   
  }

  setting();
}
