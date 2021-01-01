void mouseWheel(MouseEvent event) {
  start = millis();
  scrollMovement = constrain(event.getCount()*Multi + scrollMovement, -MaxFar, MaxFar);
}

void mousePressed() {

  if (!stopStart)
  {
    switch(mode) {
    case 1:
      if (field)
      { 
        for (int i = 0; i<cir.size(); i++)
        {
          float d = dist(mouseX, mouseY, cir.get(i).point.x, cir.get(i).point.y);
          if (d <= cir.get(i).radius ) 
          {
            currentIndex = i;
            if (mouseButton == LEFT)
            {
              changePositionByMouse[0] = true;
            } else if (mouseButton == RIGHT)
            {
              contextMenuOpenByMouse[0] = true;
            } else if (mouseButton == CENTER)
            {
              scrollMenuOpenByMouse[0] = true;
            }
          }
        }
      } else 
      {
        for (int j = 0; j<cir.size(); j++)
        {
          float d = dist(mouseX, mouseY, cir.get(j).point.x, cir.get(j).point.y);
          if (d <= cir.get(j).radius) 
          {
            currentIndex = j;
            if (mouseButton == LEFT)
            {
              changePositionByMouse[1] = true;
            } else if (mouseButton == RIGHT)
            {
              contextMenuOpenByMouse[1] = true;
            } else if (mouseButton == CENTER)
            {
              scrollMenuOpenByMouse[1] = true;
            }
          }
        }
      }
      break;
    case 2:
      if (pendul)
      {
        for (int k = 0; k< singlePend.size(); k++)
        {
          float d = dist(mouseX, mouseY, singlePend.get(k).position.x, singlePend.get(k).position.y);

          if (d <= cir.get(k).radius) 
          {
            currentIndex = k;

            if (mouseButton == LEFT)
            {
              changePositionByMouse[2] = true;
            } else if (mouseButton == RIGHT)
            {
              contextMenuOpenByMouse[2] = true;
            } else if (mouseButton == CENTER)
            {
              scrollMenuOpenByMouse[2] = true;
            }
          }
        }
      } else 
      {
        for (int l = 0; l< doublePend.size(); l++)
        {
          float d1 = dist(mouseX, mouseY, doublePend.get(l).position[0].x, doublePend.get(l).position[0].y);
          float d2 = dist(mouseX, mouseY, doublePend.get(l).position[1].x, doublePend.get(l).position[1].y);

          if (d1 <= doublePend.get(l).radius1) 
          {
            currentIndex = l;

            if (mouseButton == LEFT)
            {
              changePositionByMouse[3] = true;
            } else if (mouseButton == RIGHT)
            {
              contextMenuOpenByMouse[3] = true;
            } else if (mouseButton == CENTER)
            {
              scrollMenuOpenByMouse[3] = true;
            }
          } else if (d2 <= doublePend.get(l).radius2) 
          {
            currentIndex = l;

            if (mouseButton == LEFT)
            {
              changePositionByMouse[4] = true;
            } else if (mouseButton == RIGHT)
            {
              contextMenuOpenByMouse[4] = true;
            } else if (mouseButton == CENTER)
            {
              scrollMenuOpenByMouse[4] = true;
            }
          }
        }
      }
      break;
    case 4:
      break; 
    case 5:
      fourier.mousePress();
      break;
    }
  }
}

void mouseReleased() {
  if (!stopStart)
  {
    switch(mode) {
    case 1:
      if (field)
      { 
        if (changePositionByMouse[0]) {
          changePositionByMouse[0] = false;
        }

        if (contextMenuOpenByMouse[0]) {
          contextMenuOpenByMouse[0] = false;
        }
        if (scrollMenuOpenByMouse[0]) {
          scrollMenuOpenByMouse[0] = false;
        }
      } else 
      {
        if (changePositionByMouse[1]) {
          changePositionByMouse[1] = false;
        }
        if (contextMenuOpenByMouse[1]) {
          contextMenuOpenByMouse[1] = false;
        }
        if (scrollMenuOpenByMouse[1]) {
          scrollMenuOpenByMouse[1] = false;
        }
      }
      break;
    case 2:
      if (pendul)
      {
        if (changePositionByMouse[2]) {
          changePositionByMouse[2] = false;
        }
        if (contextMenuOpenByMouse[2]) {
          contextMenuOpenByMouse[2] = false;
        }
        if (scrollMenuOpenByMouse[2]) {
          scrollMenuOpenByMouse[2] = false;
        }
      } else 
      {
        if (changePositionByMouse[3]) {
          changePositionByMouse[3] = false;
        } else if (changePositionByMouse[4]) {
          changePositionByMouse[4] = false;
        }

        if (contextMenuOpenByMouse[3]) {
          contextMenuOpenByMouse[3] = false;
        } else if (contextMenuOpenByMouse[4]) {
          contextMenuOpenByMouse[4] = false;
        }

        if (scrollMenuOpenByMouse[3]) {
          scrollMenuOpenByMouse[3] = false;
        } else if (scrollMenuOpenByMouse[4]) {
          scrollMenuOpenByMouse[4] = false;
        }
      }

      break;
    case 4:
      break; 
    case 5:
      fourier.mouseRelis();
      break;
    }
  }
}

void keyPressed() 
{
  //reading keyboard shortcuts
  if (keyCode == 27)
  {
    key = 0;

    startMenu = true;
    stopStart = false;
  } else if ((key >= 'A' && key <= 'Z') || (key >= 'a' && key <= 'z')) 
  {

    if (key == 'M' ||key == 'm')
    { 
      information = !information; //menu
    } else if (key == (shortcutTable.get("shortcutHomogenField") + 32) ||key == shortcutTable.get("shortcutHomogenField"))
    {  
      mode = 1;
      field = false; // f - homogeneous field 
      resetToBegining();
    } else if (key == (shortcutTable.get("shortcutCentralField") + 32) ||key == shortcutTable.get("shortcutCentralField"))
    {
      mode = 1;
      field = true; //v - central field
      resetToBegining();
    } else if (key == (shortcutTable.get("shortcutSinglePendulum") + 32) ||key ==  shortcutTable.get("shortcutSinglePendulum"))
    {
      mode = 2;
      pendul = true; //p - single pendulum
      resetToBegining();
    } else if (key == (shortcutTable.get("shortcutDoublePendulum") + 32) ||key == shortcutTable.get("shortcutDoublePendulum"))
    {
      mode = 2;
      pendul = false; //d - double pendulum
      resetToBegining();
    } else if (key == (shortcutTable.get("shortcutLisajousTable") + 32) ||key == shortcutTable.get("shortcutLisajousTable"))
    {
      mode = 3;
      wholeScreen = true;
      resetToBegining();
    } else if (key == (shortcutTable.get("shortcutBonaciSeqense") + 32) ||key == shortcutTable.get("shortcutBonaciSeqense"))
    {
      mode = 3;
      wholeScreen = false;
      resetToBegining();
    } else if (key == (shortcutTable.get("shortcutStrangeCircles") + 32) ||key == shortcutTable.get("shortcutStrangeCircles"))
    {
      mode = 4;//strange circles
      cirOrNpendul = true;
      resetToBegining();
    } else if (key == (shortcutTable.get("shortcutNpendulum") + 32) ||key == shortcutTable.get("shortcutNpendulum"))
    {
      mode = 4;//nth pendulum
      cirOrNpendul = false;
      resetToBegining();
    } else if (key == (shortcutTable.get("shortcutFourierTransform") + 32) ||key == shortcutTable.get("shortcutFourierTransform"))
    {
      mode = 5;//t - fourier transformation
      resetToBegining();
    } else if (key == (shortcutTable.get("shortcutReset") + 32) ||key == shortcutTable.get("shortcutReset"))
    {//reset
      background(255);
      resetToBegining();
    } else if (key == (shortcutTable.get("shortcutDisableEnableAll") + 32) ||key == shortcutTable.get("shortcutDisableEnableAll"))
    {//Disable/Enable menu and all buttons
      cp5.get(Button.class, "Menu").setVisible(!cp5.get(Button.class, "Menu").isVisible());
      cp5.get(Button.class, "Reset").setVisible(!cp5.get(Button.class, "Reset").isVisible());
      cp5.get(Button.class, "StartStop").setVisible(!cp5.get(Button.class, "StartStop").isVisible());
      if (information)
      {
        information = !information;
      }
    } else if (key == (shortcutTable.get("shortcutStopStartAll") + 32) ||key == shortcutTable.get("shortcutStopStartAll"))
    {//stopping and starting the program
      StartStop();
    } else  if (key == 'K' ||key == 'k')
    {
      if (!information)
      {
        information = !information;
      }  

      if (mode == 1 & field == true)
      {
        pozYSet = cp5.getController("Central").getPosition();
      } else if (mode == 1 & field == false)
      {
        pozYSet = cp5.getController("Homogen").getPosition();
      } else if (mode == 2 & pendul == true)
      {
        pozYSet = cp5.getController("Single").getPosition();
      } else if (mode == 2 & pendul == false)
      {
        pozYSet = cp5.getController("Dual").getPosition();
      } else if (mode == 3 & wholeScreen == true)
      {
        pozYSet = cp5.getController("Lisajous").getPosition();
      } else if (mode == 3 & wholeScreen == false)
      {    
        //pozYSet = cp5.getController("Bonaci").getPosition();
      } else if (mode == 4 && cirOrNpendul == true)
      {
        pozYSet = cp5.getController("Circle").getPosition();
      } else if (mode == 4 && cirOrNpendul == false)
      {
        pozYSet = cp5.getController("Npendul").getPosition();
      } else if (mode == 5)
      {
        pozYSet = cp5.getController("FourTrans").getPosition();
      }

      cp5.get(Button.class, "Set").setPosition(pozXSet, pozYSet[1]).setVisible(true);
      cp5.get(Textfield.class, "input").setPosition(pozXSet, pozYSet[1]+button_height).setVisible(true).setFocus(true);
      resetToBegining();
    }
  }
}

void checkingIfMouseIsOver()
{
  if (cp5.isMouseOver(cp5.getController("Menu")) || cp5.isMouseOver(cp5.getController("Reset")) || cp5.isMouseOver(cp5.getController("StartStop")) || cp5.isMouseOver(cp5.getController("Bonaci")) || cp5.isMouseOver(cp5.getController("FourTrans")) || cp5.isMouseOver(cp5.getController("Lisajous")) || cp5.isMouseOver(cp5.getController("Circle")) || cp5.isMouseOver(cp5.getController("Npendul"))) 
  {

    if (cp5.isMouseOver(cp5.getController("Menu")) || cp5.isMouseOver(cp5.getController("Reset")) || cp5.isMouseOver(cp5.getController("Bonaci")) || cp5.isMouseOver(cp5.getController("FourTrans")) || cp5.isMouseOver(cp5.getController("StartStop")))
    {
      cp5.getController("input").hide();
    }

    if (cp5.isMouseOver(cp5.getController("Menu"))) {
      textFont(font, 20);
      textLeading(18);
      textAlign(LEFT);
      String advice = " Nie ma znaczenia jaka jest wielkość liter.\n "+ shortcutTable.get("shortcutHomogenField") + " - pole jednorodne\n "+ shortcutTable.get("shortcutCentralField") +" - pole centralne\n "
        + shortcutTable.get("shortcutSinglePendulum") +" - pojedyncze wahadło\n " + shortcutTable.get("shortcutDoublePendulum")  +" - podwójne wahadło\n "+ shortcutTable.get("shortcutFourierTransform") + " - transformata furiera\n "
        + shortcutTable.get("shortcutLisajousTable")  +" - tablica Lisajous\n " + shortcutTable.get("shortcutBonaciSeqense") +" - sekwencja fibonacziego\n "+ shortcutTable.get("shortcutNpendulum") +" - wahadło z n kół\n " + shortcutTable.get("shortcutStrangeCircles") +" - dziwne koła\n K - zmiana ilości obiektów\n " 
        + shortcutTable.get("shortcutReset") + " - reset\n " + shortcutTable.get("shortcutDisableEnableAll") + " - Wyłączenie pokazywania menu\n " + shortcutTable.get("shortcutStopStartAll") + " - Zatrzymanie obiektów\n"; 
      text(advice, 110, 20, 660, 330);
    } else if (cp5.isMouseOver(cp5.getController("Lisajous")))
    {
      Disclosures_set("Lisajous");
      cp5.get(Textfield.class, "input").setLabel("Ustaw wielkość okręgów");
    } else if (cp5.isMouseOver(cp5.getController("Circle")))
    {
      Disclosures_set("Circle");
      cp5.get(Textfield.class, "input").setLabel("Ustaw wielkość zmiany kąta");
    } else if (cp5.isMouseOver(cp5.getController("Npendul")))
    {
      Disclosures_set("Npendul");
      cp5.get(Textfield.class, "input").setLabel("Ustaw ilość wahadeł n-tego stopnia");
    }

    cp5.getController("Set").hide();
    cp5.getController("Load").hide();
    cp5.getController("Save").hide();
  } else if (cp5.isMouseOver(cp5.getController("Central"))) {
    Disclosures_set("Central");
    cp5.get(Textfield.class, "input").setCaptionLabel("Ustaw ilość obiektów w centralnym polu grawitacyjnym");
  } else if (cp5.isMouseOver(cp5.getController("Homogen"))) {
    Disclosures_set("Homogen");
    cp5.get(Textfield.class, "input").setLabel("Ustaw ilość obiektów w jednorodnym polu grawitacyjnym");
  } else if (cp5.isMouseOver(cp5.getController("Single"))) {
    Disclosures_set("Single");   
    cp5.get(Textfield.class, "input").setCaptionLabel("Ustaw ilość pojedyńczych wahadeł");
  } else if (cp5.isMouseOver(cp5.getController("Dual"))) {
    Disclosures_set("Dual");
    cp5.get(Textfield.class, "input").setCaptionLabel("Ustaw ilość podwójnych wahadeł");
  }
}

void contextMenu(int currentIndex)
{
  i = currentIndex;
  float x = 0, y = 0;
  if (contextMenuOpenByMouse[0] || contextMenuOpenByMouse[1])
  {
    cir.get(i).showingData();
    x = cir.get(i).point.x + 156 + cir.get(i).radius> width ? cir.get(i).point.x - ((cir.get(i).point.x + 156) - width ) : cir.get(i).point.x + cir.get(i).radius;
    //y = cir.get(i).point.y + 56 + cir.get(i).radius> height ? (int)cir.get(i).point.y - (((int)cir.get(i).point.y + 56) - height ) : (int)cir.get(i).point.y + (int)cir.get(i).radius;
    y = cir.get(i).point.y;
    cp5.get("contextMenu").setPosition(x, y);
    cp5.get("contextMenu").show();

    cp5.get(Slider.class, "Gravity").setVisible(false);
    cp5.get(Slider.class, "Mass").setValue(cir.get(i).fieldVariables.get("mass")).setCaptionLabel("mass").setVisible(true); 
    cp5.get(Slider.class, "Radius").setValue(cir.get(i).fieldVariables.get("radius")).setCaptionLabel("radius").setVisible(true); 
    cp5.get(Slider.class, "Springness").setValue(cir.get(i).fieldVariables.get("springness")).setCaptionLabel("springness").setVisible(true);
  } else if (contextMenuOpenByMouse[2])
  {
    singlePend.get(i).setingFieldVariables();

    x = singlePend.get(i).position.x + 156 + cir.get(i).radius> width ? singlePend.get(i).position.x - ((singlePend.get(i).position.x + 156) - width ) : singlePend.get(i).position.x + singlePend.get(i).radius;
    y = singlePend.get(i).position.y + 56 + cir.get(i).radius> height ? singlePend.get(i).position.y - ((singlePend.get(i).position.x + 56) - height ) : singlePend.get(i).position.y + singlePend.get(i).radius;
    cp5.get("contextMenu").setPosition(x, y);
    cp5.get("contextMenu").show();

    cp5.get(Slider.class, "Mass").setVisible(false);
    cp5.get(Slider.class, "Radius").setValue(singlePend.get(i).fieldVariables.get("radius")).setCaptionLabel("radius").setVisible(true); 
    cp5.get(Slider.class, "Gravity").setValue(singlePend.get(i).fieldVariables.get("gravity")).setCaptionLabel("gravity").setVisible(true); 
    cp5.get(Slider.class, "Springness").setValue(singlePend.get(i).fieldVariables.get("damping")).setCaptionLabel("damping").setVisible(true);
  } else if (contextMenuOpenByMouse[3])
  {
    doublePend.get(i).setingFieldVariables();

    x = doublePend.get(i).position[0].x + 156 + doublePend.get(i).radius1> width ? doublePend.get(i).position[0].x - ((doublePend.get(i).position[0].x + 156) - width ) : doublePend.get(i).position[0].x + doublePend.get(i).radius1;
    y = doublePend.get(i).position[0].y + 56 + doublePend.get(i).radius1> height ? doublePend.get(i).position[0].y - ((doublePend.get(i).position[0].y + 56) - height ) : doublePend.get(i).position[0].y + doublePend.get(i).radius1;
    cp5.get("contextMenu").setPosition(x, y);
    cp5.get("contextMenu").show();
    doublePenIndex = 0;
    cp5.get(Slider.class, "Gravity").setVisible(false);
    cp5.get(Slider.class, "Mass").setValue(doublePend.get(i).fieldVariables.get("mas1")).setCaptionLabel("mas1").setVisible(true);    
    cp5.get(Slider.class, "Radius").setValue(doublePend.get(i).fieldVariables.get("radius1")).setCaptionLabel("radius1").setVisible(true); 
    cp5.get(Slider.class, "Springness").setValue(doublePend.get(i).fieldVariables.get("gravity")).setCaptionLabel("g").setVisible(true);
  } else if (contextMenuOpenByMouse[4])
  {
    doublePend.get(i).setingFieldVariables();

    x = doublePend.get(i).position[1].x + 156 + doublePend.get(i).radius2> width ? doublePend.get(i).position[1].x - ((doublePend.get(i).position[1].x + 156) - width ) : doublePend.get(i).position[1].x + doublePend.get(i).radius2;
    y = doublePend.get(i).position[1].y + 56 + doublePend.get(i).radius2> height ? doublePend.get(i).position[1].y - ((doublePend.get(i).position[1].y + 56) - height ) : doublePend.get(i).position[1].y + doublePend.get(i).radius2;
    cp5.get("contextMenu").setPosition(x, y);
    cp5.get("contextMenu").show();
    doublePenIndex = 1;
    cp5.get(Slider.class, "Gravity").setVisible(false);
    cp5.get(Slider.class, "Mass").setValue(doublePend.get(i).fieldVariables.get("mas2")).setCaptionLabel("mas2").setVisible(true);    
    cp5.get(Slider.class, "Radius").setValue(doublePend.get(i).fieldVariables.get("radius2")).setCaptionLabel("radius2").setVisible(true); 
    cp5.get(Slider.class, "Springness").setValue(doublePend.get(i).fieldVariables.get("gravity")).setCaptionLabel("g").setVisible(true);
  }
}

//void changeVelocityByTheMouse(int currentIndex)
//{
//  i = currentIndex;
//  PVector diff = new PVector(0, 0), position= new PVector(0, 0), result = new PVector(0, 0);

//  if (!stopStart)
//  {
//    if (mode == 1)
//    {
//      if (scrollMenuOpenByMouse[0] || scrollMenuOpenByMouse[1])
//      {
//        position = cir.get(currentIndex).point;
//        diff = PVector.sub(new PVector(mouseX, mouseY), position);
//        diff.normalize();
//        diff.mult(scrollMovement);
//        result.add(diff);
//      } else if (currentIndex < cir.size())
//      {
//        cir.get(currentIndex).acceleration.add(result);
//      }
//    } else if (mode == 2)
//    {
//      if (pendul)
//      {
//        if (scrollMenuOpenByMouse[2])
//        {
//          position = pend.get(currentIndex).position;
//          diff = PVector.sub(new PVector(mouseX, mouseY), position);
//          diff.normalize();
//          diff.mult(scrollMovement);
//          result.add(diff);
//        } else if (currentIndex < pend.size())
//        {
//          pend.get(currentIndex).penAcc += result.mag();
//        }
//      } else 
//      {
//        if (scrollMenuOpenByMouse[3])
//        {
//          position = doublePend.get(currentIndex).position[1];
//          diff = PVector.sub(new PVector(mouseX, mouseY), position);
//          diff.normalize();
//          diff.mult(scrollMovement);
//          result.add(diff);
//        } else if (currentIndex < doublePend.size())
//        {
//          doublePend.get(currentIndex).a1_acc += result.mag();
//        }
//        if (scrollMenuOpenByMouse[4])
//        {
//          position = doublePend.get(currentIndex).position[1];
//          diff = PVector.sub(new PVector(mouseX, mouseY), position);
//          diff.normalize();
//          diff.mult(scrollMovement);
//          result.add(diff);
//        } else if (currentIndex < doublePend.size())
//        {
//          doublePend.get(currentIndex).a2_acc += result.mag();
//        }
//      }
//    }
//  }

//  line(position.x, position.y, diff.x + position.x, diff.y + position.y);
//  circle(diff.x, diff.y, 10);
//  result.set(0, 0);
//}


void changePositionByTheMouse(int currentIndex)
{
  i = currentIndex;
  PVector diff;

  if (changePositionByMouse[0] || changePositionByMouse[1])
  {
    //These booleans are false if the mouse is inside the window. 
    boolean left = mouseX < cir.get(i).radius;
    boolean right = mouseX >  width - cir.get(i).radius;
    boolean top = mouseY  < cir.get(i).radius;
    boolean bottom =  mouseY > height - cir.get(i).radius;

    if (!left && !right && !top && !bottom) 
    {
      cir.get(i).point.x = mouseX;
      cir.get(i).point.y = mouseY;
    } else
    {
      if (!(left && top) || !(left && bottom) || !(right && top) || !(right && bottom))
      {
        if (left || right)
        {
          cir.get(i).point.y = mouseY;
        }

        if (top || bottom)
        {
          cir.get(i).point.x = mouseX;
        }
      }
    }
    if (changePositionByMouse[0])
    {
      cir.get(i).velocity.mult(0);
    }
  } else if (changePositionByMouse[2])
  {
    singlePend.get(i).position.x = mouseX;
    singlePend.get(i).position.y = mouseY;

    diff = PVector.sub(singlePend.get(i).origin, new PVector(mouseX, mouseY));      // Difference between 2 points
    singlePend.get(i).angle = atan2(-1*diff.y, diff.x) - radians(90);                      // Angle relative to vertical axis

    singlePend.get(i).lengh = diff.mag();
    singlePend.get(i).penVel = 0;
  } else if (changePositionByMouse[3])
  {
    doublePend.get(i).position[0].x = mouseX;
    doublePend.get(i).position[0].y = mouseY;

    diff = PVector.sub(doublePend.get(i).origin, new PVector(mouseX, mouseY));     
    doublePend.get(i).a1 = atan2(-1*diff.y, diff.x)- radians(90);                         

    doublePend.get(i).length1 = diff.mag();
    PVector diff2 = PVector.sub(doublePend.get(i).position[0], doublePend.get(i).position[1]);
    doublePend.get(i).length2 = diff2.mag();
    doublePend.get(i).a1_vel = 0;
    doublePend.get(i).a2_vel = 0;
  } else if (changePositionByMouse[4])
  {
    doublePend.get(i).position[1].x = mouseX;
    doublePend.get(i).position[1].y = mouseY;

    diff = PVector.sub(doublePend.get(i).position[0], new PVector(mouseX, mouseY));     
    doublePend.get(i).a2 = atan2(-1*diff.y, diff.x)- radians(90);                              

    doublePend.get(i).length2 = diff.mag();
    doublePend.get(i).a2_vel = 0;
  }
}
