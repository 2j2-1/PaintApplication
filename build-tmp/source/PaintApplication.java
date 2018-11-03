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

String[][] options = {{"File","New","Save","Delete"},{"Edit","Clear"}};
menuBar menu = new menuBar();
boolean activePage = false;
PGraphics page;
String deafultSaveLocation = "test.png";


int x = 640;
int y = 640;



public void settings(){
	// size(x,y);
	fullScreen();
}
public void setup(){
	menu.setup();
}

public void draw(){
	background(backgroundColor);

	if(activePage){
		image(page,(width-page.width)/2,(height+menu.menuHeight-page.height)/2);
	}

	menu.display();

	if (menu.chosenOption!=null){
		processOption(menu.chosenOption);
		menu.chosenOption = null;
	}
	
	
}

public void mouseClicked(){
	menu.collide();
}

public void clearScreen(){
	if (activePage){
		page.background(backgroundColor);
	}
}

public void newPage(int x,int y){
	page = createGraphics(x, y);
	page.beginDraw();
	page.background(255);
	page.endDraw();
}

public void processOption(String s){
		switch (s) {
			case "Save":
				if (activePage){
				println("File Saved");
				page.save(deafultSaveLocation);
				}
				break;
			case "Clear":
				clearScreen();
				break;
			case "New":
				newPage(min(width,700),min(height-menu.menuHeight,640));
				activePage = true;
				break;
			case "Delete":
				page = null;
				activePage = false;
				break;
			default:
				println("Function not yet implemented");
				break;	
		}
	}
// Main windows background color
int backgroundColor = color(100);

// MenuBar colors
int menuHighlight = color(120);
int menuFill = color(50);
int menuText = color(255);
class menuBar{
	
	int spacing = 50;
	int menuHeight = 20;
	boolean active = false;
	int activeOption = -1;
	int menuBarOption;
	String chosenOption = null;
	int textSize = 16;
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
		if (mouseY<=20 && active){
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
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--present", "--window-color=#666666", "--hide-stop", "PaintApplication" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
