/**
 *   Pixel sorting for photo sets  
 *   + a GUI extra window 
 *
 * This sketch performs pixel sorting on a collection of
 * photo sets. It was built to be used in live performances.
 * 
 * for the GUI, I use controlP5 which works ok on Processing 2 but not 3.
 * http://www.sojamo.de/libraries/controlP5/
 * 
 * the sorting algorithim is from Phillip Davis Stearns' sketch at
 * https://github.com/phillipdavidstearns/aYearInCode/blob/master/Processing%202.2.1/cellSort/cellSort.pde
 *
 * by Youssef Faltas, 2017
 * https://github.com/faltastic/cellsortGUI
 *
 */

////////////////////////////////////////////////////////////////
// 
// To add your own photo sets, place them in 
// the data folder and add their names here

String[] photoSets = {
 "egypt", "desert" // more albums here
};

// Each photo set may contain jpg photos of any size but they are 
// to be named "poly0.jpg", "poly1.jpg", "poly2.jpg", and so on.

// That's it!

////////////////////////////////////////////////////////////////

import java.io.FilenameFilter;
import java.awt.Frame;
import java.awt.BorderLayout;
import controlP5.*;
import java.util.*;

private ControlP5 cp5;
ControlFrame cf;

PImage[] polySrc;
PImage source;
PImage output;
int higher=110;
int lower=190;
int type = 1;
int offset_x = 0;
int offset_y = 0;
int eval_mode = 0;
int mode = 0; //sets the threshold evaluation mode
boolean[][] rules;
int logic = 0;
int printFNum =0;
int nImg =0;
int totalImg =3;
int nSet=0;
int flipSpeed = 30;
boolean loaded = false;


// Control States 

boolean play = false;
boolean wrap = true;
boolean printFrame = false;  // P turns on/off print function
boolean pauseFlip = false;


void setup() {

  size(1080, 720);
  // alternative setup
  // size(source.width, source.height);
  
  cf = addControlFrame("Sort Control", 200, 650);
  setRules();
  selectSet(0);
  loadSrcs();
  loadSource();

  background(0);
  image(source, ( width-output.width)/2, 0);
}

void draw() {
  if (play && loaded) {

    if (frameCount%flipSpeed ==0 && !pauseFlip ) {
      nImg = (nImg+1)%totalImg;
      loadSource();
    }
    
    source.loadPixels();
    output = cellSort(source);
    output.updatePixels();
    background(0);
    image(output, ( width-output.width)/2, 0);

    if (printFrame) {
      println("printing");
      saveFrame("Prints/s"+printFNum +".tif");
      printFNum++;
    }
  }
}

// Loading images and image sets

void selectSet(int nSet) {
  loaded=false;
  File f = dataFile(photoSets[nSet]);
  String[] names = f.list(FILTER);
  println(names.length);
  totalImg = names.length;
  nImg=0;
  loadSrcs();
  loadSource();
}

void loadSrcs() {
  loaded=false;
  polySrc = new PImage[totalImg];
  for (int i=0; i<totalImg; i++) {
    polySrc[i] = loadImage(photoSets[nSet]+"/poly"+i+".jpg");
  }
}

void loadSource() {
  loaded=false;
  source = polySrc[nImg];
  source.resize(width, 0);
  output = source;
  imageMode(CENTER);
  background(0);
  image(source,width/2,height/2);
  //image(source, (width-source.width)/2, (height-source.height)/2);
  imageMode(CORNER);
  loaded = true;
}



static final FilenameFilter FILTER = new FilenameFilter() {
  static final String NAME = "poly", EXT = ".jpg";

  @ Override boolean accept(File path, String name) {
    return name.startsWith(NAME) && name.endsWith(EXT);
  }
};

void setRules() {
  rules = new boolean[3][3];
  rules[0][0]=false;
  rules[0][1]=false;
  rules[0][2]=false;
  rules[1][0]=false;
  rules[1][1]=false;
  rules[1][2]=false;
  rules[2][0]=false;
  rules[2][1]=false;
  rules[2][2]=false;
}

