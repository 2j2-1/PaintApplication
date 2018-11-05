// import processing.core.*;

class Slider{
	int x;
	int y;
	int length;
	String text;
	int value;
	int max;
	int min;
	boolean active = false;

	Slider(int _x,int _y, int _length, String _text, int _min,int _max,int _value) {
		x = _x;
		y = _y;
		length = _length;
		text = _text + " ";
		max = _max;
		min = _min;
		value = _value;
	}

	void display(PGraphics s){
		
		s.textAlign(LEFT, BOTTOM);
		s.fill(255);
		s.text(text + str(value),x,y);
		s.rect(x,y, length,10);
		s.fill(0);
		s.ellipse(map(value,min,max,0,s.width), y+5, 10, 10);
		if (active){
			value = int(map(mouseX,0,s.width,min,max));
			value = constrain(value,min,max);
		}
		
	}
	void collide(PGraphics s){
		if (mousePressed){
			if (dist(int(map(mouseX,0,s.width,min,max)), mouseY-menu.menuHeight, value, y+5)<5){
				active = true;
			}
		}
		else {
			active = false;
		}
	}

}