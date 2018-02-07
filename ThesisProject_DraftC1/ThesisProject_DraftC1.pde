import ddf.minim.*;
import ddf.minim.signals.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import processing.opengl.*;
import SimpleOpenNI.*;

SimpleOpenNI  kinect;
//declare two AudioSnippet objects this time
Minim minim;
//AudioSnippet kick;
//AudioSnippet snare;
//AudioSnippet click;
//AudioSnippet longer;
//AudioSnippet brockt;
//AudioSnippet men;
//AudioSnippet media;
//AudioSnippet stories;
//AudioSnippet sexed;

//declare our two hotpoint objects
Hotpoint snareTrigger;
Hotpoint kickTrigger;
Hotpoint testBox;
Hotpoint backleft;
Hotpoint educ;
//ArrayList<Hotpoint> hotpoints = new ArrayList<Hotpoint>();

float rotation = 0;

//this will be used for zooming
//start at normal
float s = 1;
float volumn;

void setup() {
   //initialize Minim and AudioPlayer
  minim = new Minim(this);
    //array of hotpoints media NOT WOKRING
//  hotpoints.add(new Hotpoint(-600, 0, 1000, 250, "hat.wav"));
//  hotpoints.add(new Hotpoint(-550, 0, 2500, 250, "Dark.mp3"));
//  hotpoints.add(new Hotpoint(500, 0, 2500, 250, "kick.wav");
//  ///delete below when done
//NOT WORKING


    snareTrigger = new Hotpoint(-600, 0, 1000, 250, "hat.wav");
 kickTrigger = new Hotpoint(-550, 0, 2500, 250, "hat.wav");
//  testBox = new Hotpoint(500, 0, 2500, 250); //middle box
//  backleft = new Hotpoint (650, 0, 1400, 250);
//  educ = new Hotpoint (0, 0, 2000, 250);
  
  size(1024, 768, OPENGL);
  kinect = new SimpleOpenNI(this);
  kinect.enableDepth();

  //this was done above when making hotpoints
//  snareTrigger.audio = minim.loadSnippet("hat.wav");
  //load two audio files //temp variables
//  AudioSnippet snare = minim.loadSnippet("hat.wav");
//  AudioSnippet kick = minim.loadSnippet("kick.wav");
//  AudioSnippet click = minim.loadSnippet("SnapClick.mp3");
//  AudioSnippet longer = minim.loadSnippet("Dark.mp3");
//  AudioSnippet brockt = minim.loadSnippet("brockt.mp3");
//  AudioSnippet men = minim.loadSnippet ("men.mp3");
//  AudioSnippet media = minim.loadSnippet ("media.mp3");
//  AudioSnippet stories = minim.loadSnippet ("Stories.mp3");
//  AudioSnippet sexed = minim.loadSnippet ("sexed.mp3");

////Then delete above
//  hotpoints.get(0).audio = minim.loadSnippet("hat.wav");
//  hotpoints.get(1).audio = minim.loadSnippet("hat.wav");
  
  //initialize hotpoints with their origins (x,y,z) and their size
  //stories
 

}

void draw() {
  background(0);
  kinect.update();

  translate(width/2, height/2, -1000);
  rotateX(radians(180)); //flip the y-axis from "realworld"

  //bumped up the traslation so that scale is better centered
  translate(0, 0, 1400);
  rotateY(radians(map(mouseX, 0, width, -180, 180)));

  //make everything bigger, ie zoom in
  translate(0, 0, s*-1000);
  scale(s);

  stroke(255);

  //get the depth data as 3D points
  
  PVector[] depthPoints = kinect.depthMapRealWorld();
 
  for (int i = 0; i < depthPoints.length; i+=10) {
    PVector currentPoint = depthPoints[i];


     snareTrigger.check(currentPoint);
    kickTrigger.check(currentPoint);
//    testBox.check(currentPoint);
//    backleft.check(currentPoint);
//    educ.check(currentPoint);
    point(currentPoint.x, currentPoint.y, currentPoint.z);
  }

  //println(backleft.pointsIncluded);

///delete after
//  if (testBox.currentlyHit()) {
//    volumn = testBox.hitVolumn();
//    media.setGain(volumn);
//    media.play();
//  }
//  else {
//    media.pause();
//  }
//
//  if (!media.isPlaying()) {
//    media.rewind();
//  }
///////////
//  if (backleft.currentlyHit()) {
//    volumn = backleft.hitVolumn();
//    brockt.setGain(volumn);
//   brockt.play();
//  }
//   else {
//   brockt.pause(); 
//   }
// 
//  if(!brockt.isPlaying()) {
//    brockt.rewind();
//  }
/////////
//
//  if (educ.currentlyHit()) {
//    volumn = educ.hitVolumn();
//    sexed.setGain(volumn);
//  sexed.play();
//  }
//  else {
//    sexed.pause();
//  }
//
//  if (!sexed.isPlaying()) {
//    sexed.rewind();
//  }
//  
//////////////////
//  if (snareTrigger.currentlyHit()) {
//    volumn = snareTrigger.hitVolumn();
//    men.setGain(volumn);
//    men.play();
//  }
//  else {
//    men.pause();
//  }
//
//  if (!men.isPlaying()) {
//    men.rewind();
//  }
//////////////////
//
//  if (kickTrigger.currentlyHit()) {
//    volumn = kickTrigger.hitVolumn();
//    stories.setGain(volumn);
//   stories.play();
//  }
//else {
//  stories.pause();
//}
//
//  if (!stories.isPlaying()) {
//   stories.rewind();
//  }
 
 snareTrigger.isHit();
//  //display each hotpoint and clear its points
 snareTrigger.Draw();
  snareTrigger.clear();
  
  kickTrigger.isHit();
 kickTrigger.Draw();
 kickTrigger.clear();
//
//  testBox.Draw();
//  testBox.clear();
//  
//  backleft.Draw();
//  backleft.clear();
//  
//  educ.Draw();
//  educ.clear();

  
  //ignore below
//  for ( Hotpoint h : hotpoints) {
//     h.isHit();
//     h.Draw(); 
//     h.clear();
//  }
}


void stop() {
 
  //make sure to close both Audio player objects
snareTrigger.audio.close();
 kickTrigger.audio.close();
  minim.stop();
  super.stop();
}

//use keys to control zoom; up-arrow zooms in; down-arrow zooms out
//s gets passed to scale() in draw()
void keyPressed() {
  if (keyCode == 38) {
    s = s + 0.01;
  }
  if (keyCode == 40) {
    s = s - 0.01;
  }
}

