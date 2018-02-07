class Hotpoint {
  PVector center;
  color fillColor;
  color strokeColor;
  AudioSnippet audio;
  
  int Size;
  int pointsIncluded;
  int maxPoints;
  boolean wasJustHit;
  int threshold;
  
  Hotpoint(float centerX,float centerY,float centerZ, int boxSize, String aud) {
    center = new PVector(centerX,centerY,centerZ);
    audio = minim.loadSnippet(aud);
    Size = boxSize;
    pointsIncluded = 0;
    maxPoints = 1000;
    threshold = 0;
    fillColor = strokeColor = color(random(255),random(255),random(255));
  }
  
  void setThreshold(int newThreshold) {
    threshold = newThreshold;
  }
  
  void setMaxPoints(int newMaxPoints) {
    maxPoints = newMaxPoints;
  }
  
  void setColor(float red, float blue, float green) {
    fillColor = strokeColor = color(red,blue,green);
  }
  
  boolean check(PVector Point) {
    boolean result = false;
    
    if(Point.x > center.x - Size/2 && Point.x < center.x + Size/2) {
      if(Point.y > center.y - Size/2 && Point.y < center.y + Size/2) {
        if(Point.z > center.z - Size/2 && Point.z < center.z + Size/2) {
            result = true;
            pointsIncluded++;
        }
      }
    }
  return result;
  }
  
  void Draw() {
    pushMatrix();
      translate(center.x,center.y,center.z);
     
      fill(red(fillColor),blue(fillColor),green(fillColor),
            255 * percentIncluded());
      stroke(red(strokeColor),blue(strokeColor),green(strokeColor),255);
      box(Size);
    popMatrix();
  }

  float hitVolumn() {
    return map(pointsIncluded,0,maxPoints,10,200);
  }
  
  float percentIncluded() {
    return map(pointsIncluded,0,maxPoints,0,1);
  }

  boolean currentlyHit() {
    return (pointsIncluded > threshold); 
  }
  
  boolean isHit() {
    //return currentlyHit() && !wasJustHit;
    if (currentlyHit()){
      audio.setGain(hitVolumn());
      audio.play();
    }
    else {
      audio.pause();
    }
    if (!audio.isPlaying()) {
      audio.rewind();
    }
    return true;
  }
  
    
    
    
//    void audioclip() {
//       if (testBox.currentlyHit()) {
//    volumn = Hotpoint.hitVolumn();
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
//    }
    
    
  void clear() {
    wasJustHit = currentlyHit();
    pointsIncluded = 0;
  }
}



