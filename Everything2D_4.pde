import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.Random;
import java.util.List;
import java.util.Map;
import java.io.File;
import controlP5.*;

ControlP5 cp5;
Random randa = new Random();

int mode = 0;//1 - gravitation , 2 - pendulum, 3 - programs on whole screen, 4 - strenge circles, 5 - fourier transformation
boolean field = false;//true - central field , false - homogeneous field
boolean pendul = false;//true - single pendulum , false - double pendulum
boolean wholeScreen = false;// true - Lisajous table, false - nBonaci Sequence
boolean cirOrNpendul = false;//true - Circle, false - N-pendulum
boolean stopStart = false;//true - everything is working , false - everything is stoped
boolean startMenu = true;
boolean information = false, isMouseOver = false;
boolean centralAction = false, singleAction = false, nPendulumAction = false;
boolean doubleAction = false, nBonaciAction = false, homogeneousAction = false; 
boolean lisajousAction = false, strangeCirclesAction = false, fourierTransformAction = false;
boolean[] scrollMenuOpenByMouse = new boolean[6];
boolean[] changePositionByMouse = new boolean[6];
boolean[] contextMenuOpenByMouse = new boolean[6];
String buttonName;
PFont font, arialFont;
long startedMillis = 0;
float delta_time, now = System.nanoTime(), scrollMovement = 0, pozYSet[] = new float[2];
float angleChange_ = 0.01, w = 0.05, screenSizeY = 0, strCirRadius = 10, screenSizeX = 0;
int centerX = 0, centerY = 0, pozXSet = 108, howManySinglePend = 1,  currentIndex = 0, curIndex;
int doublePenIndex = 2, control = 50, numberOfNpendulum = 1, degreeOfPendulum = 5, strCirAmount = 1000;
int ilePendCopy = howManySinglePend, controlCopy = control, howManyDoublePen = 1, howManyDoublePenCopy = howManyDoublePen;

//Objects that occur individually
SaveGame save;
BonaciSequence seq;
LisajousTable table;
StrengeCircles strenCir;
FourierTransform fourier;
//Lists of objects
List<Circum> cir = new ArrayList<Circum>(control);
List<Pendulum> singlePend = new ArrayList<Pendulum>(howManySinglePend);
List<NPendulum> nPend = new ArrayList<NPendulum>(numberOfNpendulum);
List<DoublePendulum> doublePend = new ArrayList<DoublePendulum>(howManyDoublePen);
HashMap<String, Character> shortcutTable = new HashMap<String, Character>(12);

void settings() {
  size(1920, 1020, P2D);
  PJOGL.setIcon("icon5.png");
}

void setup() { 

  surface.setResizable(true);
  surface.setTitle("Projekt Rafała");
  stroke(255);
  background(255); 
  font = createFont("arial", 10);
  arialFont = createFont("arial", 20);
  centerX = (width/2) - 53;
  centerY = (height/2) - 15; 

  creatingShortcuts();

  creatingObjects();

  cp5 = new ControlP5(this);

  creatingButtons(arialFont, font);
}

void creatingObjects()
{

  //creating individual objects
  save = new SaveGame();
  seq = new BonaciSequence();
  table = new LisajousTable(); 
  fourier = new FourierTransform();
  strenCir = new StrengeCircles(strCirRadius, angleChange_, strCirAmount);

  //creating objects in lists
  creatingRandomCircles();
  creatingRandomPendulums();
  creatingRandomNPendulums();
  creatingRandomDoublePendulums();
}

void creatingShortcuts()
{
  shortcutTable.put("shortcutReset", 'R'); 
  shortcutTable.put("shortcutNpendulum", 'N'); 
  shortcutTable.put("shortcutCentralField", 'C');
  shortcutTable.put("shortcutHomogenField", 'H');
  shortcutTable.put("shortcutStopStartAll", 'Z');
  shortcutTable.put("shortcutLisajousTable", 'L');
  shortcutTable.put("shortcutBonaciSeqense", 'B');
  shortcutTable.put("shortcutSinglePendulum", 'P');
  shortcutTable.put("shortcutDoublePendulum", 'D');
  shortcutTable.put("shortcutStrangeCircles", 'S');
  shortcutTable.put("shortcutDisableEnableAll", 'X');
  shortcutTable.put("shortcutFourierTransform", 'F'); 

  File shortcut = dataFile("saves/shortcuts/shortcutFile1.json");

  if (!shortcut.exists())
  {
    JSONObject obj = new JSONObject();

    for (Map.Entry<String, Character> me : shortcutTable.entrySet()) 
    {
      String meStrVal = me.getValue().toString();
      obj.setString(me.getKey().toString(), meStrVal);
    }

    saveJSONObject(obj, "saves/shortcuts/shortcutFile1.json");
  }
}

void drawBorders() 
{
  strokeWeight(6);
  stroke(200, 0, 10);
  line(0, 0, width, 0);
  line(0, 0, 0, height);
  line(width, 0, width, height);  
  line(0, height, width, height); 
  strokeWeight(1);
}

//reading the time that has elapsed since the program started
String formatMillis(long millis)
{

  int milliseconds = floor(millis)%1000;
  int seconds = (int)((millis / 1000) % 60);
  long minutes = ((millis / 1000) / 60)% 60;
  long hour = ((millis / 1000) / 3600)% 60;
  return "" + nf(hour, 2, 0) + ":" + nf(minutes, 2, 0) + ":" + nf(seconds, 2, 0) + ":" + nf(milliseconds, 3, 0);
}

void resetToBegining() 
{
  switch(mode) {
  case 1: 

    cir.clear(); 
    creatingRandomCircles();

    if (field)
    {
      for (int i = 0; i <control; i++)
      {
        cir.get(i).radius *= 2;
        cir.get(i).velocity = new PVector(0.0000, 0.0000);
      }
    } else
    {
      for (int i = 0; i <control; i++)
      {
        cir.get(i).setSpeed(new PVector(0.0000, 0.0000));
      }
    }

    control = controlCopy;

    break;
  case 2:

    if (pendul)
    {
      singlePend.clear();  
      ilePendCopy = howManySinglePend;
      creatingRandomPendulums();
    } else
    {
      howManyDoublePen = howManyDoublePenCopy;
      doublePend.clear();  
      creatingRandomDoublePendulums();
    }
    break;
  case 3:

    if (wholeScreen)
    {
      table.reset(w);
    } else
    {
      seq.reset();
    }
    break;
  case 4:
    if (cirOrNpendul)
    {
      strenCir.reset();
    } else
    {
      nPend.clear();  
      creatingRandomNPendulums();
    }
    break; 
  case 5:
    fourier.reset();
    break;
  }

  startedMillis = millis();
}

void strangeCirclesManagement()
{
  pushMatrix();
  background(0);
  strokeWeight(5);
  translate(width / 2, height/2); 
  point(0, 0); 
  noFill();
  strokeWeight(2);
  circle(0, 0, 100);
  strenCir.strange();
  popMatrix();
}

void calculate_delta_time() {
  delta_time = (System.nanoTime()- now)/100000000;
  now = System.nanoTime();
}

void draw() {

  calculate_delta_time();
  background(120);
  drawBorders(); 

  switch(mode) {
  case 1: //1 - gravitation
    if (field)
    { 
      centralFieldManagement();
    } else 
    {
      homogeneousFieldManagement();
    }
    
    break;
  case 2: //2 - pendulum
    if (pendul)
    {
      singlePendulumManagement();
    } else 
    {
      dublePendulumManagement();
    }
    break;
  case 3: //3 - programs on whole screen
    background(0);

    if (wholeScreen)
    {
      noFill();
      table.show();
    } else
    {
      seq.drawing();
    }
    fill(200, 200, 200);
    break;
  case 4: // 4 - strenge circles
    if (cirOrNpendul)
    {
      strangeCirclesManagement();
    } else
    {
      nPendulManagement();
    }
    break; 
  case 5: // 5 - fourier transformation
    noFill();
    background(0); 
    fourier.show();
    break;
  }

  textSize(20);
  fill(10, 10, 10);

  if (mode == 3 || mode == 4|| mode == 5)
  { 
    fill(200, 200, 200);
  }

  if (!stopStart)
  {
    contextMenu(currentIndex);
    changePositionByTheMouse(currentIndex);
  }

  checkingIfMouseIsOver();
  ButtonManagement();
}
