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


void settings(){
	// size(x,y);
	fullScreen();
	// size(640,640);
}
void setup(){
	menu.setup();
	correctedHeight = height - menu.menuHeight;
	sideMenu = createGraphics(iD.menuWidth,correctedHeight);

}

void draw(){
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

void mouseClicked(){
	if (!screenGrab){
		menu.collide();
	}
}

