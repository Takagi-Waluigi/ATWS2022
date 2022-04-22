import peasy.*;
PeasyCam cam;
MotionDataManager motionData;

int n_bone = 25;
PVector[] pos = new PVector[n_bone];

BufferLine bufLine;

int channel = 0;
int n_channel = 5;
int frame = 0;

void setup() {
  frameRate(30);
 // fullScreen(P3D);
  size(1280, 720, P3D);

  cam = new PeasyCam(this, 100); 
  cam.setMinimumDistance(50);  
  cam.setMaximumDistance(500);  

  motionData = new MotionDataManager();

  for(int i = 0; i < n_bone; i ++)
  {
    pos[i] = new PVector();
  }

  bufLine = new BufferLine(50);

}

void draw() {
  //noCursor();
 // rotateY(frameCount * 0.01);
  background(0);
  lights();

  //Show Dimention Arrow
  pushStyle();

  stroke(255, 0, 0);
  line(0, 0, 0, 20, 0, 0);
  stroke(0, 255, 0);
  line(0, 0, 0, 0, 20, 0);
  stroke(0, 0, 255);
  line(0, 0, 0, 0, 0, 20);

  popStyle();

  motionData.setDataMode(false);
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
    if(channel == 0 || channel == 9) box(10);
    popStyle();
    pop();
  }

  bufLine.updateBuffer(pos);

  if(channel == 1 || channel == 9) bufLine.drawBufferLine();
  if(channel == 2 || channel == 9) drawRandomVertex();
  if(channel == 3 || channel == 9) volumeLine();
  pushStyle();
  stroke(255, 128);
  motionData.drawGrid(50, 20);
  popStyle();
}



void keyPressed() {
  switch(key){
    case '0':
      channel = 0;
      break;

    case '1':
      channel = 1;
      break;

    case '2':
      channel = 2;
      break;

    case '3':
      channel = 3;
      break;

    case '4':
      channel = 4;
      break;

    case '9':
      channel = 9;
    break;

  }

  if(keyCode == ENTER){
    save("capture_" + frame + ".png");
    frame++;
  }
}

void volumeLine()
{
  for(int i = 0; i < n_bone; i ++)
  {
    pushStyle();
    noFill();

    beginShape();
    stroke(0, 0,random(150, 255));
    vertex(pos[i].x, pos[i].y, -1000 + random(-100, 100));
    vertex(pos[i].x, pos[i].y, -1000 + random(-100, 100));
    vertex(pos[i].x, pos[i].y,  1000 + random(-100, 100));
    vertex(pos[i].x, pos[i].y,  1000 + random(-100, 100));
    endShape(CLOSE);

    beginShape();
    stroke(0, random(150, 255), 0);
    vertex(pos[i].x, -1000 + random(-100, 100), pos[i].z);
    vertex(pos[i].x, -1000 + random(-100, 100), pos[i].z);
    vertex(pos[i].x,  1000 + random(-100, 100), pos[i].z);
    vertex(pos[i].x,  1000 + random(-100, 100), pos[i].z);
    endShape(CLOSE);

    beginShape();
    stroke(random(150, 255), 0, 0);
    vertex(-1000 + random(-100, 100), pos[i].y, pos[i].z);
    vertex(-1000 + random(-100, 100), pos[i].y, pos[i].z);
    vertex( 1000 + random(-100, 100), pos[i].y, pos[i].z);
    vertex( 1000 + random(-100, 100), pos[i].y, pos[i].z);
    endShape(CLOSE);

    popStyle();
  }
}

void drawRandomVertex(){
  for(int i = 0; i < n_bone; i ++)
  {
    pushStyle();
    stroke(random(128, 255), 100, random(128, 255));
    fill(random(128, 255), random(128, 255), 20);
    beginShape();
    int id_rand = (int)random(0, n_bone);
    vertex(pos[id_rand].x, pos[id_rand].y, pos[id_rand].z);

    id_rand = (int)random(0, n_bone);
    vertex(pos[id_rand].x, pos[id_rand].y, pos[id_rand].z);

    id_rand = (int)random(0, n_bone);
    vertex(pos[id_rand].x, pos[id_rand].y, pos[id_rand].z);

    id_rand = (int)random(0, n_bone);
    vertex(pos[id_rand].x, pos[id_rand].y, pos[id_rand].z);

    endShape(CLOSE);
    popStyle();
  }
}

class BufferLine {
  int BUFFER_SIZE = 10;
  PVector[][] bonePosBuffer;

  BufferLine(int bufferSize)
  {
    this.BUFFER_SIZE = bufferSize;
    this.bonePosBuffer = new PVector[this.BUFFER_SIZE][n_bone];

    for (int i = 0; i < BUFFER_SIZE; i ++)
    {
      for (int j = 0; j < n_bone; j ++)
      {
        bonePosBuffer[i][j] = new PVector(0, 0, 0);
      }
    }
  }

  void updateBuffer(PVector[] np)
  {
    for (int i = BUFFER_SIZE - 1; i > 0; i --)
    {
      for (int j = 0; j < n_bone; j ++)
      {
        this.bonePosBuffer[i][j].x= this.bonePosBuffer[i - 1][j].x;
        this.bonePosBuffer[i][j].y= this.bonePosBuffer[i - 1][j].y;
        this.bonePosBuffer[i][j].z= this.bonePosBuffer[i - 1][j].z;
      }
    }

    for (int i = 0; i < n_bone; i ++)
    {
      this.bonePosBuffer[0][i].x= np[i].x;
      this.bonePosBuffer[0][i].y= np[i].y;
      this.bonePosBuffer[0][i].z= np[i].z;
    }
  }

  void drawBufferLine()
  {
    for (int i = 0; i < BUFFER_SIZE - 1; i ++)
    {
      
      for (int j = 0; j < n_bone; j ++)
      {
        pushStyle();
        float dist = this.bonePosBuffer[i][j].dist(this.bonePosBuffer[i + 1][j]);
        float col = map(dist, 0, 50, 150, 255);
        stroke(col, 25, 255 - col * 0.5);
        line(this.bonePosBuffer[i][j].x, this.bonePosBuffer[i][j].y, this.bonePosBuffer[i][j].z, 
          this.bonePosBuffer[i + 1][j].x, this.bonePosBuffer[i + 1][j].y, this.bonePosBuffer[i + 1][j].z);
        popStyle();
      }
    }
  }
}
