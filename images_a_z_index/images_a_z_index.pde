//PDF
import processing.pdf.*;

int mm;
int[] margins;
int gutter;
int imgBaseline;

PVector maxSizeFirstImage;
float maxWidthImages;
color pink;
PFont fontRegular;
PFont fontBold;
String language = "french";

import java.io.File;
File folder;

ArrayList<Prediction> predictions = new ArrayList<Prediction>();
PVector textBox;

void setup(){
  
  mm = 3;
  margins = new int[4];
  margins[0] = 13*mm;
  margins[1] = 13*mm;
  margins[2] = 21*mm;
  margins[3] = 21*mm;
  gutter = 5*mm;
  
  size(400*mm, 200*mm);
  colorMode(RGB, 255, 255, 255, 100);
  
  textBox = new PVector((width/2 - margins[1] - margins[3] - 4*gutter)/5.0,
                        (height - margins[0] - margins[2] - 2*gutter)/3.0);
  
//  printArray(PFont.list());
  fontRegular = createFont("HelveticaNeue", 2.5*mm);
  fontBold = createFont("HelveticaNeue-Bold", 4*mm);
  
  java.io.File folder = new java.io.File(dataPath(""));
  
  String prevLetter = "a";
  StringList filenames = new StringList();
  
  // i = 1: skip .DS_Store
  for(int i = 0; i < folder.list().length; i++){
    
    String letter = folder.list()[i].substring(folder.list()[i].indexOf('_') + 1, folder.list()[i].indexOf('_') + 2);
    println(letter);
    if(!letter.equals(prevLetter)){
      println("ADD");
      predictions.add(new Prediction(prevLetter, filenames));
      prevLetter = letter;
      filenames = new StringList();
    }

    filenames.append(folder.list()[i]);

    if(i == folder.list().length - 1){
      predictions.add(new Prediction(prevLetter, filenames));
    }
  }  
//  debug();
//  println(predictions.size());
}

void draw(){
  background(255);
  beginRecord(PDF, language + "_index.pdf");

  float textX = margins[3];
  float textY = margins[0];
  boolean isMiddle = false;
  
  for(int i = 0; i < predictions.size(); i++){
    predictions.get(i).display(textX, textY);
    textX += textBox.x + gutter;
    if(i != 0){
      if(i == 4 || i == 14 || i == 22){
        textX = width/2 + margins[1];
      }
      if(i == 9 || i == 17){
        textX = margins[3];
        textY += textBox.y + gutter;
      }    
    }
  }
  endRecord();
  noLoop();
}

void debug(){
  for(int i = 0; i < predictions.size(); i++){
    println(predictions.get(i).letter);
    println(predictions.get(i).queries.size());
    for(int j = 0; j < predictions.get(i).queries.size(); j++){
      println(predictions.get(i).queries.get(j));
    }
  }
}
