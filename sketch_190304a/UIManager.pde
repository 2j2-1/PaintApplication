class UIManager{
 ArrayList<Widget> widgets = new ArrayList<Widget>();
 int x = 0;
 int y = 0;
 int offsetY = 30;
 int padding = 10;
 int offsetX = canvasSize[0]+canvasPostion[0]+padding;
 int col = 4;
 int buttonSize = 30;
 int sliderSize = 10;
 int textSize = 20;
 int colorPickerSize = 170;
 void setup(){
   for (Widget widget : widgets){
    widget.setup(); 
   }
 }
 void multiAdd(String[][] s){
   for (int i = 0; i < s.length;i++){
    add(s[i][0],s[i][1]); 
   }
 }
 void add(String widgetName, String s){
   switch(widgetName){
     case "Button":
       uim.widgets.add(new Button(offsetX+x,offsetY+y,buttonSize,buttonSize,s));
       if (x >= buttonSize*(col-1)){
         x = 0;
         y+=buttonSize+padding;
       }
       else
         x+=buttonSize+padding;
       break;
     case "colorButton":
       uim.widgets.add(new colorButton(offsetX+x,offsetY+y,buttonSize,buttonSize,s));
       if (x >= buttonSize*(col-1)){
         x = 0;
         y+=buttonSize+padding;
       }
       else
         x+=buttonSize+padding;
       break;
     case "toggleButton":
     if (x>0){
        x = 0;
        y+=buttonSize+padding;
       }
       uim.widgets.add(new toggleButton(offsetX+x,offsetY+y,buttonSize,buttonSize,s,16));
       y+=16+padding/2;
       break;
     case "Title":
       if (x>0){
        x = 0;
        y+=buttonSize+padding;
       }
       uim.widgets.add(new Title(offsetX+x,offsetY+y,300,300,s,textSize));
       y+=textSize+padding;
       break;
     case "ColorPicker":
       if (x>0){
        x = 0;
        y+=30+padding;
       }
       uim.widgets.add(new ColorPicker(offsetX+x,offsetY+y,colorPickerSize,colorPickerSize));
       y+=colorPickerSize+padding;
       break;
     case "Slider":
       if (x>0){
        x = 0;
        y+=buttonSize+padding;
       }
       uim.widgets.add(new Slider(offsetX+x,offsetY+y,colorPickerSize,sliderSize,s,0,100,mainCanvas.strokeWeight));
       y+=sliderSize+padding;
       break;
   }
 }
 void add(String widgetName, String s,int min, int max){
   switch(widgetName){
     case "Slider":
         if (x>0){
            x = 0;
            y+=buttonSize+padding;
         }
         uim.widgets.add(new Slider(offsetX+x,offsetY+y,colorPickerSize,sliderSize,s,min,max,0));
         y+=sliderSize+padding;
         break;
     }
 }
 void draw(){
   for (Widget widget : widgets){
     widget.draw();
   }
 }
 void activity(int mode){
   for (Widget widget : widgets){
    if(widget.collide() && focusWindow && (mousePressed||mode==0)){
      
      widget.focus();
      widget.run(mode);
    }
   }
 }
 
 void buttonHandler(String s){
   switch (s){
     case "Draw":
       mainCanvas.mode = 1;
       mainCanvas.focusShape = null;
       break;
     case "Rect":
       mainCanvas.mode = 2;
       mainCanvas.shapeName = "rect";
       mainCanvas.focusShape = null;
       break;
     case "Circle":
       mainCanvas.mode = 2;
       mainCanvas.shapeName = "circle";
       mainCanvas.focusShape = null;
       break;
     case "Line":
       mainCanvas.mode = 1;
       //mainCanvas.shapeName = "line";
       //mainCanvas.focusShape = null;
       break;
     case "Select":
       mainCanvas.mode = 0;
       mainCanvas.focusShape = null;
       break;
     case "Move":
       mainCanvas.mode = 3;
       break;
     case "Resize":
       mainCanvas.mode = 4;
       break;
     case "Load":
       mainCanvas.mode = 0;
       focusWindow=false;
       selectInput("Select a file to process","f");
       break;
     case "Save":
       mainCanvas.mode = 0;
       focusWindow=false;
       selectOutput("Select a folder to process:", "folderSelected");
       break;
     case "Fill":
       if (mainCanvas.focusShape == null)
         mainCanvas.shapeFilled = true;
       else
         mainCanvas.focusShape.filled = true;
       break;
     case "Nofill":
       if (mainCanvas.focusShape == null)
         mainCanvas.shapeFilled = false;
       else
         mainCanvas.focusShape.filled = false;
       break;
     case "strokeColorPicker":
       mainCanvas.colorPickerChoice = true;
       break;
     case "fillColorPicker":
       mainCanvas.colorPickerChoice = false;
       break;
     case "Rotate":
       mainCanvas.mode = 5;
       break;
     case "Delete":
       if (mainCanvas.focusShape != null){
         for (int i = 0; i < mainCanvas.activeShapes.size();i++){
          if (mainCanvas.activeShapes.get(i) == mainCanvas.focusShape){
            mainCanvas.focusShape = null;
            mainCanvas.activeShapes.remove(i);
          }
         }
       }
       mainCanvas.mode = 0;
       break;
     case "GreyScale":
       colorMode(RGB);
       if (mainCanvas.focusShape != null && mainCanvas.focusShape.shapeName == "image"){
         for (int y = 0; y < mainCanvas.focusShape.image.height; y++) {
          for (int x = 0; x < mainCanvas.focusShape.image.width; x++){
            color thisPix = mainCanvas.focusShape.image.get(x,y);
            int r = (int) red(thisPix);
            int g = (int) green(thisPix);
            int b = (int) blue(thisPix);
            color newColour = color((g+r+b)/3);
            mainCanvas.focusShape.image.set(x,y, newColour);
          }
        }
       }
       break;
       case "BlackWhite":
       colorMode(RGB);
       if (mainCanvas.focusShape != null && mainCanvas.focusShape.shapeName == "image"){
         for (int y = 0; y < mainCanvas.focusShape.image.height; y++) {
          for (int x = 0; x < mainCanvas.focusShape.image.width; x++){
            color thisPix = mainCanvas.focusShape.image.get(x,y);
            int r = (int) red(thisPix);
            int g = (int) green(thisPix);
            int b = (int) blue(thisPix);
            color newColour = color(255,255,255);
            if((g+r+b)/3<50){
               newColour = color(0,0,0);
            }
            else{
             newColour = color(255,255,255); 
            }
           
            mainCanvas.focusShape.image.set(x,y, newColour);
          }
        }
       }
       break;
    case "PointProcessing":
     if (mainCanvas.focusShape != null && mainCanvas.focusShape.shapeName == "image"){
       mainCanvas.focusShape.brightness += 10;
       colorMode(RGB);
     }
     break;
   }
 }
}