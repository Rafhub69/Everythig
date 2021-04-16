void creatingButtons(PFont inputFont, PFont font_)
{
  int centerX = (width/2) - 53, centerY = (height/2) - 15;
  int factor = 1, pozX = 2, button_height = 30, button_width = 106; 

  //creating buttons
  Group menu = cp5.addGroup("contextMenu").disableCollapse().addCloseButton().setCaptionLabel("Informacje").hide();
  cp5.addSlider("Mass").setGroup(menu).setPosition(0, 15).setRange(5, 50); // position is relative to menu group
  cp5.addSlider("Radius").setGroup(menu).setPosition(0, 0).setRange(5, 50);
  cp5.addSlider("Gravity").setGroup(menu).setPosition(0, 15).setRange(0.01, 1);  
  cp5.addSlider("Springness").setGroup(menu).setPosition(0, 30).setRange(0.01, 1);


  cp5.addButton("Start").setPosition(centerX, centerY).setSize(200, 60).setCaptionLabel("Start");
  cp5.addButton("Settings").setPosition(centerX, centerY + 60).setSize(200, 60).setCaptionLabel("Ustawienia");
  cp5.addButton("Exit").setPosition(centerX, centerY + 120).setSize(200, 60).setCaptionLabel("Wyjscie z programu");

  cp5.addButton("Save").setPosition(pozXSet, 63).setSize(65, button_height).setCaptionLabel("Zapis").hide();
  cp5.addButton("Load").setPosition(pozXSet, 63).setSize(65, button_height).setCaptionLabel("Odczyt").hide();
  cp5.addButton("Set").setPosition(pozXSet, 63).setSize(70, button_height).setCaptionLabel("Ustawienia").hide();

  cp5.addButton("Menu").setPosition(pozX, 1).setSize(button_width, button_height).hide();
  cp5.addButton("Reset").setPosition(pozX, button_height * factor).setSize(button_width, button_height).hide();
  factor++;
  cp5.addButton("StartStop").setPosition(pozX, button_height * factor).setSize(button_width, button_height).setCaptionLabel("Uruchomienie programu").hide();
  factor++;
  cp5.addButton("Single").setPosition(pozX, button_height * factor).setSize(button_width, button_height).setCaptionLabel("Pojedyncze wahadło").hide().setValue(2);
  factor++;
  cp5.addButton("Dual").setPosition(pozX, button_height * factor).setSize(button_width, button_height).setCaptionLabel("Podwójne wahadło").hide().setValue(2);
  factor++;
  cp5.addButton("Homogen").setPosition(pozX, button_height * factor).setSize(button_width, button_height).setCaptionLabel("Pole jednorodne").hide().setValue(1);
  factor++;
  cp5.addButton("Central").setPosition(pozX, button_height * factor).setSize(button_width, button_height).setCaptionLabel("Pole centralne").hide().setValue(1);
  factor++;
  cp5.addButton("Lisajous").setPosition(pozX, button_height * factor).setSize(button_width, button_height).setCaptionLabel("Tablica lisajous").hide().setValue(3);
  factor++;
  cp5.addButton("Bonaci").setPosition(pozX, button_height * factor).setSize(button_width, button_height).setCaptionLabel("Sekwencja fibonacziego").hide().setValue(3); 
  factor++;
  cp5.addButton("Circle").setPosition(pozX, button_height * factor).setSize(button_width, button_height).setCaptionLabel("Wzory").hide().setValue(4);
  factor++;
  cp5.addButton("Npendul").setPosition(pozX, button_height * factor).setSize(button_width, button_height).setCaptionLabel("Wahadło n-tego stopnia").hide().setValue(4);
  cp5.addTextfield("degreesOfPendulum").setPosition(pozX + 308, button_height * factor + button_height).setSize(200, 40).setFont(font_).setFocus(false).hide()
    .setCaptionLabel("What degree of pendulum?").setColor(color(255, 0, 0)).align(pozX + 328, button_height * factor + button_height + 40, pozX + 328, button_height * factor + button_height);
  factor++;
  cp5.addButton("FourierTrans").setPosition(pozX, button_height * factor).setSize(button_width, button_height).setCaptionLabel("Transformata fouriera").hide().setValue(5);
  factor++;
  cp5.addTextfield("input").setPosition(20, 100).setSize(200, 40).setFont(inputFont).setFocus(false).setCaptionLabel(" ").setColor(color(255, 0, 0)).hide();
}

//reading input from buttons
void Settings() {
}

void Exit() 
{
  exit();
}

void Set() 
{
  resetToBegining();
}

void Homogen(int n) 
{
  CentralButton(n, false);
}

void Circle(int n) 
{
  CentralButton(n, true);
}

void Lisajous(int n) 
{
  CentralButton(n, true);
}

void Bonaci(int n) 
{
  CentralButton(n, false);
}

void Central(int n) 
{
  CentralButton(n, true);
}

void Single(int n) 
{
  CentralButton(n, true);
}

void Dual(int n) 
{
  CentralButton(n, false);
}

void Npendul(int n) 
{
  CentralButton(n, false);
}

void FourierTrans(int n) 
{
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
        doublePend.get(currentIndex).pendul0.radius = theValue;
      } else if (doublePenIndex == 1)
      {
        doublePend.get(currentIndex).pendul1.radius = theValue;
      }
    }
  } else if (mode == 4)
  {
    int index = nPend.get(currentIndex).index;

    nPend.get(currentIndex).singlePendulum.get(index).radius = theValue;
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
      doublePend.get(currentIndex).pendul0.mass = theValue;
    } else if (doublePenIndex == 1)
    {
      doublePend.get(currentIndex).pendul1.mass = theValue;
    }
  } else if (mode == 4)
  {
    int index = nPend.get(currentIndex).index;

    nPend.get(currentIndex).singlePendulum.get(index).radius = theValue;
  }
}

void Gravity(float theValue)
{
  if (pendul)
  {
    singlePend.get(currentIndex).gravity = theValue;
  } else 
  {
    doublePend.get(currentIndex).gravity = theValue;
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
  } else if (mode == 4)
  {
    nPend.get(currentIndex).gravity = theValue;
  }
}
//Function that manages what happens when the program is stopped and started.
void StartStop() 
{
  stopStart = !stopStart;

  singleAction = stopStart; 
  doubleAction = stopStart;
  centralAction = stopStart; 
  nBonaciAction = stopStart;
  lisajousAction = stopStart;
  nPendulumAction = stopStart;
  homogeneousAction = stopStart; 
  strangeCirclesAction = stopStart;
  fourierTransformAction = stopStart; 

  if (stopStart)
  {
    cp5.getController("StartStop").setCaptionLabel("Zatrzymanie programu");
  } else
  {
    cp5.get("contextMenu").hide();          
    cp5.get(Slider.class, "Mass").setVisible(false);   
    cp5.get(Slider.class, "Radius").setVisible(false);
    cp5.get(Slider.class, "Gravity").setVisible(false);
    cp5.get(Slider.class, "Springness").setVisible(false);
    cp5.getController("StartStop").setCaptionLabel("Uruchomienie programu");
  }
}

void Start() 
{
  cp5.get(Button.class, "Exit").hide();
  cp5.get(Button.class, "Start").hide();  
  cp5.get(Button.class, "Settings").hide();

  stopStart = true;
  startMenu = false;

  cp5.get(Button.class, "Menu").show();
  cp5.get(Button.class, "Reset").show();
  cp5.get(Button.class, "StartStop").show();
}

void Save()
{  
  String objectName = null;
  JSONArray values = new JSONArray();
  ArrayList<JSONObject> jsonArray = new ArrayList<JSONObject>();

  switch(mode) {
  case 1:
    for (int i = 0; i < cir.size(); i++)
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
      for (int i = 0; i < singlePend.size(); i++)
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
      for (int i = 0; i < doublePend.size(); i++)
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
      for (int i = 0; i < nPend.size(); i++)
      {
        nPend.get(i).setingFieldVariables();
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
    selectInput("Select a file to load:", "loadOutput", dataFile("C:/Users/Rafał/Documents/Processing/Everything2D_3/saves/saveCir*.json"));    
    break;
  case 2:

    if (pendul)
    {
      selectInput("Select a file to load:", "loadOutput", dataFile("C:/Users/Rafał/Documents/Processing/Everything2D_3/saves/saveSinglePend*.json"));
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

  mode = n;
  resetToBegining();
}

void ButtonManagement()
{
  
  if (information)
  {
    fill(255);
    textAlign(LEFT, BOTTOM);
    text(frameRate, width - 80, 50);
    long DurationMillis = millis() - startedMillis;
    text(formatMillis(DurationMillis), width - 130, 30);
  }

  cp5.get(Button.class, "Dual").setVisible(information);
  cp5.get(Button.class, "Bonaci").setVisible(information);
  cp5.get(Button.class, "Circle").setVisible(information);
  cp5.get(Button.class, "Single").setVisible(information);
  cp5.get(Button.class, "Homogen").setVisible(information);
  cp5.get(Button.class, "Central").setVisible(information);
  cp5.get(Button.class, "Npendul").setVisible(information);
  cp5.get(Button.class, "Lisajous").setVisible(information);
  cp5.get(Button.class, "FourierTrans").setVisible(information);
}

void Disclosures_set(String name)
{
  buttonName = name;
  pozYSet = cp5.getController(name).getPosition();
  cp5.getController("Set").setPosition(pozXSet, pozYSet[1]);
  cp5.getController("Load").setPosition(pozXSet + 70, pozYSet[1]);
  cp5.getController("Save").setPosition(pozXSet + 135, pozYSet[1]);
  cp5.getController("input").setPosition(pozXSet, pozYSet[1] + 30);  

  cp5.getController("Set").show();
  cp5.getController("Load").show();
  cp5.getController("Save").show();
  cp5.getController("input").show();

  if (buttonName.equals("Npendul"))
  {
    cp5.getController("degreesOfPendulum").show();
  } else
  {
    cp5.getController("degreesOfPendulum").hide();
  }
}

int inputChange(String input) 
{
  Pattern numbers = Pattern.compile("[0-9]+");
  input.replaceAll("^\\D+", "").split("\\D+");
  Matcher matcher = numbers.matcher(input);
  int sum = 0;
  while (matcher.find()) {
    sum += Integer.parseInt(matcher.group());
  }

  return sum;
}

// automatically receives results from controller input
void input(String theText) 
{
  if (theText != null)
  {
    int amount = inputChange(theText);

    if (buttonName.equals("Homogen"))
    {
      controlCopy = amount;
    } else if (buttonName.equals("Central"))
    {
      controlCopy = amount;
    } else if (buttonName.equals("Dual"))
    {
      howManyDoublePen = amount;
    } else if (buttonName.equals("Single"))
    {
      howManySinglePend = amount;
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

void degreesOfPendulum(String degree) 
{
  if (degree != null)
  {
    degreeOfPendulum = inputChange(degree);

    resetToBegining();
  }
}
