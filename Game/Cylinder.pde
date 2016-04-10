class Cylinder {
private float cylinderBaseSize = 20;
private float cylinderHeight = 100;
private int cylinderResolution = 40;
private PShape openCylinder = new PShape();
private PShape closedCylinder1 = new PShape();
private PShape closedCylinder2 = new PShape();

Cylinder(){
  float angle;
  int mid = 0;
  float[] x = new float[cylinderResolution + 1];
  float[] y = new float[cylinderResolution + 1];
  //get the x and y position on a circle for all the sides
  for(int i = 0; i < x.length; i++) {
  angle = (TWO_PI / cylinderResolution) * i;
  x[i] = sin(angle) * cylinderBaseSize;
  y[i] = cos(angle) * cylinderBaseSize;
  }
  mid = x.length / 2;
  float centerx = (x[mid] + x[0]) / 2;
  float centery = (y[mid] + y[0]) / 2;
  openCylinder = createShape();
  openCylinder.beginShape(QUAD_STRIP);
  
  closedCylinder1 = createShape();
  closedCylinder2 = createShape();
  closedCylinder1.beginShape(TRIANGLE_FAN);
  closedCylinder2.beginShape(TRIANGLE_FAN);
  
  closedCylinder1.vertex(centerx, centery, cylinderHeight);
  closedCylinder2.vertex(centerx, centery, 0);
  
  //draw the border of the cylinder
  for(int i = 0; i < x.length; i++) {
  openCylinder.vertex(x[i], y[i] , 0);
  openCylinder.vertex(x[i], y[i], cylinderHeight);
  closedCylinder1.vertex(x[i], y[i], cylinderHeight);
  closedCylinder2.vertex(x[i], y[i], 0);
  }
  openCylinder.endShape();
  closedCylinder1.endShape();
  closedCylinder2.endShape();
  }
  
  void update(){
    stroke(0);
    shape(openCylinder);
    shape(closedCylinder1);
    shape(closedCylinder2);
  }
  
  float getBaseSize(){
    return cylinderBaseSize;
  }

}