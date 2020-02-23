/* 
 * RectangleChaos.pde
 * 
 * Pete Prodoehl <pete@2xlnetworks.com>
 * 
 * <http://rasterweb.net/raster/>
 * 
 */

import processing.pdf.*;
import java.util.Date;


// set width and height of canvas as well as border at edges
int canvasWidth = 1920;
int canvasHeight = 1080;

// most of the numbers below can be adjusted, play around with their values

float xpos = 50;  // x starting point in upper left
float ypos = 50;  // y starting point in upper left
float wall = 150; // attempt to preserve whitespace on right side

// size of square that we draw
float rsize = 40;

// step for square, smaller than rsize will overlap, larger will space apart
float step = 50;

// affects the jitter of rows: try 0.7 or 1.33 or 2.33 or 5.9
float multiplierN = 2.35;


float mimn = xpos;
float rowct = 0;
float multiple = 0;

/* ----------------------------------------------------------- */

// get date to use for filename
Date date = new Date();
long currentTime = date.getTime()/1000; 


void settings() {
  size(canvasWidth, canvasHeight);
}

void setup() {
  background(255);
  stroke(0);
  strokeWeight(1);
  beginRecord(PDF, "output-" + currentTime + ".pdf");
}

void draw() {

  noFill();
  
  float x1 = xpos;
  float y1 = ypos;  
  
  multiple = rowct * multiplierN;
  
  if (rowct > 0) {
    x1 = xpos + random(0,multiple);
    y1 = ypos + random(0,multiple);
  }
  else {
    x1 = xpos;
    y1 = ypos;
  }

  float x2 = x1 + rsize;
  float y2 = y1;

  float x3 = x1 + rsize;
  float y3 = y1 + rsize;
  
  float x4 = x1;
  float y4 = y1 + rsize;
  
  float x5 = x1;
  float y5 = y1;
  
  beginShape();
  vertex(x1,y1);
  vertex(x2,y2);
  vertex(x3,y3);
  vertex(x4,y4);
  vertex(x5,y5);
  endShape();
  
  
  // end of a row
  if (xpos > (canvasWidth-wall)) {
    xpos = mimn;
    ypos = ypos + step;
    rowct++;
  }
  else {
    xpos = xpos + step;
  }
  
  // last row, then we save the PDF and exit
  if (ypos > (canvasHeight-wall)) {
    ypos = step;
    endRecord();
    exit();
  }

}
