import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class PaintApplication extends PApplet {

String[][] options = {{"File","New","Save","Save as","Delete"},{"Edit","Clear","Undo","Redo"},{"View","Drawing Menu"}};
int StrokeWeight = 10;
menuBar menu;
imageDrawing iD;
Undo undo;
int activeMenu = 0;

boolean activePage = false;
PGraphics page;
PGraphics sideMenu;
PGraphics backGround;
String deafultSaveLocation = null;

int correctedHeight;
boolean screenGrab = false;
int[] pageOffset = {0,0};
int pageWidth = 0;
int drawX = 500;
int drawY = 500;

int textSize = 16;

int drawingType = 1;
int shapeType = 0;

int[] clickStart = {-1,-1};
ArrayList<int[]> points = new ArrayList<int[]>();

public void settings(){
	// fullScreen();
	size(640,640);
}
public void setup(){
	menu = new menuBar();
	menu.setup();
	iD = new imageDrawing(0,menu.menuHeight);
	correctedHeight = height - menu.menuHeight;
	sideMenu = createGraphics(iD.menuWidth,correctedHeight);
	undo = new Undo();

}

public void draw(){
	background(backgroundColor);
	displayPage();
	displaySideMenu(sideMenu);
	menu.display();

	if (menu.chosenOption!=null){
		processOption(menu.chosenOption);
		menu.chosenOption = null;
	}
	iD.collide(sideMenu,0);
	// pageCollide(mouse);
	if (mousePressed && clickStart[0]==-1 && clickStart[1]==-1){
		clickStart[0] = mouseX;
		clickStart[1] = mouseY;
	}
}

public void mouseClicked(){
	if (mouseButton == LEFT){
		if (!screenGrab){
			menu.collide();
			iD.collide(sideMenu,1);
			if (pageCollide(mouseX,mouseY)){
				addPoint();
			}
		}
	}
	else if (mouseButton == RIGHT){
		points.clear();
		undo.rollBack();
		undo.rollBack();
		undo.removeUndo();
		undo.removeUndo();
		// drawingType = 0;
	}
}

public void mouseReleased(){
	if (pageCollide(mouseX,mouseY) || pageCollide(clickStart[0],clickStart[1])){
		undo.addUndo();
	}
	clickStart[0] = -1;
	clickStart[1] = -1;
}

public boolean pageEquals(PImage x,PImage y){
	PImage temp1 = x;
	PImage temp2 = y;

	temp1.loadPixels();
	temp2.loadPixels();
	for (int i = 0; i < temp1.pixels.length; ++i) {
		if (temp1.pixels[i] != temp2.pixels[i]){
			return false;
		}
	}
	return true;
}



public boolean pageCollide(int mouseX,int mouseY){
	if (activePage && !menu.active){
		return (mouseX>pageOffset[0] && mouseX<pageOffset[0]+drawX && mouseY>pageOffset[1] && mouseY<pageOffset[1]+drawY);
	}
	return false;
}
// float rmouseX(xoff){
// 	return mouseX - window.xoff;
// }

// float rmouseY(PGraphics window){
// 	return mouseY - window.yoff;
// }
class Button{
	int x;
	int y;
	int sizeX;
	int sizeY;

	Button(int _x, int _y, int _sizeX, int _sizeY){
		x = _x;
		y = _y;
		sizeX = _sizeX;
		sizeY = _sizeY;
	}

	public void display(PGraphics window){
		window.fill(buttonFill);
		window.rect(x,y,sizeX,sizeY);
	}

	public boolean collide(){
		return (x<=mouseX&&x+sizeX>=mouseX&&y<mouseY-menu.menuHeight&&y>mouseY-menu.menuHeight-sizeY);
	}

}
// Main windows background color
int backgroundColor = color(100);

// MenuBar colors
int menuHighlight = color(120);
int menuFill = color(50);
int menuText = color(255);

//Page Color
int pageColor = color(255);
int brushColor = color(0);

//Button
int buttonFill = color(40);
public void displayPage(){
	if(activePage){
		drawPage(drawingType);
		backGround.beginDraw();
		backGround.background(pageColor);
		backGround.image(page,0,0);
		backGround.endDraw();
		image(backGround,pageOffset[0],pageOffset[1]);
		for (int i = 0; i < undo.pageBuffer.size(); ++i) {
			image(undo.pageBuffer.get(i), 100, i*100,100,100);
		}
	
	}
}



public void displaySideMenu(PGraphics sidemenu){
	if (activeMenu>0){
		pageOffset[0] = (width-pageWidth+iD.menuWidth)/2;
	} else {
		pageOffset[0] = (width-pageWidth)/2;
	}
	switch (activeMenu) {
		case 1:
			iD.display(sidemenu);
		break;	
	}
}
public void drawPage(int drawingType){
	
	switch (drawingType) {
		case 0:
			painting();
			break;
		case 1:
			shape(shapeType,false);

	}

}

public void shape(int mode,boolean fill){
	if (points.size() > 0){
		if (mouseX-pageOffset[0]!=pmouseX-pageOffset[0]||mouseY-pageOffset[1]!=pmouseY-pageOffset[1]){
			undo.rollBack();
			page.beginDraw();
			page.stroke(brushColor);
			page.strokeWeight(StrokeWeight);
			if (!fill){
			page.noFill();
			}
			chooseShape(mode);
			page.endDraw();
		    undo.addUndo();
		}
	}
}

public void chooseShape(int mode){
	int correctedX = mouseX-pageOffset[0];
	int correctedY = mouseY-pageOffset[1];
	switch (mode) {
		case 0:
			page.rect(points.get(0)[0],points.get(0)[1],correctedX-points.get(0)[0],correctedY-points.get(0)[1]);
			break;
		case 1:
			polygon(false);
			break;
		case 2:
			page.triangle((points.get(0)[0]+correctedX)/2,points.get(0)[1],points.get(0)[0],correctedY,correctedX,correctedY);
			break;
		case 3:
			page.ellipse(points.get(0)[0],points.get(0)[1], dist(points.get(0)[0],points.get(0)[1],correctedX,correctedY)*2, dist(points.get(0)[0],points.get(0)[1],correctedX,correctedY)*2);
			break;


	}
	
}

public void painting(){
	if (mousePressed){
		if (mouseX-pageOffset[0]!=pmouseX-pageOffset[0]||mouseY-pageOffset[1]!=pmouseY-pageOffset[1]){
		page.beginDraw();
		page.stroke(brushColor);
		page.strokeWeight(StrokeWeight);
		page.line(mouseX-pageOffset[0],mouseY-pageOffset[1],pmouseX-pageOffset[0],pmouseY-pageOffset[1]);
		page.endDraw();
		// addUndo();
		}
	}
}

public void polygon(boolean fill){
		page.beginShape();
		for (int i = 0; i < points.size(); i++) {
			page.vertex(points.get(i)[0],points.get(i)[1]);
		}
		page.vertex(mouseX-pageOffset[0],mouseY-pageOffset[1]);

		if (!fill){
			page.endShape();
		}	
		else{
			page.endShape(CLOSE);
		}

}

public void addPoint(){
	if (activePage){
		int[] temp = {mouseX-pageOffset[0],mouseY-pageOffset[1]};
		points.add(temp);
		// addUndo();
	}

} 
class imageDrawing{
	
	ArrayList<String> options = new ArrayList<String>();
	int xoff;
	int yoff;
	int menuWidth = 200;
	int spacing = 30;
	int buttonSize = menuWidth/5;
	boolean displayMenu = false;
	int yLocation = spacing+menuWidth;
	Slider brightnessS = new Slider(0,setYLocation(spacing),menuWidth,"Brightness:",0,100,100);
	Slider brushSize = new Slider(0,setYLocation(spacing),menuWidth,"BrushSize:",0,200,StrokeWeight);
	Button brush = new Button(0,setYLocation(spacing),buttonSize,buttonSize);
	Button rectangle = new Button(buttonSize,brush.y,buttonSize,buttonSize);
	Button poly = new Button(buttonSize*2,brush.y,buttonSize,buttonSize);
	Button circle = new Button(buttonSize*3,brush.y,buttonSize,buttonSize);
	Button tri = new Button(buttonSize*4,brush.y,buttonSize,buttonSize);
	imageDrawing(int _x, int _y) {
		xoff = _x;
		yoff = _y;
	}

	public void display(PGraphics sM){
		sM.beginDraw();
		// sM.translate(0,20);
		sM.noStroke();
		sM.fill(menuFill);
		sM.rect(0,0,menuWidth,height);
		sM.fill(menuText);
		sM.textSize(textSize);
		sM.textAlign(LEFT, CENTER);


		sM.text("Color Picker",0,0,menuWidth,spacing);
		sM.loadPixels();
		colorMode(HSB, 100);
		for (int x = 0; x < menuWidth; x++){
			for (int y = 0; y < menuWidth; y++){
				sM.pixels[x + (y+spacing)*menuWidth] = color(map(x,0,menuWidth,0,100),map(y,0,menuWidth,0,100),brightnessS.value);
			}
		}
		sM.updatePixels();

		brightnessS.display(sM);
		brushSize.display(sM);
		brush.display(sM);
		rectangle.display(sM);
		poly.display(sM);
		circle.display(sM);
		tri.display(sM);
		brush.collide();
		rectangle.collide();
		poly.collide();
		circle.collide();
		tri.collide();
		sM.endDraw();

		if (brushSize.active){
			showStroke();
		}

		
		image(sM,xoff,yoff,menuWidth,sM.height);
	}

	public void collide(PGraphics sM,int mode){
		if (mousePressed){
			if (mouseX<menuWidth && mouseY>spacing+yoff && mouseY<spacing+menuWidth+yoff && activeMenu == 1){
				updateColor();
			}
		}
		brushSize.collide(sM);
		brightnessS.collide(sM);
		StrokeWeight = brushSize.value;
		if (mode == 1){
			updateDrawType();
		}

	}

	public void updateDrawType(){
		if(brush.collide()){
			drawingType = 0;
		}
		else if(rectangle.collide()){
			drawingType = 1;
			shapeType = 0;
		}
		else if(poly.collide()){
			drawingType = 1;
			shapeType = 1;
		}
		else if(tri.collide()){
			drawingType = 1;
			shapeType = 2;
		}
		else if(circle.collide()){
			drawingType = 1;
			shapeType = 3;
		}
		
	}

	public void updateColor(){
		brushColor = color(map(mouseX,0,menuWidth,0,100),map(mouseY,spacing+yoff,menuWidth+spacing+yoff,0,100),brightnessS.value);
		showStroke();
	}

	public void showStroke(){
		fill(brushColor);
		colorMode(RGB);
		stroke(brushColor);
		// strokeWeight(1);
		ellipse(width-100,100+yoff, StrokeWeight,StrokeWeight);
		noStroke();
	}

	public int setYLocation(int size){
		yLocation += size;
		return yLocation;
	}
}
class menuBar{
	
	int spacing = 50;
	int menuHeight = 20;
	boolean active = false;
	int activeOption = -1;
	int menuBarOption;
	String chosenOption = null;
	
	menuBar () {
		
	}

	public void setup(){
		noStroke();
	}

	public void display(){
		fill(menuFill);
		rect(0,0,width,menuHeight);

		fill(menuText);
		textAlign(LEFT, CENTER);
		textSize(textSize);
		for (int i = 0; i < options.length; i++) {
			text(options[i][0],spacing*i,0,spacing,menuHeight);
		}
		if (mouseY<=menuHeight && active){
			menuBarOption = PApplet.parseInt(mouseX/spacing);
		}
		if (active && menuBarOption<options.length){
			displayOptions(menuBarOption);
		}

	}

	public void collide(){
		if (mouseY<=20 ){
			active = !active;
		}

		else if (active && activeOption>0 && activeOption<options[menuBarOption].length){
			chosenOption = options[menuBarOption][activeOption];
			active = false;
		}
	}

	public void displayOptions(int optionNumber){
		if (optionNumber<options.length){
			fill(menuFill);
			rect(optionNumber*spacing,0,spacing,menuHeight);
			fill(menuText);
			textAlign(LEFT, CENTER);
			text(options[optionNumber][0],spacing*optionNumber,0,spacing,menuHeight);
		}

		
		fill(menuFill);
		rect(optionNumber*spacing,menuHeight,spacing*3,(options[optionNumber].length-1)*menuHeight);
		
		activeOption = PApplet.parseInt(mouseY/menuHeight);
		if (activeOption>0 && activeOption<options[optionNumber].length){
			fill(menuHighlight);
			rect(spacing*optionNumber,activeOption*menuHeight,spacing*3,menuHeight);
		}

		fill(menuText);
		textAlign(LEFT, CENTER);

		for (int i = 1; i<options[optionNumber].length; i++){
			text(options[optionNumber][i],spacing*optionNumber,menuHeight*i,spacing*3,menuHeight);
		}
	}
	
}
public void processOption(String s){
		switch (s) {
			case "Save as":
				if (activePage){
	  				selectOutput("Select a folder to process:", "fileSelected");
					break;
				}
			case "Save":
				if (activePage){
					if  (deafultSaveLocation!=null){
						saveFile();
					} else {
						processOption("Save as");
					}
				}
				break;
			case "Clear":
				clearPage();
				break;
			case "New":
				newPage(min(width,drawX),min(correctedHeight,drawY));
				activePage = true;
				break;
			case "Delete":
				page = null;
				activePage = false;
				pageWidth = 0;
				break;
			case "Drawing Menu":
				if (activeMenu==1){
					activeMenu = 0;
				}
				else {
					activeMenu = 1;
				}
				break;
			case "Undo":
				undo.undoRedo(-1);
				break;

			case "Redo":
				undo.undoRedo(1);
				break;

			default:
				println(s+" not yet implemented");
				break;	
		}
	}


public void clearPage(){
	if (activePage){
		page.beginDraw();
		page.background(pageColor);
		page.endDraw();
		backGround.beginDraw();
		backGround.background(pageColor);
		backGround.endDraw();
		undo.undoDepth=0;
	}
}

public void newPage(int x,int y){
	page = createGraphics(x, y);
	backGround = createGraphics(x, y);
	backGround.beginDraw();
	backGround.background(pageColor);
	backGround.endDraw();
	page.beginDraw();
	page.endDraw();
	pageOffset[0] = (width-page.width)/2;
	pageOffset[1] = (height+menu.menuHeight-page.height)/2;
	pageWidth = x;
	undo.reset();

}


public void saveFile(){
	page.save(deafultSaveLocation);
}
public void fileSelected(File selection) {
	if (selection == null) {
		println("Window was closed or the user hit cancel.");
	} 
	else {
		deafultSaveLocation = selection.getAbsolutePath();
		page.save(deafultSaveLocation);
	}
}
// import processing.core.*;

class Slider{
	int x;
	int y;
	int length;
	String text;
	int value;
	int max;
	int min;
	boolean active = false;

	Slider(int _x,int _y, int _length, String _text, int _min,int _max,int _value) {
		x = _x;
		y = _y;
		length = _length;
		text = _text + " ";
		max = _max;
		min = _min;
		value = _value;
	}

	public void display(PGraphics s){
		
		s.textAlign(LEFT, BOTTOM);
		s.fill(255);
		s.text(text + str(value),x,y);
		s.rect(x,y, length,10);
		s.fill(0);
		s.ellipse(map(value,min,max,0,s.width), y+5, 10, 10);
		if (active){
			value = PApplet.parseInt(map(mouseX,0,s.width,min,max));
			value = constrain(value,min,max);
		}
		
	}
	public void collide(PGraphics s){
		if (mousePressed){
			if (dist(PApplet.parseInt(map(mouseX,0,s.width,min,max)), mouseY-menu.menuHeight, value, y+5)<5){
				active = true;
			}
		}
		else {
			active = false;
		}
	}

}
class Undo {

	ArrayList<PImage> pageBuffer= new ArrayList<PImage>();
	int undoDepth = 0;
	int undoLimit = pageBuffer.size();

	public Undo () {
		
	}

	public void addPage(){
		pageBuffer.add(page.get());
		undoDepth+=1;
	}

	public void reset(){
		pageBuffer.clear();
		addPage();
		undoDepth=0;
	}

	public void rollBack(){
		if (undoDepth>0){
			undoDepth--;
			page.beginDraw();
			page.clear();
			page.image(pageBuffer.get(undoDepth),0,0);
			page.endDraw();

		}
	}

	public void addUndo(){
	if (activePage){
		if (undoDepth<pageBuffer.size()-1){
			int temp = pageBuffer.size()-1;
			for (int i = undoDepth; i < temp; i++) {
				pageBuffer.remove(pageBuffer.size()-1);
			}
		}


		// if (!pageEquals(pageBuffer.get(pageBuffer.size()-1),page.get())){
			addPage();
			
			// }
		}
	}

	public void removeUndo(){
		if (activePage){
			pageBuffer.remove(pageBuffer.size()-1);
		}
	}

	public void undoRedo(int direction){
		undoDepth += direction;
		undoDepth = constrain(undoDepth, 0, pageBuffer.size()-1);
		println(undoDepth);
		rollBack();
		displayPage();	
	}

}


  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--present", "--window-color=#666666", "--hide-stop", "PaintApplication" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
