class imageDrawing{
	
	ArrayList<String> options = new ArrayList<String>();
	int x;
	int y;
	int menuWidth = 200;
	int spacing = 30;
	boolean displayMenu = false;
	Slider alphaS = new Slider(0,spacing*2+menuWidth,menuWidth,"Alpha:",sideMenu,0,100);
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
		sideMenu.textAlign(LEFT, CENTER);


		sideMenu.text("Color Picker",0,0,menuWidth,spacing);
		sideMenu.loadPixels();
		colorMode(HSB, 100);
		for (int x = 0; x < menuWidth; x++){
			for (int y = 0; y < menuWidth; y++){
				sideMenu.pixels[x + (y+spacing)*menuWidth] = color(map(x,0,menuWidth,0,100),100,map(y,0,menuWidth,0,100));
			}
		}
		sideMenu.updatePixels();
		alphaS.display();
		sideMenu.endDraw();
		image(sideMenu,x,menu.menuHeight,menuWidth,correctedHeight);
	}

}