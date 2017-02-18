import java.util.Arrays;
import java.util.Collections;
import java.nio.file.Path;
import java.nio.file.Paths;

int numRocks = 14;
int imgWidth;
//PImage[] rocks = new PImage[14];

ArrayList<HueImage> rocks = new ArrayList<HueImage>();
void setup() {

  size(700, 500);
  
  imgWidth = (int)(width/ (float)numRocks);
  
  //put image folder name here... (relative to sketch folder!)
  String dir = "images";
  
  //put output folder name here...
  String outDir = "hueImages";
  
  ArrayList<String> fileNames = getFileNames(dir);


  for (int i = 0; i <  fileNames.size(); i ++) {
    PImage rock = loadImage(dir + "/" + fileNames.get(i));

    PGraphics buffer = createGraphics(imgWidth, height);
    buffer.beginDraw();

    float scale = height / (float)rock.height;// /(float) height;

    buffer.image(rock, 0, 0, rock.width * scale, rock.height * scale);
    buffer.loadPixels();

    PImage img = buffer.get();
    float value = 0;
    float numPixels = imgWidth * height;
    for (int p = 0; p < numPixels; p ++) {
      value += hue(buffer.pixels[p]);
    }
    
    value /= numPixels;
    rocks.add(new HueImage(value, img, rock));

    buffer.endDraw();

    image(buffer, i * imgWidth, 0);
  }

  Collections.sort(rocks);
  
  for(int r = 0 ;r < rocks.size(); r ++){
     HueImage rock = rocks.get(r);
    String fileName = "img_" + floor(rock.value) + ".jpeg"; 
    rock.srcImage.save(outDir + "/" + fileName);
  }
}
void draw() {
  background(0);

  for (int i = 0; i < numRocks; i ++) {
    image(rocks.get(i).image, i * imgWidth, 0);
  }
}

ArrayList<String> getFileNames(String dir){

  File folder = new File(sketchPath("") + "/" + dir);
  File[] listOfFiles = folder.listFiles();
  ArrayList<String> fileNames = new ArrayList<String>(); 

  for (int i = 0; i < listOfFiles.length; i++) {
    if (listOfFiles[i].isFile()) {
      String name = listOfFiles[i].getName();
      println("file : " + name);
      fileNames.add(name);
      //System.out.println("File " + listOfFiles[i].getName());
    } else if (listOfFiles[i].isDirectory()) {
      System.out.println("Directory " + listOfFiles[i].getName());
    }
  }
  
  return fileNames;
}
