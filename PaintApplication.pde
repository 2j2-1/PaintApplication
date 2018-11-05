String[][] options = {{"File","New","Save","Save as","Delete"},{"Edit","Clear","Undo","Redo"},{"View","Drawing Menu"}};
int StrokeWeight = 10;
menuBar menu;
imageDrawing iD;
int activeMenu = 0;

boolean activePage = false;
PGraphics page;
PGraphics sideMenu;
PGraphics temp;
ArrayList<PImage> pageBuffer= new ArrayList<PImage>();
String deafultSaveLocation = null;

int correctedHeight;
boolean screenGrab = false;
int[] pageOffset = {0,0};
int pageWidth = 0;
int drawX = 500;
int drawY = 500;

int textSize = 16;

int drawingType = 1;
int undoDepth = 0;
int undoLimit = 10;

ArrayList<int[]> points = new ArrayList<int[]>();

void settings(){
	fullScreen();
	// size(640,640);
}
void setup(){
	menu = new menuBar();
	menu.setup();
	iD = new imageDrawing(0,menu.menuHeight);
	correctedHeight = height - menu.menuHeight;
	sideMenu = createGraphics(iD.menuWidth,correctedHeight);

}

void draw(){
	background(backgroundColor);
	displayPage();
	displaySideMenu(sideMenu);
	
	

	menu.display();
	if (menu.chosenOption!=null){
		processOption(menu.chosenOption);
		menu.chosenOption = null;
	}
	iD.collide(sideMenu);
	println(undoDepth,pageBuffer.size());
	pageCollide();
}

void mouseClicked(){
	if (mouseButton == LEFT){
		if (!screenGrab){
			menu.collide();
			iD.collide(sideMenu);
			if (pageCollide()){
				addPoint();
			}
		}
	}
	else if (mouseButton == RIGHT){
		points.clear();
		undoDepth-=1;
		page.beginDraw();
		page.image(pageBuffer.get(undoDepth),0,0);
		page.endDraw();
		removeUndo();
		// drawingType = 0;
	}
}

void mouseReleased(){
	if (pageCollide()){
		addUndo();
	}
}

boolean pageEquals(PImage x,PImage y){
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

void addUndo(){
	if (activePage){
		if (!pageEquals(pageBuffer.get(pageBuffer.size()-1),page.get())){
			pageBuffer.add(page.get());
			undoDepth+=1;

		}
	}
}

void removeUndo(){
	if (activePage){
		pageBuffer.remove(pageBuffer.size()-1);
	}
}

boolean pageCollide(){
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