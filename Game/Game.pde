Mover mover;
Cylinder cylinder;

public final static float gravityConstant = 9.81;

void settings() {
  fullScreen(P3D);
}

void setup() {
mover = new Mover();
cylinder = new Cylinder();
}

int shift = 0;
PVector Cposition;
ArrayList<PVector> positions = new ArrayList<PVector>();

float speed = 0.2;

float rotZ = 0;
float rotX = 0;

void draw() {
  directionalLight(50, 100, 125, 0, 1, 0);
  ambientLight(102, 102, 102);
  
  background(255);
  
  if(shift == 1){
    pushMatrix();
    textSize(32);
    text("SHIFT" , 200, 200);
    translate(mouseX, mouseY);
    cylinder.update();
    popMatrix();
    
    pushMatrix();
    translate(width/2, height/2 + 100);
    stroke(0); strokeWeight(5);
    displayBall();
    noStroke();
    rectMode(RADIUS);
    rect(0, 0, 300, 300);
    
    for(PVector p : positions){
      pushMatrix();
      translate(p.x, p.y);
      cylinder.update();
      popMatrix();
    }
    
    popMatrix();
    
  }else {
    
    noStroke();
    textSize(32);
    text("mouseX " + mouseX, 200, 200);
    text("difficulty (Press up or down) " + mover.count, 200, 250);
    text("Speed (Scroll up or down) " + speed, 200, 300);
    text(rotZ, 200, 350);
    text(rotX, 200, 400);
    
    pushMatrix();
    translate(width/2, height/2 + 100);
    
    rotateX(radians(rotZ));
    rotateZ(radians(rotX));
    
    box(600, 20, 600);
    
    translate(0, - 30,0);
    
    for(PVector p : positions){
      pushMatrix();
      translate(p.x, 0, p.y);
      rotateX(PI/2);
      translate(0, 0, - cylinder.getBaseSize());
      cylinder.update();
      popMatrix();
    }
    
    noStroke();
    mover.update();
    mover.checkEdges();
    mover.checkCylinderCollision(positions);
    mover.display();
    //update cylinder not on ball location
    
    popMatrix();
  
  }
}

//mapping?How to make it smooth?
void mouseDragged(){
  
  rotX += speed*(mouseX - pmouseX);
  rotZ += speed*(pmouseY - mouseY);
  //rotZ = map(mouseX, 0, width, -5 * PI/3, 5 * PI/3) - map(pmouseX, 0, width, -5 * PI/3, 5 * PI/3);
  //rotX = map(mouseY, 0, height, 5 * PI/3, -5 * PI/3) - map(pmouseY, 0, height, 5 * PI/3, -5 * PI/3);
  
  if(rotZ > 60) rotZ = 60;
  if(rotZ < -60) rotZ = -60;
  if(rotX > 60) rotX = 60;
  if(rotX < -60) rotX = -60;
  
  
}


void mouseWheel(MouseEvent event) {
  float i = event.getCount();
  
  if(i > 0){
    if(speed > 0.2)
    speed -= 0.1;
  }
  else{
    if(speed < 1.5)
    speed += 0.1;
  }
}

void keyPressed() {
if (key == CODED) {
if (keyCode == UP && mover.count < 5) {
mover.difficulty *= 2;
mover.count += 1;
}
else if (keyCode == DOWN && mover.count > 1) {
mover.difficulty /= 2 ;
mover.count -= 1;
}
if(keyCode == SHIFT){
  shift = 1;
}
  
}
}
void keyReleased(){
  if(shift == 1) shift = 0;
}

void displayBall() {
  ellipse(mover.location.x, mover.location.z, 20, 20);
}

void mouseClicked(){
  if(shift == 1){
    float x = mouseX - ((width / 2));
    float y = mouseY - ((height/ 2 + 100));
    
    //check Borders
    float cyRadius = cylinder.getBaseSize();
    
    //Check position not overlapping with Ball
    float dist = PVector.dist(new PVector(x, 0, y), mover.location);
    
    if(!(x - cyRadius < -300 || x + cyRadius > 300 || y - cyRadius < -300 || y + cyRadius > 300 || dist < BALL_RADIUS + cyRadius))
    positions.add(new PVector(x, y));
  }
}