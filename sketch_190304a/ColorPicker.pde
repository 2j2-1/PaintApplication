class ColorPicker extends Widget{
 int[] canvasSize = {x2,y2};
 int[] canvasRes = {x2,y2};
 int[] canvasPostion = {x1,y1};
 
 
 ColorPicker(int _x1, int _y1, int _x2, int _y2){
   x1 = _x1;
   x2 = _x2;
   y1 = _y1;
   y2 = _y2;
   
 }
 
 void setup(){
  int[] canvasSize = {x2,y2};
  int[] canvasRes = {x2,y2};
  int[] canvasPostion = {x1,y1};
  canvas = new Canvas(canvasSize,canvasPostion,canvasRes);
  canvas.setup(); 
 }
 
 void draw(){
   canvas.pg.beginDraw();
   canvas.pg.loadPixels();
   colorMode(HSB, 100);
   for (int x = 0; x < x2; x++){
     for (int y = 0; y < y2; y++){
       if (mainCanvas.focusShape == null || mainCanvas.focusShape.shapeName == "image"){
         canvas.pg.pixels[x + (y)*x2] = color(map(x,0,x2,0,100),map(y,0,y2,0,100),map(mainCanvas.brightness,-100,100,0,100));
       }
       else{
         canvas.pg.pixels[x + (y)*x2] = color(map(x,0,x2,0,100),map(y,0,y2,0,100),map(mainCanvas.focusShape.brightness,-100,100,0,100));
       }
      }
    }
   canvas.pg.updatePixels();
   canvas.pg.endDraw();
   canvas.draw();
 }
 
 void run(int mode){
   colorMode(HSB, 100);
   if (mainCanvas.focusShape == null){
     if (mainCanvas.colorPickerChoice)
       mainCanvas.strokeColor = color(map(mouseX,x1,x1+x2,0,100),map(mouseY,y1,y1+y2,0,100),map(mainCanvas.brightness,-100,100,0,100));
     else
       mainCanvas.fillColor = color(map(mouseX,x1,x1+x2,0,100),map(mouseY,y1,y1+y2,0,100),map(mainCanvas.brightness,-100,100,0,100));
   }
   else{
     if (mainCanvas.colorPickerChoice)
       mainCanvas.focusShape.strokeColor = color(map(mouseX,x1,x1+x2,0,100),map(mouseY,y1,y1+y2,0,100),map(mainCanvas.focusShape.brightness,-100,100,0,100));
     else
       mainCanvas.focusShape.fillColor = color(map(mouseX,x1,x1+x2,0,100),map(mouseY,y1,y1+y2,0,100),map(mainCanvas.focusShape.brightness,-100,100,0,100));
   }
 }
}