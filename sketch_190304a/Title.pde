class Title extends Widget{
 int[] canvasSize = {x2,y2};
 int[] canvasRes = {x2,y2};
 int[] canvasPostion = {x1,y1};
 String s;
 int size;
 PFont myFont;
 
 Title(int _x1, int _y1, int _x2, int _y2,String _s,int _size){
   x1 = _x1;
   x2 = _x2;
   y1 = _y1;
   y2 = _y2;
   s = _s;
   size = _size;
   myFont = createFont("FreeMono", size);
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
   canvas.pg.fill(0);
   canvas.pg.textFont(myFont);
   canvas.pg.text(s,0,size);
   canvas.pg.endDraw();
   canvas.draw();
 }
}
