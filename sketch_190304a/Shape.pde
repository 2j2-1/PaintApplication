class Shape{
 int x1,x2,y1,y2,strokeWeight;
 String shapeName;
 color strokeColor;
 color fillColor;
 PImage image;
 boolean filled;
 PShape shape;

 
 Shape(int _x1, int _y1, int _x2, int _y2, String _shapeName, color _strokeColor,color _fillColor, int _strokeWeight, boolean _filled){
   x1 = _x1;
   x2 = _x2;
   y1 = _y1;
   y2 = _y2;
   shapeName = _shapeName;
   strokeColor = _strokeColor;
   fillColor = _fillColor;
   strokeWeight = _strokeWeight;
   filled = _filled;
   switch (shapeName){
     case "rect":
       shape = createShape(RECT, 0, 0, x2, y2);
       break;
     case "circle":
       shape = createShape(ELLIPSE, x2/2, y2/2, x2, y2);
       break;
   }
   
 }
 Shape(String _shapeName, color _strokeColor,color _fillColor, int _strokeWeight, boolean _filled,ArrayList<int[]> _points){
   x1 = _points.get(0)[0];
   y1 = _points.get(0)[1];
   x2 = -1;
   y2 = -1;
   shapeName = _shapeName;
   strokeColor = _strokeColor;
   fillColor = _fillColor;
   strokeWeight = _strokeWeight;
   filled = _filled;
   for (int[] point:_points){
    x1 = min(x1,point[0]);
    y1 = min(y1,point[1]);
   }
   for (int[] point:_points){
    x2 = max(x2,point[0]-x1);
    y2 = max(y2,point[1]-y1);
   }
   shape = createShape();
   shape.beginShape();
   for (int[] point:_points){
    shape.vertex(point[0]-x1,point[1]-y1);
   }
   if (filled)
     shape.endShape(CLOSE);
   else
     shape.endShape();
 }
 Shape(int _x1, int _y1, int _x2, int _y2, String _shapeName, String _image){
   x1 = _x1;
   x2 = _x2;
   y1 = _y1;
   y2 = _y2;
   shapeName = _shapeName;
   image = loadImage(_image);
 }
 
 void focus(PGraphics pg){
   pg.beginDraw();
   pg.strokeWeight(2);
   pg.noFill();
   pg.stroke(color(0));
   pg.rect(x1,y1,x2,y2);
   pg.endDraw();
 }
 
 
 void draw(PGraphics pg){
   pg.beginDraw();
   if (shapeName == "image")
     pg.image(image,x1,y1,x2,y2);
   else{
     shape.setStroke(strokeColor);
     shape.setStrokeWeight(strokeWeight);
     if (!filled)
       shape.setFill(false);
     else
       shape.setFill(true);
     shape.setFill(fillColor);
     pg.shape(shape, x1, y1);
   }
   pg.endDraw();
 }
 
 
}
