class menuBar{
	
	int spacing = 50;
	int menuHeight = 20;
	boolean active = false;
	int activeOption = -1;
	int menuBarOption;
	String chosenOption = null;
	
	menuBar () {
		
	}

	void setup(){
		noStroke();
	}

	void display(){
		fill(menuFill);
		rect(0,0,width,menuHeight);

		fill(menuText);
		textAlign(LEFT, CENTER);
		textSize(textSize);
		for (int i = 0; i < options.length; i++) {
			text(options[i][0],spacing*i,0,spacing,menuHeight);
		}
		if (mouseY<=menuHeight && active){
			menuBarOption = int(mouseX/spacing);
		}
		if (active && menuBarOption<options.length){
			displayOptions(menuBarOption);
		}
		
	}

	void collide(){

		if (mouseY<=20 ){
			active = !active;
		}

		else if (active && activeOption>0 && activeOption<options[menuBarOption].length){
			chosenOption = options[menuBarOption][activeOption];
			active = false;
		}
	}

	void displayOptions(int optionNumber){
		if (optionNumber<options.length){
			fill(menuFill);
			rect(optionNumber*spacing,0,spacing,menuHeight);
			fill(menuText);
			textAlign(LEFT, CENTER);
			text(options[optionNumber][0],spacing*optionNumber,0,spacing,menuHeight);
		}

		
		fill(menuFill);
		rect(optionNumber*spacing,menuHeight,spacing*3,(options[optionNumber].length-1)*menuHeight);
		
		activeOption = int(mouseY/menuHeight);
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

void clearScreen(){
	if (activePage){
		page.beginDraw();
		page.background(pageColor);
		page.endDraw();
	}
}

void newPage(int x,int y){
	page = createGraphics(x, y);
	page.beginDraw();
	page.background(255);
	page.endDraw();
	pageOffset[0] = (width-page.width)/2;
	pageOffset[1] =(height+menu.menuHeight-page.height)/2;
}

void processOption(String s){
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
				newPage(min(width,1900),min(correctedHeight,1000));
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
				break;
			default:
				println(s+" not yet implemented");
				break;	
		}
	}
void saveFile(){
	page.save(deafultSaveLocation);
}
void fileSelected(File selection) {
	if (selection == null) {
		println("Window was closed or the user hit cancel.");
	} else {
		deafultSaveLocation = selection.getAbsolutePath();
		page.save(deafultSaveLocation);
	}
}