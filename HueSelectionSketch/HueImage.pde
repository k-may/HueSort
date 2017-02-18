class HueImage implements Comparable {

  float value;
  PImage image;
  String fileName;

  HueImage(float aValue, PImage aImage, String aSrcImage) {
    value = aValue; 
    image = aImage;
    fileName = aSrcImage;
  }

  int compareTo(Object o) {
    HueImage e = (HueImage)o;
    return (int)(value-e.value);
  }
}
