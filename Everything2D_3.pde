import java.util.regex.Matcher;
import java.util.regex.Pattern;
import processing.sound.*;
import java.util.Random;
import java.util.Map;
import java.io.File;
import controlP5.*;

Random randa = new Random();
ControlP5 cp5;

int mode = 1;//1 - gravitation , 2 - pendulum, 3 - programs on whole screen, 4 - strenge circles, 5 - fourier transformation
boolean field = false;//true -  central field , false -  homogeneous field
boolean pendul = false;//true - single pendulum , false - double pendulum
boolean wholeScreen = false;// true - Lisajous table, false - nBonaci Sequence
boolean cirOrNpendul = false;//true - Circle, false - N-pendulum
boolean information = false;
boolean startMenu = true;
boolean stopStart = true;//true - everything is working , false - everything is stoped
boolean isMouseOver = false;
boolean centralAction = false, homogeneousAction = false, singleAction = false, doubleAction = false, lisajousAction = false, nBonaciAction = false, strangeCirclesAction = false, fourierTransformAction = false, nPendulumAction = false;
boolean[] scrollMenuOpenByMouse = new boolean[6];
boolean[] changePositionByMouse = new boolean[6];
boolean[] contextMenuOpenByMouse = new boolean[6];
long startedMillis = 0;
String buttonName;
HashMap<String, Character> shortcutTable = new HashMap<String, Character>(12);
int control = 100, current, control2 = control, i, control3 = control2+1, ile = 1, ile2 = ile, ile_pend =1, ile_pend2 = ile_pend, pozX =2, pozY, doublePenIndex = 2;
int MaxFar = 100, Multi = 10, start, centerX = 0, centerY = 0, button_height =30, button_width = 106, pozXSet = pozX + button_width, numberOfNpendulum = 1;
float mass = 1000, radius = 20, density, G_const = 0.6673, a1 = 4*PI, w = 0.05;
float length1, length2, mas1, mas2, a2, poz, rad = 10, angleChange_ = 0.01;
float pozYSet[] = new float[2], screenSizeX = 0, screenSizeY = 0;
float delta_time, now = System.nanoTime(), scrollMovement = 0;
FourierTransform fourier;
StrengeCircles strenCir;
LisajousTable table;
BonaciSequence seq;
Everything2D_3 yh;
SaveGame save;
//Object obj;
ArrayList<Circum> cir = new ArrayList<Circum>(control);
ArrayList<Pendulum> singlePend = new ArrayList<Pendulum>(ile_pend);
ArrayList<NPendulum> nPend = new ArrayList<NPendulum>(numberOfNpendulum);
ArrayList<DoublePendulum> doublePend = new ArrayList<DoublePendulum>(ile);
int amo = 1000, currentIndex = 0;
PFont font;

void settings() {
  size(1920, 1020, P2D);
  PJOGL.setIcon("icon5.png");
}


void setup() {  

  surface.setResizable(true);
  surface.setTitle("Fizyka");
  stroke(255);
  background(255);
  font = createFont("arial", 20);
  centerX = (width/2)  - (button_width/2);
  centerY = (height/2)  - (button_height/2); 

  creatingShortcuts();

  creatingObjects();

  cp5 = new ControlP5(this);

  creatingButtons(button_height);
}

void creatingObjects()
{

  //creating individual objects
  table = new LisajousTable();
  seq = new BonaciSequence();
  strenCir = new StrengeCircles( rad, angleChange_, amo);
  fourier = new FourierTransform(new Everything2D_3());
  save = new SaveGame();

  //creating a random npendulum
  for (int i= 0; i <numberOfNpendulum; i++)
  {
    nPend.add(new NPendulum(5));
  }


  //creating random circles
  for (int i = 0; i <control; i++)
  {
    mass = 20 * randa.nextFloat() + 4;
    radius = mass * 2;
    cir.add(new Circum(0, 0, radius, mass));
  }

  //creating a random double pendulum
  for (int i = 0; i< ile; i++)
  {
    a1 = PI / (randa.nextFloat() + 1);
    a2 = PI / (randa.nextFloat() + 3);
    length1 = 350;
    length2 = 200;
    mas1 = 40;
    mas2 = 20;
    doublePend.add(new DoublePendulum( a1, a2, length1, length2, mas1, mas2));
  }

  //creating a random pendulum
  a1 = PI / (randa.nextFloat() + 0.5);
  singlePend.add(new Pendulum(a1, new PVector(width / 2, height/3)));

  for (int i = 1; i <ile_pend; i++)
  {
    a1 = PI / (randa.nextFloat() + 0.5);
    singlePend.add(new Pendulum(a1, singlePend.get(i - 1).position));
  }
}

void creatingShortcuts()
{
  shortcutTable.put("shortcutReset", 'R'); 
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
  shortcutTable.put("shortcutNpendulum", 'N'); 

  File shortcut = dataFile("saves/shortcuts/shortcutFile1.json");

  if (!shortcut.exists())
  {
    JSONObject obj = new JSONObject();

    for (Map.Entry<String, Character> me : shortcutTable.entrySet()) {
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
  line(0, height, width, height);
  line(0, 0, width, 0);
  line(0, 0, 0, height);
  line(width, 0, width, height);
  strokeWeight(1);
}

//reading the time that has elapsed since the program started
String formatMillis(long millis)
{

  int milliseconds = floor(millis)%1000;
  int seconds = (int)((millis / 1000) % 60);
  long minutes = ((millis / 1000) / 60)% 60;
  long hour = ((millis / 1000) / 3600)% 60;
  return "" + nf(hour, 2, 0) + ":"  + nf(minutes, 2, 0) + ":" + nf(seconds, 2, 0) + ":" + nf(milliseconds, 3, 0);
}

void resetToBegining() 
{
  switch(mode) {
  case 1:
    float pozX = 0, pozY = 0;
    int size = cir.size();
    for (int i = size - 1; i >= 0; i--)
    {
      cir.remove(i);
    }

    if ( field == true)
    {

      for (int i = 0; i <control2; i++)
      {
        mass = 8 * randa.nextFloat() + 4;
        radius = mass  * 4;
        pozX = width * new Random().nextFloat();
        pozY = height * new Random().nextFloat();
        float border= 10;

        //Checking whether circles are overlapping or outside the screen boundary.
        if (i!=0)
        {
          for (int j = 0; j <i; j++)
          {       
            while (PVector.sub(new PVector(pozX, pozY), cir.get(j).point).mag() <= cir.get(j).radius + radius + border || pozY - radius <= border || pozY + radius >= height - border || pozX - radius <= border || pozX + radius >= width - border) {
              pozX = (width * new Random().nextFloat());
              pozY = (height * new Random().nextFloat());
            }
          }
        }

        cir.add(new Circum(pozX, pozY, radius, mass));
        cir.get(i).velocity = new PVector(0.0000, 0.0000);
      }
      control = control2;
    } else if ( field == false)
    {

      for (int i = 0; i<control2; i++)
      {
        mass = 8 * randa.nextFloat() + 4;
        radius = mass  * 2;
        pozX = (width * new Random().nextFloat()) - radius;
        pozY =  (height * new Random().nextFloat()) - radius;
        float border= 10;

        //Checking whether circles are overlapping or outside the screen boundary.
        if (i!=0)
        {
          for (int j = 0; j <i; j++)
          {       
            while (PVector.sub(new PVector(pozX, pozY), cir.get(j).point).mag() <= cir.get(j).radius + radius + border || pozY - radius <= border || pozY + radius >= height - border || pozX - radius <= border || pozX + radius >= width - border) {
              pozX = (width * new Random().nextFloat());
              pozY = (height * new Random().nextFloat());
            }
          }
        }

        cir.add(new Circum( pozX, pozY, radius, mass));
        cir.get(i).setSpeed(new PVector(0.0000, 0.0000));
      }
      control = control2;
    }

    break;
  case 2:

    if (pendul == true)
    {
      size = singlePend.size();
      for (int i = size - 1; i >= 0; i--)
      {
        singlePend.remove(i);
      }

      a1 = PI  / (4 * randa.nextFloat() + 1);

      ile_pend2 = ile_pend;

      a1 = PI / (randa.nextFloat() + 0.5);
      singlePend.add(new Pendulum(a1, new PVector(width / 2, height/3)));

      for (int i = 1; i <ile_pend; i++)
      {
        a1 = PI / (randa.nextFloat() + 0.5);
        singlePend.add(new Pendulum(a1, singlePend.get(i - 1).position));
      }
    } else if (pendul == false)
    {
      size = doublePend.size();
      for (int i = size - 1; i >= 0; i--)
      {
        doublePend.remove(i);
      }

      for (int i = 0; i< ile2; i++)
      {
        doublePend.add(new DoublePendulum(PI / (randa.nextFloat() + 1), PI / (randa.nextFloat() + 3), 400, 250, 40, 20));
        doublePend.get(i).set0();
      }

      ile = ile2;
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
       size = nPend.size();
       
      for (int i = size - 1; i >= 0; i--)
      {
        nPend.remove(i);
      }
      
      for (int i= 0; i <numberOfNpendulum; i++)
      {
        nPend.add(new NPendulum(5));
      }
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
  translate(width / 2, height/2);
  background(0);
  strokeWeight(5);
  point(0, 0);
  strokeWeight(2);
  noFill();
  circle(0, 0, 100);
  strenCir.strange();
  popMatrix();
}

void calc_delta_time() {
  delta_time = (System.nanoTime()-now)/100000000;
  now = System.nanoTime();
}

void draw() {

  calc_delta_time();
  background(120);
  drawBorders();

  switch(mode) {
  case 1:

    if (field)
    { 
      centralFieldManagement();
    } else 
    {
      homogeneousFieldManagement();
    }
    break;
  case 2:

    if (pendul)
    {
      singlePendulumManagement();
    } else 
    {
      dublePendulumManagement();
    }
    break;
  case 3:

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
  case 4:
    if (cirOrNpendul)
    {
      strangeCirclesManagement();
    } else
    {
      nPendulManagement();
    }
    break;    
  case 5:

    background(0);
    noFill();
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
    changePositionByTheMouse(currentIndex);
    // changeVelocityByTheMouse(currentIndex);
    contextMenu(currentIndex);
  }

  checkingIfMouseIsOver();
  ButtonManagement();
}
