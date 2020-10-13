import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.Random;
import controlP5.*;

Random randa = new Random();
ControlP5 cp5;


int mode = 1;//1 - gravitation , 2 - pendulum, 3 - programs on whole screen
boolean field = false;//true -  central field , false -  homogeneous field
boolean pendul = false;//true - single pendulum , false - double pendulum
boolean wholeScreen = false;// true - Lisajous table, false - nBonaci Sequence
boolean information = false;
boolean startMenu = true;
boolean stopStart = false;//true - everything is working , false - everything is stoped
boolean isMouseOver = false;
boolean centralAction = false, homogeneousAction = false, singleAction = false, doubleAction = false, lisajousAction = false, nBonaciAction = false, strangeCirclesAction = false;
boolean[] scrollMenuOpenByMouse = new boolean[5];
boolean[] changePositionByMouse = new boolean[5];
boolean[] contextMenuOpenByMouse = new boolean[5];
long StartedMillis = 0;
String buttonName;
char shortcutCentralField = 'V', shortcutHomogenField = 'F', shortcutSinglePendulum = 'P', shortcutDoublePendulum = 'D', shortcutLisajousTable = 'L', shortcutBonaciSeqense = 'N', shortcutStrangeCircles = 'C', shortcutFourierTransform = 'T';
int control = 100, current, control2 = control, i, control3 = control2+1, ile = 1, ile2 = ile, ile_pend =1, ile_pend2 = ile_pend, pozX =2, pozY;
int centerX = 0, centerY = 0, button_height =30, button_width = 106, he = button_height, hi = 1, pozXSet = pozX + button_width;
int MaxFar = 100, Multi = 10, start;
float mass = 1000, radius = 20, density, G_const = 0.6673, a1 = 4*PI, w = 0.01, scrollMovement = 0;
float length1, length2, mas1, mas2, a2, poz, rad = 10, angleChange_ = 0.01;
float pozYSet[] = new float[2], screenSizeX = 0, screenSizeY = 0;
LisajousTable table;
BonaciSequence seq;
StrengeCircles stren;
//Object obj;

ArrayList<Circum> cir = new ArrayList<Circum>(control);
ArrayList<pendulum> pend = new ArrayList<pendulum>(ile_pend);
ArrayList<double_pendulum> doublePend = new ArrayList<double_pendulum>(ile);
PVector  inic = new PVector(0.0000, 0.0000);
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
  //creating individual objects
  table = new LisajousTable();
  seq = new BonaciSequence();
  stren = new StrengeCircles( rad, angleChange_, amo);


  //creating random circles
  for (int i = 0; i <control; i++)
  {
    mass = 20 * randa.nextFloat() + 4;
    radius = mass * 2;

    cir.add(new Circum(0, 0, radius, mass));
    cir.get(i).velocity = new PVector(0, 0);
    cir.get(i).acceleration = new PVector(0, 0);
    cir.get(i).gre = new PVector(0, 0);
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
    doublePend.add(new double_pendulum( a1, a2, length1, length2, mas1, mas2));
  }

  //creating a random pendulum
  a1 = PI / (randa.nextFloat() + 0.5);
  pend.add(new pendulum(a1, new PVector(width / 2, height/3)));

  for (int i = 1; i <ile_pend; i++)
  {
    a1 = PI / (randa.nextFloat() + 0.5);
    pend.add(new pendulum(a1, pend.get(i - 1).position));
  }

  cp5 = new ControlP5(this);

  //creating buttons
  Group menu = cp5.addGroup("contextMenu").disableCollapse().addCloseButton().setCaptionLabel("Informacje").hide();
  cp5.addSlider("Radius").setGroup(menu).setPosition(0, 0).setRange(5, 50);// position is relative to menu group
  cp5.addSlider("Mass").setGroup(menu).setPosition(0, 15).setRange(5, 50); 
  cp5.addSlider("Springness").setGroup(menu).setPosition(0, 30).setRange(0.01, 1);
  cp5.addSlider("Gravity").setGroup(menu).setPosition(0, 15).setRange(0.01, 1);

  cp5.addButton("Menu").setPosition(pozX, 1).setSize(button_width, button_height);  
  cp5.addButton("Start").setPosition(centerX, centerY).setSize(200, 60).setCaptionLabel("Start");
  cp5.addButton("Settings").setPosition(centerX, centerY+ 60).setSize(200, 60).setCaptionLabel("Ustawienia");
  cp5.addButton("Exit").setPosition(centerX, centerY + 120).setSize(200, 60).setCaptionLabel("Wyjscie z programu");
  cp5.addButton("Save").setPosition(pozXSet, 63).setSize(button_width, button_height).setCaptionLabel("Zapis").hide();
  cp5.addButton("Load").setPosition(pozXSet, 63).setSize(button_width, button_height).setCaptionLabel("Odczyt").hide();
  cp5.addButton("Set").setPosition(pozXSet, 63).setSize(button_width, button_height).setCaptionLabel("Ustawienia").hide();

  cp5.addButton("Reset").setPosition(pozX, he * hi).setSize(button_width, button_height);
  hi++;
  cp5.addButton("StartStop").setPosition(pozX, he * hi).setSize(button_width, button_height).setCaptionLabel("Uruchomienie programu");
  hi++;
  cp5.addButton("Single").setPosition(pozX, he * hi).setSize(button_width, button_height).setCaptionLabel("Pojedyncze wahadło").setVisible(false).setValue(2);
  hi++;
  cp5.addButton("Dual").setPosition(pozX, he * hi).setSize(button_width, button_height).setCaptionLabel("Podwójne wahadło").setVisible(false).setValue(2);
  hi++;
  cp5.addButton("Homogen").setPosition(pozX, he * hi).setSize(button_width, button_height).setCaptionLabel(" Pole jednorodne").setVisible(false).setValue(1);
  hi++;
  cp5.addButton("Central").setPosition(pozX, he * hi).setSize(button_width, button_height).setCaptionLabel(" Pole centralne").setVisible(false).setValue(1);
  hi++;
  cp5.addButton("Lisajous").setPosition(pozX, he * hi).setSize(button_width, button_height).setCaptionLabel("Tablica Lisajous ").setVisible(false).setValue(3);
  hi++;
  cp5.addButton("Bonaci").setPosition(pozX, he * hi).setSize(button_width, button_height).setCaptionLabel("Sekwencja fibonacziego").setVisible(false).setValue(3); 
  hi++;
  cp5.addButton("Circle").setPosition(pozX, he * hi).setSize(button_width, button_height).setCaptionLabel("Wzory").setVisible(false).setValue(4);
  hi++;
  cp5.addTextfield("input").setPosition(20, 100).setSize(200, 40).setFont(font).setFocus(false).setCaptionLabel(" ").setColor(color(255, 0, 0)).setVisible(false);
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

void setting() 
{

  if (mode == 1)
  {
    float pozX = 0, pozY = 0;

    for (int i = control - 1; i >= 0; i--)
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
        cir.get(i).velocity = new PVector(0, 0);
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

        cir.add(new Circum( pozX, pozY, radius, mass));
        cir.get(i).setSpeed(inic);
      }
      control = control2;
    }
  } else if (mode == 2)
  {
    if (pendul == true)
    {

      for (int i = ile_pend2 - 1; i >= 0; i--)
      {
        pend.remove(i);
      }

      a1 = PI  / (4 * randa.nextFloat() + 1);

      ile_pend2 = ile_pend;

      a1 = PI / (randa.nextFloat() + 0.5);
      pend.add(new pendulum(a1, new PVector(width / 2, height/3)));

      for (int i = 1; i <ile_pend; i++)
      {
        a1 = PI / (randa.nextFloat() + 0.5);
        pend.add(new pendulum(a1, pend.get(i - 1).position));
      }
    } else if (pendul == false)
    {
      for (int i = ile - 1; i >= 0; i--)
      {
        doublePend.remove(i);
      }

      for (int i = 0; i< ile2; i++)
      {
        doublePend.add(new double_pendulum(PI / (randa.nextFloat() + 1), PI / (randa.nextFloat() + 3), 400, 250, 40, 20));
        doublePend.get(i).set0();
      }

      ile = ile2;
    }
  } else if (mode == 3)
  {   
    if (wholeScreen)
    {
      table.reset(w);
    } else
    {
      seq.reset();
    }
  } else if (mode == 4)
  {
    stren.reset();
  } else if (mode == 5)
  {
  }
  StartedMillis = millis();
}

void draw() {

  background(120);
  drawBorders();

  if (mode == 1)
  {
    if (field)
    { 
      centralField();
    } else 
    {
      homogeneousField();
    }
  } else if (mode == 2)
  {
    if (pendul)
    {
      singlePendulum();
    } else 
    {
      dublePendulum();
    }
  } else if (mode == 3)
  { 
    background(0);

    if (wholeScreen)
    {
      noFill();
      table.show();
    } else
    {
      seq.drawing();
    }
  } else if (mode == 4)
  { 
    pushMatrix();
    translate(width / 2, height/2);
    background(0);
    strokeWeight(5);
    point(0, 0);
    strokeWeight(2);
    noFill();
    circle(0, 0, 100);
    stren.strangeCircle();
    popMatrix();
  } else if (mode == 5)
  {
    background(0);
    noFill();
  }

  textSize(20);
  fill(10, 10, 10);

  if (mode == 3 || mode == 4)
  { 
    fill(200, 200, 200);
  }

  if (!stopStart)
  {
    changePositionByTheMouse(currentIndex);
    changeVelocityByTheMouse(currentIndex);
    contextMenu(currentIndex);
  }

  checkingIfMouseIsOver();
  ButtonManagement();
}
