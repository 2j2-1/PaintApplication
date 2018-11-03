class menuBar{
	
	int spacing = 50;
	int menuHeight = 20;
	boolean active = false;
	int activeOption = -1;
	int menuBarOption;
	String chosenOption = null;
	int textSize = 16;
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
		if (mouseY<=20 && active){
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
		rect(optionNumber*spacing,menuHeight,spacing*2,(options[optionNumber].length-1)*menuHeight);
		
		activeOption = int(mouseY/menuHeight);
		if (activeOption>0 && activeOption<options[optionNumber].length){
			fill(menuHighlight);
			rect(spacing*optionNumber,activeOption*menuHeight,spacing*2,menuHeight);
		}

		fill(menuText);
		textAlign(LEFT, CENTER);

		for (int i = 1; i<options[optionNumber].length; i++){
			text(options[optionNumber][i],spacing*optionNumber,menuHeight*i,spacing*2,menuHeight);
		}
	}
	
}