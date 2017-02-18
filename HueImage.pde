class HueImage implements Comparable {

  float value;
  PImage image;

  HueImage(float aValue, PImage aImage) {
    value = aValue; 
    image = aImage;
  }

  int compareTo(Object o) {
    HueImage e = (HueImage)o;
    return (int)(value-e.value);
  }
}