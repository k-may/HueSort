import java.util.Array;

int numRocks = 14;
//PImage[] rocks = new PImage[14];

HueImage[] rocks = new HueImage[14];
void setup() {

  size(700, 500);

  int imgWidth = (int)(width/ (float)numRocks);

  for (int i = 0; i <  numRocks; i ++) {
    PImage rock = loadImage("images/rocks" + (i +1) +".jpeg");

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
    println("average : " + value);
    rocks[i] = new HueImage(value, img);

    buffer.endDraw();

    image(buffer, i * imgWidth, 0);
  }
  
  Array.sort(rocks);
}