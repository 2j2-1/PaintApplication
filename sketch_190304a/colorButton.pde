class colorButton extends Widget{
 int[] canvasSize = {x2,y2};
 int[] canvasRes = {x2,y2};
 int[] canvasPostion = {x1,y1};
 color c;
 String s;
 
 colorButton(int _x1, int _y1, int _x2, int _y2,String _s){
   x1 = _x1;
   x2 = _x2;
   y1 = _y1;
   y2 = _y2;
   s = _s;
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
   canvas.pg.noStroke();
   if (s=="strokeColorPicker"){
     if (mainCanvas.focusShape == null)
       canvas.pg.fill(mainCanvas.strokeColor);
     else 
       canvas.pg.fill(mainCanvas.focusShape.strokeColor);
   }
   else
     if (mainCanvas.focusShape == null)
       canvas.pg.fill(mainCanvas.fillColor);
     else 
       canvas.pg.fill(mainCanvas.focusShape.fillColor);
   canvas.pg.rect(0,0,x2,y2);
   canvas.pg.endDraw();
   canvas.draw();
 }
 
 void run(){
   uim.buttonHandler(s);
 }
}
