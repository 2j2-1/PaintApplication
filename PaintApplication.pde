String[][] options = {{"File","New","Save","Delete"},{"Edit","Clear"}};
menuBar menu = new menuBar();
boolean activePage = false;
PGraphics page;
String deafultSaveLocation = "test.png";

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

void clearScreen(){
	if (activePage){
		page.background(backgroundColor);
	}
}

void newPage(int x,int y){
	page = createGraphics(x, y);
	page.beginDraw();
	page.background(255);
	page.endDraw();
}

void processOption(String s){
		switch (s) {
			case "Save":
				if (activePage){
	  				selectOutput("Select a folder to process:", "fileSelected");
					break;
				}
			case "Clear":
				clearScreen();
				break;
			case "New":
				newPage(min(width,700),min(correctedHeight,640));
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

void fileSelected(File selection) {
	if (selection == null) {
		println("Window was closed or the user hit cancel.");
	} else {
		page.save(selection.getAbsolutePath());
	}
}