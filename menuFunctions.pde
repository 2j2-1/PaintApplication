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
				undoRedo(-1);
				break;

			case "Redo":
				undoRedo(1);
				break;

			default:
				println(s+" not yet implemented");
				break;	
		}
	}

void undoRedo(int direction){
	undoDepth += direction;
	undoDepth = constrain(undoDepth, 0, pageBuffer.size()-1);
	// pageBuffer.remove(pageBuffer.size()-1);
	page.beginDraw();
	page.image(pageBuffer.get(undoDepth),0,0);
	page.endDraw();
	displayPage();	
}

void clearPage(){
	if (activePage){
		page.beginDraw();
		page.background(pageColor);
		page.endDraw();
		backGround.beginDraw();
		backGround.background(pageColor);
		backGround.endDraw();
	}
}

void newPage(int x,int y){
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
	pageBuffer.clear();
	pageBuffer.add(page.get());
	undoDepth = 0;
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