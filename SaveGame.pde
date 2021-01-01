class SaveGame
{
  Function finDate;

  SaveGame()
  {
    finDate = new Function();
  }

  void saves(JSONArray obj, String ObjectName)
  {
    String date = finDate.findingData();
    String fileName = "saves/save";

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
          cir.remove(i);
        }
      } else if (fileName.contains("SinglePend"))
      {
        size = singlePend.size();

        for (int j = size - 1; j >= 0; j--)
        {
          singlePend.remove(i);
        }
      } else if (fileName.contains("DoublePend"))
      {
        size = doublePend.size();

        for (int j = size - 1; j >= 0; j--)
        {
          doublePend.remove(i);
        }
      } else if (fileName.contains("Cir"))
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
          cir.add(new Circum(new PVector(item.getFloat("point.x"), item.getFloat("point.y")), new PVector(item.getFloat("velocity.x"), item.getFloat("velocity.y")), new PVector(item.getFloat("acceleration.x"), item.getFloat("acceleration.y")), 
            item.getFloat("radius"), item.getFloat("mass"), item.getFloat("springness"), item.getFloat("ref")));
        } else if (name.equals("pend"))
        {
          singlePend.add(new Pendulum(new PVector(item.getFloat("origin.x"), item.getFloat("origin.y")), item.getFloat("radius"), item.getFloat("gravity"), item.getFloat("damping"), item.getFloat("angle"), item.getFloat("penVel"), 0 , item.getFloat("lengh")));
        } else if (name.equals("doublePend"))
        {
          doublePend.add(new DoublePendulum(item.getFloat("a1"), item.getFloat("a2"), item.getFloat("a1_vel"), item.getFloat("a2_vel"), item.getFloat("a1_a"), item.getFloat("a2_a"), item.getFloat("length1"), 
            item.getFloat("length2"), item.getFloat("mas1"), item.getFloat("mas2"), item.getFloat("radius1"), item.getFloat("radius2"), item.getFloat("g"), 
            new PVector(item.getFloat("position[0].x"), item.getFloat("position[0].y")), new PVector(item.getFloat("position[1].x"), item.getFloat("position[1].y"))));
        }else if (name.equals("nPend"))
        {
          int tier = item.getInt("tier");
          
          //nPend.add();
          
        }
      }
    }
  }
}
