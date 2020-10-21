void mouseWheel(MouseEvent event) {
  start = millis();
  scrollMovement = constrain(event.getCount()*Multi + scrollMovement, -MaxFar, MaxFar);
}

void mousePressed() {

  if (!stopStart)
  {
    if (mode == 1)
    {
      if (field)
      { 
        for (int i = 0; i<cir.size(); i++)
        {
          float d = dist(mouseX, mouseY, cir.get(i).point.x, cir.get(i).point.y);
          if (d <= cir.get(i).radius ) {
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
          if (d <= cir.get(j).radius) {
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
    } else if (mode == 2)
    {
      if (pendul)
      {
        for (int k = 0; k< pend.size(); k++)
        {
          float d = dist(mouseX, mouseY, pend.get(k).position.x, pend.get(k).position.y);

          if (d <= cir.get(k).radius) {

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

          if (d1 <= doublePend.get(l).radius1) {
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
          } else if (d2 <= doublePend.get(l).radius2) {
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
          currentIndex = l;
        }
      }
    } else if (mode == 4)
    {
    } else if (mode == 5)
    {
    }
  }
}

void mouseReleased() {
  if (!stopStart)
  {
    if (mode == 1)
    {
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
    } else if (mode == 2)
    {
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
    }
  } else if (mode == 4)
  {
  } else if (mode == 5)
  {
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
    } else if (key == (shortcutHomogenField+32) ||key == shortcutHomogenField)
    {
      mode = 1;
      field = false; // f - homogeneous field 
      setting();
    } else if (key == (shortcutCentralField+32) ||key == shortcutCentralField)
    {
      mode = 1;
      field = true; //v - central field
      setting();
    } else if (key == (shortcutSinglePendulum+32) ||key ==  shortcutSinglePendulum)
    {
      mode = 2;
      pendul = true; //p - single pendulum
      setting();
    } else if (key == (shortcutDoublePendulum+32) ||key == shortcutDoublePendulum)
    {
      mode = 2;
      pendul = false; //d - double pendulum
      setting();
    } else if (key == (shortcutLisajousTable+32) ||key == shortcutLisajousTable)
    {
      mode = 3;
      wholeScreen = true;
      setting();
    } else if (key == (shortcutBonaciSeqense+32) ||key == shortcutBonaciSeqense)
    {
      mode = 3;
      wholeScreen = false;
      setting();
    } else if (key == (shortcutStrangeCircles+32) ||key == shortcutStrangeCircles)
    {
      mode = 4;//c - strange circles
      setting();
    } else if (key == (shortcutFourierTransform+32) ||key == shortcutFourierTransform)
    {
      mode = 5;//t - fourier transformation
      setting();
    } else if (key == 'R' ||key == 'r')
    {//reset
      background(255);
      setting();
    } else  if (key == 'K' ||key == 'k')
    {
      if (!information)
      {
        information = !information;
      }  
      //
      if (mode == 1 & field == true)
      {
        pozYSet = cp5.getController("Central").getPosition();
        cp5.get(Button.class, "Set").setPosition(pozXSet, pozYSet[1]).setVisible(true);
        cp5.get(Textfield.class, "input").setPosition(pozXSet, pozYSet[1]+button_height).setVisible(true).setFocus(true);
      } else if (mode == 1 & field == false)
      {
        pozYSet = cp5.getController("Homogen").getPosition();
        cp5.get(Button.class, "Set").setPosition(pozXSet, pozYSet[1]).setVisible(true);
        cp5.get(Textfield.class, "input").setPosition(pozXSet, pozYSet[1]+button_height).setVisible(true).setFocus(true);
      } else if (mode == 2 & pendul == true)
      {
        pozYSet = cp5.getController("Single").getPosition();
        cp5.get(Button.class, "Set").setPosition(pozXSet, pozYSet[1]).setVisible(true);
        cp5.get(Textfield.class, "input").setPosition(pozXSet, pozYSet[1]+button_height).setVisible(true).setFocus(true);
      } else if (mode == 2 & pendul == false)
      {
        pozYSet = cp5.getController("Dual").getPosition();
        cp5.get(Button.class, "Set").setPosition(pozXSet, pozYSet[1]).setVisible(true);
        cp5.get(Textfield.class, "input").setPosition(pozXSet, pozYSet[1]+button_height).setVisible(true).setFocus(true);
      } else if (mode == 3 & wholeScreen == true)
      {
        pozYSet = cp5.getController("Lisajous").getPosition();
        cp5.get(Button.class, "Set").setPosition(pozXSet, pozYSet[1]).setVisible(true);
        cp5.get(Textfield.class, "input").setPosition(pozXSet, pozYSet[1]+button_height).setVisible(true).setFocus(true);
      } else if (mode == 3 & wholeScreen == false)
      {    
        //pozYSet = cp5.getController("Bonaci").getPosition();
        //cp5.get(Button.class, "Set").setPosition(pozXSet, pozYSet[1]).setVisible(true);
        //cp5.get(Button.class, "input").setPosition(pozXSet, pozYSet[1]+button_height).setVisible(true);
      } else if (mode == 4)
      {
        pozYSet = cp5.getController("Circle").getPosition();
        cp5.get(Button.class, "Set").setPosition(pozXSet, pozYSet[1]).setVisible(true);
        cp5.get(Textfield.class, "input").setPosition(pozXSet, pozYSet[1]+button_height).setVisible(true).setFocus(true);
      } else if (mode == 5)
      {
        pozYSet = cp5.getController("Fourier").getPosition();
        cp5.get(Button.class, "Set").setPosition(pozXSet, pozYSet[1]).setVisible(true);
        cp5.get(Textfield.class, "input").setPosition(pozXSet, pozYSet[1]+button_height).setVisible(true).setFocus(true);
      }
      setting();
    }
  }
}

void checkingIfMouseIsOver()
{
  if (cp5.isMouseOver(cp5.getController("Menu"))) {
    cp5.getController("Set").hide();
    cp5.getController("input").setVisible(false);
    textFont(font, 20);
    textLeading(18);
    textAlign(LEFT);
    String advice = " Nie ma znaczenia jaka jest wielkość liter.\n "+ shortcutHomogenField + "- pole jednorodne\n "+ shortcutCentralField +" - pole centralne\n "+ shortcutSinglePendulum +" - pojedyncze wahadło\n "+ shortcutDoublePendulum  +" - podwójne wahadło\n "+ shortcutFourierTransform + "- transformata furiera\n "+ shortcutLisajousTable  +" - tablica Lisajous\n "+ shortcutBonaciSeqense +" - sekwencja fibonacziego\n "+ shortcutStrangeCircles +" - dziwne koła \n K - zmiana ilości obiektów \n R - reset"; 
    text(advice, 110, 20, 660, 160);
  } else if (cp5.isMouseOver(cp5.getController("Reset")))
  {
    cp5.getController("Set").hide();
    cp5.getController("input").setVisible(false);
  } else if (cp5.isMouseOver(cp5.getController("Central"))) {
    cp5.get(Textfield.class, "input").setCaptionLabel("Ustaw ilość obiektów w centralnym polu grawitacyjnym");
    Disclosures_set("Central");
  } else if (cp5.isMouseOver(cp5.getController("Single"))) {
    Disclosures_set("Single");
    cp5.get(Textfield.class, "input").setCaptionLabel("Ustaw ilość pojedyńczych wahadeł");
  } else if (cp5.isMouseOver(cp5.getController("Dual"))) {
    cp5.get(Textfield.class, "input").setCaptionLabel("Ustaw ilość podwójnych wahadeł");
    Disclosures_set("Dual");
  } else if (cp5.isMouseOver(cp5.getController("Homogen"))) {
    cp5.get(Textfield.class, "input").setLabel("Ustaw ilość obiektów w jednorodnym polu grawitacyjnym");
    Disclosures_set("Homogen");
  } else if (cp5.isMouseOver(cp5.getController("Lisajous"))) {
    Disclosures_set("Lisajous");
    cp5.get(Textfield.class, "input").setLabel("Ustaw wielkość okręgów");
    cp5.getController("Set").setVisible(false);
  } else if (cp5.isMouseOver(cp5.getController("Bonaci"))) {
    // Disclosures_set("Bonaci");
    cp5.getController("input").setVisible(false);
    cp5.getController("Set").setVisible(false);
  } else if (cp5.isMouseOver(cp5.getController("Circle"))) {
    Disclosures_set("Circle");
    cp5.get(Textfield.class, "input").setLabel("Ustaw wielkość zmiany kąta");
    cp5.getController("Set").setVisible(true);
  } else if (cp5.isMouseOver(cp5.getController("Fourier"))) {
    // Disclosures_set("Fourier");
    cp5.getController("input").setVisible(false);
    cp5.getController("Set").setVisible(false);
  }
}

void contextMenu(int currentIndex)
{
  i = currentIndex;
  int x;
  if (contextMenuOpenByMouse[0] || contextMenuOpenByMouse[1])
  {
    cir.get(i).showingData();
    x = cir.get(i).point.x + 156 + cir.get(i).radius> width ? (int)cir.get(i).point.x - (((int)cir.get(i).point.x + 156) - width ) : (int)cir.get(i).point.x + (int)cir.get(i).radius;
    cp5.get("contextMenu").setPosition(x, cir.get(i).point.y);
    cp5.get("contextMenu").show();

    cp5.get(Slider.class, "Gravity").setVisible(false);
    cp5.get(Slider.class, "Mass").setValue(cir.get(i).fieldValue[1]).setCaptionLabel(cir.get(i).fieldName[1]).setVisible(true);    
    cp5.get(Slider.class, "Radius").setValue(cir.get(i).fieldValue[0]).setCaptionLabel(cir.get(i).fieldName[0]); 
    cp5.get(Slider.class, "Springness").setValue(cir.get(i).fieldValue[2]).setCaptionLabel(cir.get(i).fieldName[2]);
  } else if (contextMenuOpenByMouse[2])
  {
    pend.get(i).showingData();

    x = pend.get(i).position.x + 156 + cir.get(i).radius> width ? (int)pend.get(i).position.x - (((int)pend.get(i).position.x + 156) - width ) : (int)pend.get(i).position.x + (int)pend.get(i).radius;
    cp5.get("contextMenu").setPosition(x, pend.get(i).position.y);
    cp5.get("contextMenu").show();

    cp5.get(Slider.class, "Mass").setVisible(false);
    cp5.get(Slider.class, "Radius").setValue(pend.get(i).fieldValue[0]).setCaptionLabel(pend.get(i).fieldName[0]); 
    cp5.get(Slider.class, "Gravity").setValue(pend.get(i).fieldValue[1]).setCaptionLabel(pend.get(i).fieldName[1]).setVisible(true); 
    cp5.get(Slider.class, "Springness").setValue(pend.get(i).fieldValue[2]).setCaptionLabel(pend.get(i).fieldName[2]);
  } else if (contextMenuOpenByMouse[3])
  {
    doublePend.get(i).showingData(3);

    x = doublePend.get(i).position[0].x + 156 + doublePend.get(i).radius1> width ? (int)doublePend.get(i).position[0].x - (((int)doublePend.get(i).position[0].x + 156) - width ) : (int)doublePend.get(i).position[0].x + (int)doublePend.get(i).radius1;
    cp5.get("contextMenu").setPosition(x, doublePend.get(i).position[0].y);
    cp5.get("contextMenu").show();

    cp5.get(Slider.class, "Gravity").setVisible(false);
    cp5.get(Slider.class, "Mass").setValue(doublePend.get(i).fieldValue[1]).setCaptionLabel(doublePend.get(i).fieldName[1]).setVisible(true);    
    cp5.get(Slider.class, "Radius").setValue(doublePend.get(i).fieldValue[0]).setCaptionLabel(doublePend.get(i).fieldName[0]); 
    cp5.get(Slider.class, "Springness").setValue(doublePend.get(i).fieldValue[2]).setCaptionLabel(doublePend.get(i).fieldName[2]);
  } else if (contextMenuOpenByMouse[4])
  {
    doublePend.get(i).showingData(4);

    x = doublePend.get(i).position[1].x + 156 + doublePend.get(i).radius2> width ? (int)doublePend.get(i).position[1].x - (((int)doublePend.get(i).position[1].x + 156) - width ) : (int)doublePend.get(i).position[1].x + (int)doublePend.get(i).radius2;
    cp5.get("contextMenu").setPosition(x, doublePend.get(i).position[1].y);
    cp5.get("contextMenu").show();

    cp5.get(Slider.class, "Mass").setValue(doublePend.get(i).fieldValue[1]).setCaptionLabel(doublePend.get(i).fieldName[1]).setVisible(true);    
    cp5.get(Slider.class, "Radius").setValue(doublePend.get(i).fieldValue[0]).setCaptionLabel(doublePend.get(i).fieldName[0]); 
    cp5.get(Slider.class, "Springness").setValue(doublePend.get(i).fieldValue[2]).setCaptionLabel(doublePend.get(i).fieldName[2]);
  }
}

void changeVelocityByTheMouse(int currentIndex)
{
  i = currentIndex;
  PVector diff = new PVector(0, 0), position= new PVector(0, 0), result = new PVector(0, 0);

  if (!stopStart)
  {
    if (mode == 1)
    {
      if (field)
      {
        if (scrollMenuOpenByMouse[0])
        {
          position = cir.get(currentIndex).point;
          diff = PVector.sub(new PVector(mouseX, mouseY), position);
          diff.normalize();
          diff.mult(scrollMovement);
          result.add(diff);
        } else
        {
          cir.get(currentIndex).acceleration.add(result);
        }
      } else 
      {
        if (scrollMenuOpenByMouse[1])
        {
          position = cir.get(currentIndex).point;
          diff = PVector.sub(new PVector(mouseX, mouseY), position);
          diff.normalize();
          diff.mult(scrollMovement);
          result.add(diff);
        } else
        {
          cir.get(currentIndex).acceleration.add(result);
        }
      }
    } else if (mode == 2)
    {
      if (pendul)
      {
        if (scrollMenuOpenByMouse[2])
        {
          position = pend.get(currentIndex).position;
          diff = PVector.sub(new PVector(mouseX, mouseY), position);
          diff.normalize();
          diff.mult(scrollMovement);
          result.add(diff);
        } else
        {
         pend.get(currentIndex).a1_a += result.mag();
        }
        
      } else 
      {
        if (scrollMenuOpenByMouse[3])
        {
          position = doublePend.get(currentIndex).position[1];
          diff = PVector.sub(new PVector(mouseX, mouseY), position);
          diff.normalize();
          diff.mult(scrollMovement);
          result.add(diff);
        } else
        {
         doublePend.get(currentIndex).a1_a += result.mag();
        }
        if (scrollMenuOpenByMouse[4])
        {
          position = doublePend.get(currentIndex).position[1];
          diff = PVector.sub(new PVector(mouseX, mouseY), position);
          diff.normalize();
          diff.mult(scrollMovement);
          result.add(diff);
        } else
        {
         doublePend.get(currentIndex).a2_a += result.mag();
        }
      }
    }
  }

  line(position.x, position.y, diff.x + position.x, diff.y + position.y);
  circle(diff.x, diff.y, 10);
  result.set(0,0);
}


void changePositionByTheMouse(int currentIndex)
{
  i = currentIndex;
  PVector diff;

  if (changePositionByMouse[0])
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
      if (left && top || left && bottom || right && top || right && bottom)
      {
      } else 
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
    cir.get(i).velocity.mult(0);
  } else if (changePositionByMouse[1])
  {
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
      if (left && top || left && bottom || right && top || right && bottom)
      {
      } else 
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
  } else if (changePositionByMouse[2])
  {
    pend.get(i).position.x = mouseX;
    pend.get(i).position.y = mouseY;

    diff = PVector.sub(pend.get(i).origin, new PVector(mouseX, mouseY));      // Difference between 2 points
    pend.get(i).angle = atan2(-1*diff.y, diff.x) - radians(90);                      // Angle relative to vertical axis

    pend.get(i).lengh = diff.mag();
    pend.get(i).a1_vel = 0;
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
