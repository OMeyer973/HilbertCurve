//******************************
//
//Dessin d'une courbe de hilbert
//aux couleurs de l'arc en ciel
//
//******************************

//variables to set
int canvasSize = 1024;
int margin = 50;
int gridSize  = 128;
float squareSize = (canvasSize-2*margin)/gridSize;

//computing variables
PVector currPos, prevPos, up, down, left, right;
color dotColor;
color bgColor;

int i = 0;
int j = 0;
int hue = 0;
int dotsPerFrame = 2000;
int currDir = 0;
int spirSize = 0;
int spirCount = 0;

void setup () {
  //initialisation of variables
  size(1024, 1024);
  colorMode(HSB,360,100,100);
  dotColor = color(hue,100,100);
  bgColor = color(0,0,10);
  background(bgColor);
  stroke(dotColor);
  strokeWeight(3);
  fill(dotColor);
  
  currPos = new PVector(0, 0);
  prevPos = currPos;
  
  up = new PVector(-1, 0);
  down = new PVector(1, 0);
  left = new PVector(0, -1);
  right = new PVector (0, 1);
  
  hilbert(7,up);
}

void hilbert(int level, PVector direction) {
  if (level<=1) {
    if (direction == left) {
      move(right);      /* move() could draw a line in... */
      move(down);       /* ...the indicated direction */
      move(left);
      }
    else if (direction == right) {
      move(left);
      move(up);
      move(right);
      }
    else if (direction == up) {
      move(down);
      move(right);
      move(up);
      }
    else if (direction == down) {
      move(up);
      move(left);
      move(down);
      }
  }
  else {
    if (direction == left) {
      hilbert(level-1,up);
      move(right);
      hilbert(level-1,left);
      move(down);
      hilbert(level-1,left);
      move(left);
      hilbert(level-1,down);
      }
    else if (direction == right) {
      hilbert(level-1,down);
      move(left);
      hilbert(level-1,right);
      move(up);
      hilbert(level-1,right);
      move(right);
      hilbert(level-1,up);
      }
    else if (direction == up) {
      hilbert(level-1,left);
      move(down);
      hilbert(level-1,up);
      move(right);
      hilbert(level-1,up);
      move(up);
      hilbert(level-1,right);
      }
    else if (direction == down) {
      hilbert(level-1,right);
      move(up);
      hilbert(level-1,down);
      move(left);
      hilbert(level-1,down);
      move(down);
      hilbert(level-1,left);
      }
  } /* if */
}


void move(PVector v) {
  prevPos = currPos.copy();
  currPos.add(v);
  line(prevPos.x*squareSize+margin,prevPos.y*squareSize+margin,
       currPos.x*squareSize+margin,currPos.y*squareSize+margin);
  hue++;
  dotColor = color(hue%360,100,100);
  stroke(dotColor);
}

void draw () {
}