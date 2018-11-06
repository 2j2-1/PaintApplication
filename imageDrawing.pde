class imageDrawing{
	
	ArrayList<String> options = new ArrayList<String>();
	int xoff;
	int yoff;
	int menuWidth = 200;
	int spacing = 30;
	boolean displayMenu = false;
	Slider brightnessS = new Slider(0,spacing*2+menuWidth,menuWidth,"Brightness:",0,100,100);
	Slider brushSize = new Slider(0,spacing*3+menuWidth,menuWidth,"BrushSize:",0,200,StrokeWeight);
	imageDrawing(int _x, int _y) {
		xoff = _x;
		yoff = _y;
	}

	void display(PGraphics sM){
		sM.beginDraw();
		// sM.translate(0,20);
		sM.noStroke();
		sM.fill(menuFill);
		sM.rect(0,0,menuWidth,height);
		sM.fill(menuText);
		sM.textSize(textSize);
		sM.textAlign(LEFT, CENTER);


		sM.text("Color Picker",0,0,menuWidth,spacing);
		sM.loadPixels();
		colorMode(HSB, 100);
		for (int x = 0; x < menuWidth; x++){
			for (int y = 0; y < menuWidth; y++){
				sM.pixels[x + (y+spacing)*menuWidth] = color(map(x,0,menuWidth,0,100),map(y,0,menuWidth,0,100),brightnessS.value);
			}
		}
		sM.updatePixels();

		brightnessS.display(sM);
		brushSize.display(sM);
		
		sM.endDraw();

		if (brushSize.active){
			showStroke();
		}
		
		image(sM,xoff,yoff,menuWidth,sM.height);
	}

	void collide(PGraphics sM){
		if (mousePressed){
			if (mouseX<menuWidth && mouseY>spacing+yoff && mouseY<spacing+menuWidth+yoff && activeMenu == 1){
				updateColor();
			}
		}
		brushSize.collide(sM);
		brightnessS.collide(sM);
		StrokeWeight = brushSize.value;
	}

	void updateColor(){
		brushColor = color(map(mouseX,0,menuWidth,0,100),map(mouseY,spacing+yoff,menuWidth+spacing+yoff,0,100),brightnessS.value);
		showStroke();
	}

	void showStroke(){
		fill(brushColor);
		colorMode(RGB);
		stroke(brushColor);
		// strokeWeight(1);
		ellipse(width-100,100+yoff, StrokeWeight,StrokeWeight);
		noStroke();
	}
}
