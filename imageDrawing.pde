class imageDrawing{
	
	ArrayList<String> options = new ArrayList<String>();
	int x;
	int y;
	int menuWidth = 200;
	int spacing = 30;
	boolean displayMenu = false;
	Slider brightnessS = new Slider(0,spacing*2+menuWidth,menuWidth,"Brightness:",sideMenu,0,100);
	Slider brushSize = new Slider(0,spacing*3+menuWidth,menuWidth,"BrushSize:",sideMenu,0,100);
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
		brightnessS.display();
		brushSize.display();
		sideMenu.endDraw();
		image(sideMenu,x,menu.menuHeight,menuWidth,correctedHeight);
	}

	void collide(int mode){
		if (mouseX<menuWidth && mouseY>menu.menuHeight+spacing && mouseY<spacing+menuWidth+menu.menuHeight && activeMenu == 1){

			
			brushColor = color(map(mouseX,0,menuWidth,0,100),100,map(mouseY-menu.menuHeight-spacing,0,menuWidth,0,100));
			fill(brushColor);
			stroke(1);
			ellipse(mouseX, mouseY, 10, 10);
			noStroke();
		}
	}

}