import java.util.Arrays;
import java.util.Collections;
import java.nio.file.Path;
import java.nio.file.Paths;

int imgWidth;

ArrayList<HueImage> rocks = new ArrayList<HueImage>();

void setup() {

  size(900, 500);

  //put image folder name here... (relative to sketch folder!)
  String dir = "Grey_jpeg";

  //put output folder name here...
  String outDir = dir + "_hues";

  ArrayList<String> fileNames = getFileNames(dir);
  imgWidth = (int)(width/ (float)fileNames.size());

  PGraphics buffer = createGraphics(imgWidth, height);

  for (int i = 0; i <  fileNames.size(); i ++) {
    String fileName = dir + "/" + fileNames.get(i);
    PImage rock = loadImage(fileName);

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

  Collections.sort(rocks);

  for (int r = 0; r < rocks.size(); r ++) {
    HueImage rock = rocks.get(r);
    String src = rock.fileName;
    String fileName = outDir + "/" + rock.value + "_" + src;//"img_" + floor(rock.value) + ".jpeg"; 

    // rock.srcImage.save(outDir + "/" + fileName);
    /*  Files.copy(src,
     (new File(fileName).toPath(),
     StandardCopyOption.REPLACE_EXISTING);*/
    println(fileName);

    image(rocks.get(r).image, r * imgWidth, 0);
  }
  println("done!");
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
