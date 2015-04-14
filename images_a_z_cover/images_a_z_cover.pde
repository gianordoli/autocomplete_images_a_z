int mm;
int margin;
int gutter;
PVector imageSize;

String language = "french";

import java.io.File;
File folder;

PGraphics[] gMask;

void setup(){
  
  mm = 8;
  margin = 5*mm;
  gutter = margin;
  
  size(432*mm, 279*mm);
  colorMode(RGB, 255, 255, 255, 100);
  
  imageSize = new PVector((width/2 - 2*margin - 12*gutter)/13.0,
                          (height - 2*margin - 9*gutter)/10.0);
  
  java.io.File folder = new java.io.File(dataPath(""));
  
  gMask = new PGraphics[folder.list().length - 1];
  
  // i = 1: skip .DS_Store
  for(int i = 1; i < folder.list().length; i++){
    println(i);
    println(folder.list()[i]);
    PImage img = loadImage(folder.list()[i]);
    float imgScale = 1;
    imgScale = imageSize.y/img.height;
      
    gMask[i - 1] = createGraphics(int(imageSize.x), int(imageSize.y));
    //Drawing the mask;
    gMask[i - 1].beginDraw();
    gMask[i - 1].background(255);
    gMask[i - 1].fill(0);
//    gMask[i - 1].rect(0, 0, 100, 100);
    gMask[i - 1].image(img,
                   (imageSize.x - img.width * imgScale)/2, 0,
                   img.width * imgScale,
                   img.height * imgScale);
    gMask[i - 1].endDraw();     
  }  
//  println(gMask.length);
}

void draw(){
  background(255);
  float x = margin;
  float y = margin;
  for(int i = 0; i < gMask.length; i++){
    image(gMask[i], x, y);
    y += imageSize.y + gutter;
    if(y >= height - margin){
      y = margin;
      x += imageSize.x + gutter;
    }
    println(i);
    if(i == 129){
      x += gutter;
    }    
  }
  
  // Tif?
  save(language + "_cover.tif");
  noLoop();
}
