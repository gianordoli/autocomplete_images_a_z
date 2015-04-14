class Spread{
  String letter;
  StringList queries = new StringList();
  ArrayList<PImage> images = new ArrayList<PImage>();
  
  Spread(String _letter, StringList filenames){
    letter = _letter;
    for(int i = 0; i < filenames.size(); i++){
      images.add(loadImage(filenames.get(i)));
      String query = filenames.get(i).substring(filenames.get(i).indexOf('_') + 5, filenames.get(i).indexOf('.') - 1);
      print(query);
      query = query.replace('_', ' ');
      query = (i + 1) + ". " + query;
      queries.append(query);
    }
  }
  
  void display(){
  // IMAGES
    // First    
    float firstImgScale = 1;
//    if(images.get(0).width > maxSizeFirstImage.x){
      firstImgScale = maxSizeFirstImage.x/images.get(0).width;
//    }
    if(images.get(0).height * firstImgScale > maxSizeFirstImage.y){
      firstImgScale = maxSizeFirstImage.y/images.get(0).height;
    }

    image(images.get(0),
          width/2 - margins[1] - images.get(0).width * firstImgScale,
          imgBaseline - images.get(0).height * firstImgScale,
          images.get(0).width * firstImgScale,
          images.get(0).height * firstImgScale);
  
    // Series
    int imageX = margins[3];
    for(int i = 1; i < images.size(); i++){
      
      float imgScale = 1;
      if(images.get(i).width > maxWidthImages){
        imgScale = maxWidthImages/images.get(i).width;
      }
      
      float imageY = imgBaseline + gutter;
      if(4 <= i && i <= 6){
        imageY = imgBaseline - images.get(i).height * imgScale;
      }
      
      if(i == 4 || i == 7){
        imageX = width/2 + margins[1];    
      }
      
      image(images.get(i), imageX, imageY, images.get(i).width * imgScale, images.get(i).height * imgScale);
      imageX += images.get(i).width * imgScale + gutter;
    }    
    
  // FOOTER
    // Mask
    noStroke();
    fill(255);
    rect(0, height - margins[2], width, margins[2]);
    
    // text
    int footerX = margins[3];
    int footerY = height - margins[2];
    boolean isMiddle = false;
    fill(0);
    textFont(fontRegular);
    textAlign(LEFT, TOP);    
    for(int i = 0; i < queries.size(); i++){
      if(footerX + textWidth(queries.get(i)) > width/2 - margins[1] &&
         !isMiddle){
        footerX = width/2 + margins[1];
        isMiddle = true;
      }
      text(queries.get(i), footerX, footerY + 4*mm);
      footerX += textWidth(queries.get(i)) + 2*mm;
    }

//  // HEADER
//    // Rect
//    stroke(pink);
//    strokeWeight(2*mm);
//    noFill();
//    rect(margins[3] + 1*mm, margins[0] + 1*mm, 56*mm, 56*mm);
//  
//    // Type
//    noStroke();
//    fill(pink);  
//    textFont(fontBold);
//    textAlign(CENTER, CENTER);
//    text(letter.toUpperCase(), margins[3], margins[0] - 5*mm, 56*mm, 56*mm);  
  }
}
