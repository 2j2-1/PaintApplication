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

	void display(){
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