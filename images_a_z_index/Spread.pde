class Prediction{
  String letter;
  StringList queries = new StringList();
  
  Prediction(String _letter, StringList filenames){
    letter = _letter;
    for(int i = 0; i < filenames.size(); i++){
      String query = filenames.get(i).substring(filenames.get(i).indexOf('_') + 5, filenames.get(i).indexOf('.') - 1);
      print(query);
      query = query.replace('_', ' ');
      query = (i + 1) + ". " + query;
      queries.append(query);
    }
  }
  
  void display(float textX, float textY){

    // text
    String list = "";
    for(int i = 0; i < queries.size(); i++){
      list += queries.get(i) + "\n";
    }
//    println(list);
    fill(0);
    textAlign(LEFT, TOP);
    
    textFont(fontBold);
    text(letter.toUpperCase(), textX, textY);
    
    stroke(0);
    strokeWeight(0.25*mm);
    line(textX, textY + 1.25*gutter, textX + textBox.x, textY + 1.25*gutter);
    
    textFont(fontRegular);
    text(list, textX, textY + 1.5*gutter, textBox.x, textBox.y + gutter);
  }
}
