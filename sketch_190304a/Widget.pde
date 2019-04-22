class Widget{
 int x1,x2,y1,y2;
 Canvas canvas;
 
 boolean collide(){
   return (mouseX >= x1 && mouseX <= x1+x2 && mouseY >= y1 && mouseY <= y1+y2);
 }
 
 void setup(){
  int[] canvasSize = {x2,y2};
  int[] canvasRes = {x2,y2};
  int[] canvasPostion = {x1,y1};
  canvas = new Canvas(canvasSize,canvasPostion,canvasRes);
  canvas.setup(); 
 }
 
 void run(){}
 
 void draw(){}
 
 void focus(){}
 
}
