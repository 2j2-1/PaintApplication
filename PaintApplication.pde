String[][] options = {{"File","New","Save","Save as","Delete"},{"Edit","Clear"}};
menuBar menu = new menuBar();
boolean activePage = false;
PGraphics page;
String deafultSaveLocation = null;

int correctedHeight;
boolean screenGrab = false;


void settings(){
	// size(x,y);
	fullScreen();
}
void setup(){
	menu.setup();
	correctedHeight = height - menu.menuHeight;
}

void draw(){
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

void mouseClicked(){
	if (!screenGrab){
		menu.collide();
	}
}

