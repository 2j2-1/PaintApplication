class Button extends Widget{
 int[] canvasSize = {x2,y2};
 int[] canvasRes = {x2,y2};
 int[] canvasPostion = {x1,y1};
 String s;
 PImage icon;
 
 Button(int _x1, int _y1, int _x2, int _y2,String _s){
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
  icon = loadImage(s+".png");
 }
 
 void draw(){
   canvas.pg.beginDraw();
   canvas.pg.scale((float)canvas.pg.width/icon.width);
   canvas.pg.image(icon,0,0);
   canvas.pg.endDraw();
   canvas.draw();
 }
 
 void run(int mode){
   if (mode == 1)
     uim.buttonHandler(s);
 }
}