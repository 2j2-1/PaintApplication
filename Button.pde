class Button{
	int x;
	int y;
	int sizeX;
	int sizeY;

	Button(int _x, int _y, int _sizeX, int _sizeY){
		x = _x;
		y = _y;
		sizeX = _sizeX;
		sizeY = _sizeY;
	}

	void display(PGraphics window){
		window.fill(buttonFill);
		window.rect(x,y,sizeX,sizeY);
	}

	boolean collide(){
		return (x<=mouseX&&x+sizeX>=mouseX&&y<mouseY-menu.menuHeight&&y>mouseY-menu.menuHeight-sizeY);
	}

}