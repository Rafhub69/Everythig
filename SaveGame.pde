class SaveGame
{
  Function finDate;

  SaveGame()
  {
    finDate = new Function();
  }

  void saves(JSONArray obj, String ObjectName)
  {
    String fileName = "saves/save";
    String date = finDate.findingData();

    if (ObjectName != null)
    {
      fileName +=ObjectName;
    }

    boolean exist = true;
    
    if (obj != null)
    {
      File f;
      int i = -1;
      do
      {
        i++;
        f = dataFile(fileName + i + date + (i + 1) + ".json");     
        exist = f.isFile();
      } 
      while (exist);
      saveJSONArray(obj, fileName + i + date + (i + 1) + ".json");
    }
  }

  void load(File selection)
  {
    JSONArray json;

    if (selection == null)
    {
      return;
    } else
    {
      json = loadJSONArray(selection);
      String fileName = selection.getName();
      int size = 0;

      if (fileName.contains("Cir"))
      {
        size = cir.size();

        for (int j = size - 1; j >= 0; j--)
        {
          cir.remove(curIndex);
        }
      } else if (fileName.contains("SinglePend"))
      {
        size = singlePend.size();

        for (int j = size - 1; j >= 0; j--)
        {
          singlePend.remove(curIndex);
        }
      } else if (fileName.contains("DoublePend"))
      {
        size = doublePend.size();

        for (int j = size - 1; j >= 0; j--)
        {
          doublePend.remove(curIndex);
        }
      } else if (fileName.contains("NPend"))
      {
        size = nPend.size();

        for (int i = size - 1; i >= 0; i--)
        {
          nPend.remove(i);
        }
      }

      for (int j = 0; j < json.size(); j++) 
      {
        JSONObject item = json.getJSONObject(j); 
        String name = item.getString("Name");
        if (name.equals("cir"))
        {
          cir.add(new Circum(new PVector(item.getFloat("point.x"), item.getFloat("point.y")), new PVector(item.getFloat("velocity.x"), 
          item.getFloat("velocity.y")), new PVector(item.getFloat("acceleration.x"), item.getFloat("acceleration.y")), item.getFloat("radius"), item.getFloat("mass"), item.getFloat("springness")));
        } else if (name.equals("singlePend"))
        {
          singlePend.add(new Pendulum(new PVector(item.getFloat("origin.x"), item.getFloat("origin.y")), item.getFloat("radius"), item.getFloat("gravity"), item.getFloat("damping"), item.getFloat("angle"), item.getFloat("penVel"), item.getFloat("lengh")));
        } else if (name.equals("doublePend"))
        {
          doublePend.add(new DoublePendulum(item.getFloat("a0"), item.getFloat("a1"), item.getFloat("a0_vel"), item.getFloat("a1_vel"), item.getFloat("a0_a"), 
          item.getFloat("a1_a"), item.getFloat("length0"), item.getFloat("length1"), item.getFloat("mas0"), item.getFloat("mas1"), item.getFloat("radius0"), item.getFloat("radius1"), 
          item.getFloat("g"), new PVector(item.getFloat("position[0].x"), item.getFloat("position[0].y")), new PVector(item.getFloat("position[1].x"), item.getFloat("position[1].y"))));
        } else if (name.equals("nPend"))
        {
          int tier = int(item.getFloat("tier"));
          FloatList mass = new FloatList(), angles = new FloatList();  
          FloatList lenghts = new FloatList(), radiuses = new FloatList();
          FloatList positionX = new FloatList(), positionY = new FloatList();
          FloatList velocities = new FloatList(), accelerations = new FloatList();        

          for (int i = 0; i < tier; i++)
          {
            mass.append(item.getFloat("mas" + i));
            angles.append(item.getFloat("angles" + i));
            lenghts.append(item.getFloat("length" + i));
            radiuses.append(item.getFloat("radius" + i));
            velocities.append(item.getFloat("velocities" + i));
            positionX.append(item.getFloat("position["+ i +"].x"));
            positionY.append(item.getFloat("position["+ i +"].y"));            
            accelerations.append(item.getFloat("accelerations" + i));
          }
          
          nPend.add(new NPendulum( tier, mass, angles, lenghts, radiuses, velocities, accelerations, positionX, positionY));
        }
      }
    }
  }
}
