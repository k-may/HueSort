class HueImage implements Comparable {

  float value;
  PImage image;
  PImage srcImage;

  HueImage(float aValue, PImage aImage, PImage aSrcImage) {
    value = aValue; 
    image = aImage;
    srcImage = aSrcImage;
  }

  int compareTo(Object o) {
    HueImage e = (HueImage)o;
    return (int)(value-e.value);
  }
}
