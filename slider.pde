// import processing.core.*;

class Slider{
	int x;
	int y;
	int length;
	String text;
	PGraphics window;
	int value = 0;
	int max;
	int min;

	Slider(int _x,int _y, int _length, String _text, PGraphics _window,int _min,int _max) {
		x = _x;
		y = _y;
		length = _length;
		text = _text + " ";
		window = _window;
		max = _max;
		min = _min;
	}

	void display(){
		value = constrain(value,min,max);
		sideMenu.textAlign(LEFT, BOTTOM);
		sideMenu.fill(255);
		sideMenu.text(text + str(value),x,y);
		sideMenu.rect(x,y, length,10);
		sideMenu.fill(0);
		sideMenu.ellipse(value, y+5, 10, 10);
	}
	void collide(){
		
	}

}