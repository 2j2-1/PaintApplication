class Shape{
 int x1,x2,y1,y2,strokeWeight;
 String shapeName;
 color strokeColor;
 color fillColor;
 PImage imageOG;
 PImage image;
 boolean filled;
 PShape shape;
 float rotation = 0;
 float[][] matrix = null;
 float scale;
 int brightness = 0;
 int contrast = 0;

 
 Shape(int _x1, int _y1, int _x2, int _y2, String _shapeName, color _strokeColor,color _fillColor, int _strokeWeight, boolean _filled,int _brightness){
   x1 = _x1;
   x2 = _x2;
   y1 = _y1;
   y2 = _y2;
   shapeName = _shapeName;
   strokeColor = _strokeColor;
   fillColor = _fillColor;
   strokeWeight = _strokeWeight;
   filled = _filled;
   brightness = _brightness;
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
   for (int i = 0; i < _points.size();i+=1){
    shape.vertex(_points.get(i)[0]-x1,_points.get(i)[1]-y1);
    //shape.curveVertex(_points.get(i+1)[0]-x1,_points.get(i+1)[1]-y1);
   }
   if (filled)
     shape.endShape(CLOSE);
   else
     shape.endShape();
 }
 Shape(int _x1, int _y1, int _x2, int _y2, String _shapeName, String _image){
   x1 = _x1;
   y1 = _y1;
   shapeName = _shapeName;
   colorMode(RGB);
   image = loadImage(_image);
   x2 = _x2;
   y2 = _y2;
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
     if (matrix != null)
       pg.image(applybrightness(bilinear(x2,y2,convo(image,matrix)),brightness),x1,y1);
     else
       pg.image(applybrightness(bilinear(x2,y2,image),brightness),x1,y1);
   else{
     shape.setStroke(strokeColor);
     shape.setStrokeWeight(strokeWeight);
     if (!filled)
       shape.setFill(false);
     else
       shape.setFill(true);
     shape.setFill(fillColor);
     shape.translate(x2/2,y2/2);
     shape.rotate(rotation);
     shape.translate(-x2/2,-y2/2);
     colorMode(RGB);
     pg.shape(shape, x1, y1);
     shape.translate(x2/2,y2/2);
     shape.rotate(-rotation);
     shape.translate(-x2/2,-y2/2);
   }
   pg.endDraw();
 }
 
 
}