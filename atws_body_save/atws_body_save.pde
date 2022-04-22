import peasy.*;
PeasyCam cam;

MotionDataManager motionData;
int n_bone;

PVector[] pos;

boolean dataMode = false;

void setup() {
   frameRate(30);
   // fullScreen(P3D);
   size(1280, 720, P3D);

   cam = new PeasyCam(this, 100); 
   cam.setMinimumDistance(50);  
   cam.setMaximumDistance(500);  

   motionData = new MotionDataManager();
   motionData.setDataPath("/created/motionData.csv");
   n_bone = motionData.getBoneNum();

   pos = new PVector[n_bone];

   for(int i = 0; i < n_bone; i ++)
   {
     pos[i] = new PVector();
   }

}

void draw() {

    background(0);
    lights();
   
    motionData.setDataMode(dataMode);
    motionData.update();
    motionData.setBasePosition(0, -1.0, 1.5);
    motionData.setBaseScale(75);

    for(int i = 0; i < n_bone; i ++)
    {
      pos[i] = motionData.getBoneData(i);

      push();

      translate(pos[i].x, pos[i].y, pos[i].z);

      pushStyle();
      noStroke();
      box(10);
      popStyle();
      pop();
   }
   
   pushStyle();
   stroke(255, 128);
   motionData.drawGrid(50, 20);
   popStyle();

}

void keyPressed() {
    if(keyCode == ENTER) dataMode = !dataMode;

    if(key == ' ') motionData.beginMotionRec();

    if(key == 's') motionData.stopMotionRec();

} 
