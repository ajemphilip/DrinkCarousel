class Body
{
  double radius = 200;
  double x;
  double y;
  float angle;
  float size;
  PImage image ;
  boolean showLabel;
  String text;
  
  void setPos(double x, double y)
  {
    this.x = x;
    this.y = y;
  }
  
  void makeSize(float s)
  {
    //this.size = map(s, 0, max, 0, 1.5);
    this.size = 1 + s * 0.2;
    if (s == 0){
      this.size = 0;
    }
  }
  void rotate()
  {
    x = width/2 + radius * Math.cos(radians(angle));
    y = height/2 + radius * Math.sin(radians(angle));
  }
}
