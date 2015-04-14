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
String language = "german";

import java.io.File;
File folder;

ArrayList<Spread> spreads = new ArrayList<Spread>();
int pageNumber = 0;

void setup(){
  
  mm = 8;
  margins = new int[4];
  margins[0] = 13*mm;
  margins[1] = 13*mm;
  margins[2] = 21*mm;
  margins[3] = 21*mm;
  gutter = 6*mm;
  
//  size(432*mm, 279*mm, PDF, language + "_spreads.pdf");
  size(432*mm, 279*mm);
  colorMode(RGB, 255, 255, 255, 100);
  
  imgBaseline = 172*mm;
  maxSizeFirstImage = new PVector(width/2 - margins[1] - margins[3],
                                  imgBaseline - margins[0]);
  maxWidthImages = (width/2 - margins[1] - margins[3] - 2*gutter)/3;
  
  pink = color(237, 24, 71, 65);
  
//  printArray(PFont.list());
  fontRegular = createFont("HelveticaNeue", 3*mm);
  fontBold = createFont("HelveticaNeue-Bold", 40*mm);
  
  java.io.File folder = new java.io.File(dataPath(""));
  
  String prevLetter = "a";
  StringList filenames = new StringList();
  
  // i = 1: skip .DS_Store
  for(int i = 1; i < folder.list().length; i++){
    
    String letter = folder.list()[i].substring(folder.list()[i].indexOf('_') + 1, folder.list()[i].indexOf('_') + 2);
    println(letter);
    if(!letter.equals(prevLetter)){
      println("ADD");
      spreads.add(new Spread(prevLetter, filenames));
      prevLetter = letter;
      filenames = new StringList();
    }

    filenames.append(folder.list()[i]);

    if(i == folder.list().length - 1){
      spreads.add(new Spread(prevLetter, filenames));
    }
  }  
//  debug();
//  println(spreads.size());
}

void draw(){
  background(255);

  spreads.get(pageNumber).display();
  
  // Tif?
  save(language + "_spreads_" + pageNumber + ".tif");
  
//  PGraphicsPDF pdf = (PGraphicsPDF) g;  // Get the renderer
  if(pageNumber < spreads.size() - 1){
//    pdf.nextPage();
    pageNumber ++;    
  }else{
    exit();
  }
  println(pageNumber);  
}

void debug(){
  for(int i = 0; i < spreads.size(); i++){
    println(spreads.get(i).letter);
    println(spreads.get(i).queries.size());
    for(int j = 0; j < spreads.get(i).queries.size(); j++){
      println(spreads.get(i).queries.get(j));
    }
  }
}

//void keyPressed(){
//  if(key == CODED){    
//    if(keyCode == LEFT || keyCode == UP){
//      pageNumber --;      
//    }else if(keyCode == RIGHT || keyCode == DOWN){      
//      pageNumber ++;
//    }
//    pageNumber = constrain(pageNumber, 0, spreads.size() - 1);
//  }
////  else if(key == ' '){
////    PGraphicsPDF pdf = (PGraphicsPDF) g;  // Get the renderer
////    pdf.nextPage();
////  }
//
//}
