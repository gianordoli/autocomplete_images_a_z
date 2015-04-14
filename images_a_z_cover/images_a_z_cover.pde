int mm;
int[] margins = new int[4];
int gutter;
PVector imageSize;

String language = "french";

import java.io.File;
File folder;

PGraphics[] gMask;

void setup(){
  
  mm = 8;
  margins[0] = 5*mm;
  margins[1] = 78*mm;
  margins[2] = 5*mm;
  margins[3] = 5*mm;
  gutter = 3*mm;
  
  size(400*mm, 200*mm);
  colorMode(RGB, 255, 255, 255, 100);
  
  imageSize = new PVector((width - margins[1] - 3*margins[3] - 24*gutter)/26.0,
                          (height - margins[0]- margins[2] - 9*gutter)/10.0);
  
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
  float x = margins[3];
  float y = margins[0];
  for(int i = 0; i < gMask.length; i++){
    image(gMask[i], x, y);
    y += imageSize.y + gutter;
    if(y >= height - margins[2]){
      y = margins[0];
      x += imageSize.x + gutter;
    }
    println(i);
    if(i == 159){
      x = width/2 + margins[3];
    }    
  }
  
  // Tif?
  save(language + "_cover.tif");
  noLoop();
}
