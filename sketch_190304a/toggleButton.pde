class toggleButton extends Widget{
 int[] canvasSize = {x2,y2};
 int[] canvasRes = {x2,y2};
 int[] canvasPostion = {x1,y1};
 color c;
 String s;
 int size;
 colorButton cb;
 boolean active;
 boolean pressed = false;
 
 toggleButton(int _x1, int _y1, int _x2, int _y2,String _s,int _size){
   x1 = _x1;
   y1 = _y1;
   s = _s;
   size = _size;
   textSize(size);
   x2 = (int)textWidth(s)+size;
   y2 = int(size*1.5);
   cb = new colorButton(x1+x2-size/2,y1,size,size,s);
 }
 
 void setup(){
  int[] canvasSize = {x2,y2};
  int[] canvasRes = {x2,y2};
  int[] canvasPostion = {x1,y1};
  canvas = new Canvas(canvasSize,canvasPostion,canvasRes);
  canvas.setup(); 
  cb.setup();
 }
 
 void draw(){
   canvas.pg.beginDraw();
   canvas.pg.stroke(0);
   canvas.pg.textSize(size);
   canvas.pg.fill(0);
   canvas.pg.text(s,0,size);
   canvas.pg.endDraw();
   if (active)
     cb.c = color(0);
   else
     cb.c = color(255);
   cb.draw();
   canvas.draw();
 }
 
 void run(int mode){
   if (mode==0){
   switch(s){
     case "Edge":
         if (mainCanvas.focusShape != null && mainCanvas.focusShape.shapeName == "image"){
           if (mainCanvas.focusShape.matrix != edge_matrix){
             mainCanvas.focusShape.matrix = edge_matrix;
             active = true;
           }
           else{
             mainCanvas.focusShape.matrix = null;
             active = false;
           }
         }
         mainCanvas.mode = 0;
         break;
         
   case "Blur":
         if (mainCanvas.focusShape != null && mainCanvas.focusShape.shapeName == "image"){
           if (mainCanvas.focusShape.matrix != gaussianblur_matrix){
             mainCanvas.focusShape.matrix = gaussianblur_matrix;
             active = true;
           }
           else{
             mainCanvas.focusShape.matrix = null;
             active = false;
           }
         }
         mainCanvas.mode = 0;
         break;

   case "Sharpen":
         if (mainCanvas.focusShape != null && mainCanvas.focusShape.shapeName == "image"){
           if (mainCanvas.focusShape.matrix != sharpen_matrix){
             mainCanvas.focusShape.matrix = sharpen_matrix;
             active = true;
           }
           else{
             mainCanvas.focusShape.matrix = null;
             active = false;
           }
         }
         mainCanvas.mode = 0;
         break;
   }
   }
 }
}