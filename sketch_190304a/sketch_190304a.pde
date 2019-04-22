int[] canvasSize = {640,640};
int[] canvasRes = {640,640};
int[] canvasPostion = {30,30};
Canvas mainCanvas = new Canvas(canvasSize,canvasPostion,canvasRes);
UIManager uim = new UIManager();
boolean focusWindow = true;
String[][] ui = {
{"Title","Color Picker"},{"ColorPicker",""},{"colorButton","strokeColorPicker"},{"colorButton","fillColorPicker"},
{"Title","Line Width"},{"Slider","Line Width"},
{"Title","Drawing"},{"Button","Rect"},{"Button","Circle"},{"Button","Line"},
{"Title","Manipulation"},{"Button","Select"},{"Button","Move"},{"Button","Resize"},{"Button","Rotate"},{"Button","Delete"},
{"Title","File"},{"Button","Save"},{"Button","Load"},
{"Title","Fill Mode"},{"Button","Fill"},{"Button","Nofill"}
};

void settings(){
  size(900,700);
}
void setup() {
  println(PFont.list());
  mainCanvas.setup();
  mainCanvas.clear();
  uim.multiAdd(ui);
  uim.setup();
  
}

void draw() {
  mainCanvas.clear();
  uim.activity();
  mainCanvas.activity();
  mainCanvas.draw();
}

void f(File selection){
  if (selection != null){
   mainCanvas.file = selection.getAbsolutePath(); 
   mainCanvas.activeShapes.add(new Shape(0,0,100,100,"image",mainCanvas.file));
  }
  mainCanvas.file = null;
}

void folderSelected(File selection){
  if (selection != null){
   mainCanvas.pg.get().save(selection.getAbsolutePath()); 
  }
  mainCanvas.file = null;
}

void mousePressed() {
   focusWindow = true;
}
