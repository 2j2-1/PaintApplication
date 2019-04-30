int[] canvasSize = {840,840};
int[] canvasRes = {840,840};
int[] canvasPostion = {30,30};
Canvas mainCanvas = new Canvas(canvasSize,canvasPostion,canvasRes);
UIManager uim = new UIManager();
boolean focusWindow = true;
String[][] ui = {
{"Title","Color Picker"},{"ColorPicker",""},{"colorButton","strokeColorPicker"},{"colorButton","fillColorPicker"},
{"Title","Line Width"},{"Slider","Line Width"},
{"Title","Drawing"},{"Button","Rect"},{"Button","Circle"},{"Button","Line"},
{"Title","Manipulation"},{"Button","Select"},{"Button","Move"},{"Button","Resize"},{"Button","Rotate"},{"Button","Delete"},{"Button","BlackWhite"},{"Button","GreyScale"},
{"Title","File"},{"Button","Save"},{"Button","Load"},
{"Title","Fill Mode"},{"Button","Fill"},{"Button","Nofill"},
{"Title","Filters"},{"toggleButton","Edge"},{"toggleButton","Blur"},{"toggleButton","Sharpen"},
{"Title","Brightness"},
};

void settings(){
  size(1100,900);
}
void setup() {
  mainCanvas.setup();
  mainCanvas.clear();
  uim.multiAdd(ui);
  uim.add("Slider","Brightness",-100,100);
  uim.setup();
  
}

void draw() {
  mainCanvas.clear();
  uim.draw();
  uim.activity(1);
  mainCanvas.activity();
  mainCanvas.draw();
}

void f(File selection){
  if (selection != null){
   mainCanvas.file = selection.getAbsolutePath(); 
   mainCanvas.activeShapes.add(new Shape(0,0,100,100,"image",mainCanvas.file));
  }
  mainCanvas.file = null;
  
  //focusWindow = true;
}

void folderSelected(File selection){
  focusWindow = true;
  mainCanvas.drawShapes();
  if (selection != null){
   mainCanvas.pg.get().save(selection.getAbsolutePath()); 
  }
  mainCanvas.file = null;
}

void mousePressed() {
   focusWindow = true;
}

void mouseClicked(){
  uim.activity(0);
}