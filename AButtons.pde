void creatingButtons(int he)
{
  int hi = 1;

  //creating buttons
  Group menu = cp5.addGroup("contextMenu").disableCollapse().addCloseButton().setCaptionLabel("Informacje").hide();
  cp5.addSlider("Radius").setGroup(menu).setPosition(0, 0).setRange(5, 50);// position is relative to menu group
  cp5.addSlider("Mass").setGroup(menu).setPosition(0, 15).setRange(5, 50); 
  cp5.addSlider("Springness").setGroup(menu).setPosition(0, 30).setRange(0.01, 1);
  cp5.addSlider("Gravity").setGroup(menu).setPosition(0, 15).setRange(0.01, 1);


  cp5.addButton("Start").setPosition(centerX, centerY).setSize(200, 60).setCaptionLabel("Start");
  cp5.addButton("Settings").setPosition(centerX, centerY+ 60).setSize(200, 60).setCaptionLabel("Ustawienia");
  cp5.addButton("Exit").setPosition(centerX, centerY + 120).setSize(200, 60).setCaptionLabel("Wyjscie z programu");

  cp5.addButton("Save").setPosition(pozXSet, 63).setSize(65, button_height).setCaptionLabel("Zapis").hide();
  cp5.addButton("Load").setPosition(pozXSet, 63).setSize(65, button_height).setCaptionLabel("Odczyt").hide();
  cp5.addButton("Set").setPosition(pozXSet, 63).setSize(70, button_height).setCaptionLabel("Ustawienia").hide();

  cp5.addButton("Menu").setPosition(pozX, 1).setSize(button_width, button_height);
  cp5.addButton("Reset").setPosition(pozX, he * hi).setSize(button_width, button_height);
  hi++;
  cp5.addButton("StartStop").setPosition(pozX, he * hi).setSize(button_width, button_height).setCaptionLabel("Uruchomienie programu");

  hi++;
  cp5.addButton("Single").setPosition(pozX, he * hi).setSize(button_width, button_height).setCaptionLabel("Pojedyncze wahadło").hide().setValue(2);
  hi++;
  cp5.addButton("Dual").setPosition(pozX, he * hi).setSize(button_width, button_height).setCaptionLabel("Podwójne wahadło").hide().setValue(2);
  hi++;
  cp5.addButton("Homogen").setPosition(pozX, he * hi).setSize(button_width, button_height).setCaptionLabel(" Pole jednorodne").hide().setValue(1);
  hi++;
  cp5.addButton("Central").setPosition(pozX, he * hi).setSize(button_width, button_height).setCaptionLabel(" Pole centralne").hide().setValue(1);
  hi++;
  cp5.addButton("Lisajous").setPosition(pozX, he * hi).setSize(button_width, button_height).setCaptionLabel("Tablica Lisajous ").hide().setValue(3);
  hi++;
  cp5.addButton("Bonaci").setPosition(pozX, he * hi).setSize(button_width, button_height).setCaptionLabel("Sekwencja fibonacziego").hide().setValue(3); 
  hi++;
  cp5.addButton("Circle").setPosition(pozX, he * hi).setSize(button_width, button_height).setCaptionLabel("Wzory").hide().setValue(4);
  hi++;
  cp5.addButton("Npendul").setPosition(pozX, he * hi).setSize(button_width, button_height).setCaptionLabel("Wahadło n-tego stopnia").hide().setValue(4);
  hi++;
  cp5.addButton("FourTrans").setPosition(pozX, he * hi).setSize(button_width, button_height).setCaptionLabel("Transformata fouriera").hide().setValue(5);
  hi++;
  cp5.addTextfield("input").setPosition(20, 100).setSize(200, 40).setFont(font).setFocus(false).setCaptionLabel(" ").setColor(color(255, 0, 0)).hide();
}

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
void Npendul(int n) {

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
  resetToBegining();
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
      singlePend.get(currentIndex).radius = theValue;
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
    singlePend.get(currentIndex).gravity = theValue;
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
    singlePend.get(currentIndex).damping = theValue;
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
  nPendulumAction = stopStart;

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
  stopStart = true;
  startMenu = false;
}

void Settings() {
}

void Exit() {
  exit();
}


void Set() 
{
  resetToBegining();
}

void Save()
{  

  //JSONObject js = new JSONObject();
  ArrayList<JSONObject> jsonArray = new ArrayList<JSONObject>();
  JSONArray values = new JSONArray();
  String objectName = null;

  switch(mode) {
  case 1:
    for (int i = 0; i<cir.size(); i++)
    {
      cir.get(i).showingData();
      jsonArray.add(new JSONObject());
      jsonArray.get(i).setFloat("Id", i);
      jsonArray.get(i).setString("Name", "cir");

      for (Map.Entry<String, Float> me : cir.get(i).fieldVariables.entrySet()) {
        jsonArray.get(i).setFloat(me.getKey(), me.getValue());
      }
      values.setJSONObject(i, jsonArray.get(i));
    }
    objectName = "Cir";
    break;
  case 2:
    if (pendul)
    {
      for (int i = 0; i< singlePend.size(); i++)
      {
        singlePend.get(i).setingFieldVariables();
        jsonArray.add(new JSONObject());
        jsonArray.get(i).setFloat("Id", i);
        jsonArray.get(i).setString("Name", "singlePend");

        for (Map.Entry<String, Float> me : singlePend.get(i).fieldVariables.entrySet()) {
          jsonArray.get(i).setFloat(me.getKey(), me.getValue());
        }
        values.setJSONObject(i, jsonArray.get(i));
      }
      objectName = "SinglePend";
    } else 
    {
      for (int i = 0; i< doublePend.size(); i++)
      {
        doublePend.get(i).setingFieldVariables();
        jsonArray.add(new JSONObject());
        jsonArray.get(i).setFloat("Id", i);
        jsonArray.get(i).setString("Name", "doublePend");

        for (Map.Entry<String, Float> me : doublePend.get(i).fieldVariables.entrySet()) {
          jsonArray.get(i).setFloat(me.getKey(), me.getValue());
        }
        values.setJSONObject(i, jsonArray.get(i));
      }
      objectName = "DoublePend";
    }
    break;
  case 4:
    if (!cirOrNpendul)
    {
      for (int i = 0; i< nPend.size(); i++)
      {
        doublePend.get(i).setingFieldVariables();
        jsonArray.add(new JSONObject());
        jsonArray.get(i).setFloat("Id", i);
        jsonArray.get(i).setString("Name", "nPend");

        for (Map.Entry<String, Float> me : nPend.get(i).fieldVariables.entrySet()) {
          jsonArray.get(i).setFloat(me.getKey(), me.getValue());
        }
        values.setJSONObject(i, jsonArray.get(i));
      }
      objectName = "NPend";
    }

    break;
  }

  save.saves(values, objectName);
}

void Load()
{
  // Save();
  switch(mode) {
  case 1:

    if (field)
    { 
      selectInput("Select a file to load:", "loadOutput", dataFile("C:/Users/Rafał/Documents/Processing/Everything2D_3/saves/saveCir*.json"));
    } else 
    {
      selectInput("Select a file to load:", "loadOutput", dataFile("C:/Users/Rafał/Documents/Processing/Everything2D_3/saves/saveCir*.json"));
    }
    break;
  case 2:

    if (pendul)
    {
      selectInput("Select a file to load:", "loadOutput", dataFile("C:/Users/Rafał/Documents/Processing/Everything2D_3/saves/savePend*.json"));
    } else 
    {
      selectInput("Select a file to load:", "loadOutput", dataFile("C:/Users/Rafał/Documents/Processing/Everything2D_3/saves/saveDoublePend*.json"));
    }
    break;
  case 4:
    if (!cirOrNpendul)
    {
      selectInput("Select a file to load:", "loadOutput", dataFile("C:/Users/Rafał/Documents/Processing/Everything2D_3/saves/saveNPend*.json"));
    }

    break;
  }
}

void loadOutput(File selection)
{
  save.load(selection);
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
  case 4:
    cirOrNpendul = switches;
    break;
  }

  mode  = n;
  resetToBegining();
}

void ButtonManagement()
{
  if (information)
  {
    textAlign(LEFT, BOTTOM);
    long DurationMillis = millis() - startedMillis;
    text(formatMillis(DurationMillis), width - 136, 20);
    text( frameRate, width - 80, 40);
  }

  cp5.get(Button.class, "Homogen").setVisible(information);
  cp5.get(Button.class, "Central").setVisible(information);
  cp5.get(Button.class, "Single").setVisible(information);
  cp5.get(Button.class, "Dual").setVisible(information);
  cp5.get(Button.class, "Lisajous").setVisible(information);
  cp5.get(Button.class, "Bonaci").setVisible(information);
  cp5.get(Button.class, "Circle").setVisible(information);
  cp5.get(Button.class, "FourTrans").setVisible(information);
  cp5.get(Button.class, "Npendul").setVisible(information);
}

void Disclosures_set(String name)
{
  buttonName = name;
  pozYSet = cp5.getController(name).getPosition();
  cp5.getController("Set").setPosition(pozXSet, pozYSet[1]);
  cp5.getController("Load").setPosition(pozXSet + 70, pozYSet[1]);
  cp5.getController("Save").setPosition(pozXSet + 135, pozYSet[1]);
  cp5.getController("input").setPosition(pozXSet, pozYSet[1]+button_height);   
  cp5.getController("Set").show();
  cp5.getController("Load").show();
  cp5.getController("Save").show();
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

  if (theText != null || true)
  {
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
      table.size = amount;
    } else if (buttonName.equals("Npendul"))
    {
      numberOfNpendulum = amount;
    }

    resetToBegining();
  }
}
