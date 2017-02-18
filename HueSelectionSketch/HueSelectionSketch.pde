import java.util.Arrays;
import java.util.Collections;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;

import java.nio.file.Files;

int imgWidth;
ArrayList<String> fileNames;
String dir;
String outDir;
ArrayList<HueImage> rocks = new ArrayList<HueImage>();

void setup() {

  size(900, 500);

  //put image folder name here... (relative to sketch folder!)
  dir = "images";

  outDir = dir + "_hues";

  fileNames = getFileNames(dir);

  imgWidth = (int)(width/ (float)fileNames.size());

  calculateHues();
  copyAndRename();
}

void calculateHues() {

  PGraphics buffer = createGraphics(imgWidth, height);

  for (int i = 0; i <  fileNames.size(); i ++) {
    String fileName =  fileNames.get(i);
    PImage rock = loadImage(dir + "/" + fileName);

    buffer.beginDraw();

    float scale = height / (float)rock.height;

    buffer.image(rock, 0, 0, rock.width * scale, rock.height * scale);
    buffer.loadPixels();

    PImage img = buffer.get();
    float value = 0;
    float numPixels = imgWidth * height;
    for (int p = 0; p < numPixels; p ++) {
      value += hue(buffer.pixels[p]);
    }

    value /= numPixels;
    rocks.add(new HueImage(value, img, fileName));

    buffer.endDraw();
  }

  //sort images by hue average
  Collections.sort(rocks);
}

void copyAndRename() {
  
  String dirPath = sketchPath("");

  for (int r = 0; r < rocks.size(); r ++) {
    HueImage rock = rocks.get(r);

    String srcFileName = rock.fileName;
    int index = srcFileName.lastIndexOf(".");

    String format = srcFileName.substring(index);
    String destFileName = dirPath + outDir +  "/" + srcFileName.substring(0, index) + "_" + floor(rock.value) + format;

    srcFileName = dirPath + dir + "/" + srcFileName;
    
    copyFile(srcFileName, destFileName);

    image(rocks.get(r).image, r * imgWidth, 0);
  }
}

void copyFile(String srcPath, String destPath){
  
   try {
      Path fromPath = new File(srcPath).toPath();
      Path toPath = new File(destPath).toPath();
      
      final Path tmp = toPath.getParent();

      if (tmp != null) // null will be returned if the path has no parent
        Files.createDirectories(tmp);

      Files.copy(fromPath, toPath, StandardCopyOption.REPLACE_EXISTING);

      println("copy : ", fromPath.toString(), toPath.toString());
    } 
    catch (IOException e) {
      System.err.println(e);
    }
}

ArrayList<String> getFileNames(String dir) {

  File folder = new File(sketchPath("") + "/" + dir);
  File[] listOfFiles = folder.listFiles();
  ArrayList<String> fileNames = new ArrayList<String>(); 

  for (int i = 0; i < listOfFiles.length; i++) {
    if (listOfFiles[i].isFile()) {
      String name = listOfFiles[i].getName();
      println("file : " + name);

      if (name.indexOf(".jpeg") != -1 ||
        name.indexOf(".jpg") != -1 ||
        name.indexOf(".tif") != -1 ||
        name.indexOf(".gif") != -1 ||
        name.indexOf(".png") != -1)
      {
        fileNames.add(name);
      } else {
        println(name + " inst an image!");
      }
      //System.out.println("File " + listOfFiles[i].getName());
    } else if (listOfFiles[i].isDirectory()) {
      System.out.println("Directory " + listOfFiles[i].getName());
    }
  }

  return fileNames;
}