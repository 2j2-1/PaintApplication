class Slider extends Widget{
 int[] canvasSize;
 int[] canvasRes;
 int[] canvasPostion;
 String s;
 int value = 0;
 int min,max;
 
 Slider(int _x1, int _y1, int _x2, int _y2,String _s,int _min, int _max, int _value){
   x1 = _x1;
   x2 = _x2;
   y1 = _y1;
   y2 = _y2;
   s = _s;
   min = _min;
   max = _max;
   value = _value;
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
   canvas.pg.fill(255);
   canvas.pg.rect(0,0,x2,y2);
   canvas.pg.fill(0);
   canvas.pg.circle(map(value,min,max,0,y1),y2/2,y2);
   canvas.pg.endDraw();
   canvas.draw();
 }
 
 void run(){
  value = (int) map(mouseX-x1,0,y1,min,max);
  if (mainCanvas.focusShape == null){
     mainCanvas.strokeWeight = value;
   }
   else{
     mainCanvas.focusShape.strokeWeight = value;
   }
 }
}
