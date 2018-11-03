String[][] options = {{"File","New","Save","Delete"},{"Edit","Clear"}};
menuBar menu = new menuBar();

PGraphics page;


int x = 640;
int y = 640;



void settings(){
	size(x,y);
}
void setup(){
	menu.setup();
}

void draw(){
	background(backgroundColor);

	try{
		image(page,(width-page.width)/2,(height+menu.menuHeight-page.height)/2);
	}
	catch (Exception e){}

	menu.display();

	if (mousePressed){
		menu.collide(1);
	}
	if (menu.chosenOption!=null){
		processOption(menu.chosenOption);
		menu.chosenOption = null;
	}
	
	
}

void mouseClicked(){
	menu.collide(0);
}

void clearScreen(){
	background(0);
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
				println("File Saved");
				break;
			case "Clear":
				clearScreen();
				break;
			case "New":
				newPage(min(width,700),min(height-menu.menuHeight,640));
				break;
			case "Delete":
				page = null;
				break;
			default:
				println("Function not yet implemented");
				break;	
		}
	}