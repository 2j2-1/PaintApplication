class Canvas{
 PGraphics pg;
 int x, y;
 int[] size = new int[2];
 int[] offset = new int[2];
 int[] res = new int[2];
 float[] scale = new float[2];
 color backGroundColor = color(255,255,255);
 int mode = 0;
 int strokeWeight = 20;
 color strokeColor = color(0);
 color fillColor = color(255);
 ArrayList<Shape> activeShapes = new ArrayList<Shape>();
 Shape focusShape = null;
 String shapeName;
 String file;
 boolean shapeFilled = true;
 boolean colorPickerChoice = true;
 ArrayList<int[]> points = new ArrayList<int[]>();
 
 
 Canvas(int[] _size, int[] _offset, int[] _res){
   size = _size;
   offset = _offset;
   res = _res;
   scale[0] = float(size[0])/res[0];
   scale[1] = float(size[1])/res[1];
 }
 
 void setup(){
  pg = createGraphics(res[0], res[1]);
 }
 
 void setBackgroundColor(color c){
  backGroundColor = c;
  clear();
 }
 
 void clear(){
  pg.beginDraw();
  pg.background(backGroundColor);
  pg.endDraw();
 }
 
 boolean collide(){
   return (mouseX() >= 0 && mouseX() <= pg.width && mouseY() >= 0 && mouseY <= pg.height);
 }
 
 void activity(){
   if (mousePressed && collide()){
     switch (mode){
      case 0:
        select();
        break;
      case 1:
        addLine();
        break;
      case 2:
        createShape();
        break;
      case 3:
        moveShape();
        break;
      case 4:
        resizeShape();
        break;
      case 5:
        rotateShape();
        break;
     }
   }
 }
 void addLine(){
   if (mouseButton == LEFT){
     int[] temp = {(int)mouseX(),(int)mouseY()};
     points.add(temp);
     pg.beginDraw();
     for(int i = 0; i<points.size()-1;i++){
       pg.line(points.get(i)[0],points.get(i)[1],points.get(i+1)[0],points.get(i+1)[1]);
     }
     pg.endDraw();
   } else{
     activeShapes.add(new Shape(shapeName,strokeColor,fillColor,strokeWeight,shapeFilled,points));
     mode = 0;
     points.clear();
   }
 }
 void select(){
   for (Shape s : activeShapes){
     if (mouseX() >= s.x1 && mouseX() <= s.x1+s.x2 && mouseY() >= s.y1 && mouseY() <= s.y1+s.y2){
       focusShape = s;
     }
   }
 }
 
 void moveShape(){
   if (mainCanvas.focusShape != null){
       mainCanvas.focusShape.x1 = (int)mouseX();
       mainCanvas.focusShape.y1 = (int)mouseY();
   }
 }
 
 void resizeShape(){
   float x,y;
   x = mouseX()-mainCanvas.focusShape.x1;
   y = mouseY()-mainCanvas.focusShape.y1;
   if (mainCanvas.focusShape != null && x>0 && y>0){
     if (mainCanvas.focusShape.shapeName != "image")
       mainCanvas.focusShape.shape.scale(x/mainCanvas.focusShape.x2,y/mainCanvas.focusShape.y2);
     mainCanvas.focusShape.x2 = max((int)x,1);
     mainCanvas.focusShape.y2 = max((int)y,1);
     
   }
 }
 void rotateShape(){
   if (mainCanvas.focusShape != null){
     if (mainCanvas.focusShape.shapeName != "image")
       mainCanvas.focusShape.shape.rotate(tan(mouseX()/mouseY()));
   }
 }
 
 void paint(){
  pg.beginDraw();
  pg.strokeWeight(strokeWeight);
  pg.stroke(strokeColor);
  pg.line(mouseX(), mouseY(), pmouseX(), pmouseY());
  pg.endDraw();   
 } 
 
 void drawShapes(){
  for (Shape shape : activeShapes){
    shape.draw(pg);
  }
 }
 
 void createShape(){
   activeShapes.add(new Shape((int)mouseX(),(int)mouseY(),100,100,shapeName,strokeColor,fillColor,strokeWeight,shapeFilled));
   mode = 0;
 }
 
  void createImage(){
   selectInput("Select a file to process","f");
   mode = 0;
  }
 
 void draw(){
  drawShapes();
  if (focusShape != null){
   focusShape.focus(pg); 
  }
  scale(scale[0],scale[1]);
  image(pg, offset[0]/scale[0], offset[1]/scale[1]); 
 }
 
 float mouseX(){
   return (mouseX-offset[0])/scale[0];
 }
 
 float mouseY(){
   return (mouseY-offset[1])/scale[1];
 }
 
 float pmouseX(){
   return (pmouseX-offset[0])/scale[0];
 }
 
 float pmouseY(){
   return (pmouseY-offset[1])/scale[1];
 }

}
