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

String[][] options = {{"File","New","Save","Save as","Delete"},{"Edit","Clear"},{"View","Drawing Menu"}};
menuBar menu = new menuBar();
imageDrawing iD = new imageDrawing(0,20);
int activeMenu = 0;

boolean activePage = false;
PGraphics page;
PGraphics sideMenu;
String deafultSaveLocation = null;

int correctedHeight;
boolean screenGrab = false;
int[] pageOffset = {0,0};

int textSize = 16;


public void settings(){
	// size(x,y);
	fullScreen();
	// size(640,640);
}
public void setup(){
	menu.setup();
	correctedHeight = height - menu.menuHeight;
	sideMenu = createGraphics(iD.menuWidth,correctedHeight);

}

public void draw(){
	background(backgroundColor);

	if(activePage){
		image(page,pageOffset[0],pageOffset[1]);
		if (mousePressed){
			page.beginDraw();
			page.stroke(10);
			page.strokeWeight(10);
			page.line(mouseX-pageOffset[0],mouseY-pageOffset[1],pmouseX-pageOffset[0],pmouseY-pageOffset[1]);
			page.endDraw();
		}
	}
	switch (activeMenu) {
		case 1:
			iD.display();
		break;
	}
	
	menu.display();

	if (menu.chosenOption!=null){
		processOption(menu.chosenOption);
		menu.chosenOption = null;
	}
	
	
}

public void mouseClicked(){
	if (!screenGrab){
		menu.collide();
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
class imageDrawing{
	
	ArrayList<String> options = new ArrayList<String>();
	int x;
	int y;
	int menuWidth = 200;
	boolean displayMenu = false;
	imageDrawing(int _x, int _y) {
		x = _x;
		y = _y;
	}

	public void display(){
		sideMenu.beginDraw();
		sideMenu.noStroke();
		sideMenu.fill(menuFill);
		sideMenu.rect(0,0,menuWidth,height);
		sideMenu.fill(menuText);
		sideMenu.textSize(textSize);
		sideMenu.textAlign(LEFT, TOP);
		sideMenu.text("Color Picker",0,0);
		sideMenu.endDraw();
		image(sideMenu,x,menu.menuHeight,menuWidth,correctedHeight);
	}

}
class menuBar{
	
	int spacing = 60;
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
		rect(optionNumber*spacing,menuHeight,spacing*2,(options[optionNumber].length-1)*menuHeight);
		
		activeOption = PApplet.parseInt(mouseY/menuHeight);
		if (activeOption>0 && activeOption<options[optionNumber].length){
			fill(menuHighlight);
			rect(spacing*optionNumber,activeOption*menuHeight,spacing*2,menuHeight);
		}

		fill(menuText);
		textAlign(LEFT, CENTER);

		for (int i = 1; i<options[optionNumber].length; i++){
			text(options[optionNumber][i],spacing*optionNumber,menuHeight*i,spacing*2,menuHeight);
		}
	}
	
}

public void clearScreen(){
	if (activePage){
		page.beginDraw();
		page.background(pageColor);
		page.endDraw();
	}
}

public void newPage(int x,int y){
	page = createGraphics(x, y);
	page.beginDraw();
	page.background(255);
	page.endDraw();
	pageOffset[0] = (width-page.width)/2;
	pageOffset[1] =(height+menu.menuHeight-page.height)/2;
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
				clearScreen();
				break;
			case "New":
				newPage(min(width,800),min(correctedHeight,800));
				activePage = true;
				break;
			case "Delete":
				page = null;
				activePage = false;
				break;
			case "Drawing Menu":
				if (activeMenu==1){
					activeMenu = 0;
				}
				else {
					activeMenu = 1;
				}
			default:
				println("Function not yet implemented");
				break;	
		}
	}
public void saveFile(){
	page.save(deafultSaveLocation);
}
public void fileSelected(File selection) {
	if (selection == null) {
		println("Window was closed or the user hit cancel.");
	} else {
		deafultSaveLocation = selection.getAbsolutePath();
		page.save(deafultSaveLocation);
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
