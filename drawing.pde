void drawPage(int drawingType){
	
	switch (drawingType) {
		case 0:
			painting();
			break;
		case 1:
			shape(shapeType,false);

	}

}

void shape(int mode,boolean fill){
	if (points.size() > 0){
		if (mouseX-pageOffset[0]!=pmouseX-pageOffset[0]||mouseY-pageOffset[1]!=pmouseY-pageOffset[1]){
			undo.rollBack();
			page.beginDraw();
			page.stroke(brushColor);
			page.strokeWeight(StrokeWeight);
			if (!fill){
			page.noFill();
			}
			chooseShape(mode);
			page.endDraw();
		    undo.addUndo();
		}
	}
}

void chooseShape(int mode){
	int correctedX = mouseX-pageOffset[0];
	int correctedY = mouseY-pageOffset[1];
	switch (mode) {
		case 0:
			page.rect(points.get(0)[0],points.get(0)[1],correctedX-points.get(0)[0],correctedY-points.get(0)[1]);
			break;
		case 1:
			polygon(false);
			break;
		case 2:
			page.triangle((points.get(0)[0]+correctedX)/2,points.get(0)[1],points.get(0)[0],correctedY,correctedX,correctedY);
			break;
		case 3:
			page.ellipse(points.get(0)[0],points.get(0)[1], dist(points.get(0)[0],points.get(0)[1],correctedX,correctedY)*2, dist(points.get(0)[0],points.get(0)[1],correctedX,correctedY)*2);
			break;


	}
	
}

void painting(){
	if (mousePressed){
		if (mouseX-pageOffset[0]!=pmouseX-pageOffset[0]||mouseY-pageOffset[1]!=pmouseY-pageOffset[1]){
		page.beginDraw();
		page.stroke(brushColor);
		page.strokeWeight(StrokeWeight);
		page.line(mouseX-pageOffset[0],mouseY-pageOffset[1],pmouseX-pageOffset[0],pmouseY-pageOffset[1]);
		page.endDraw();
		// addUndo();
		}
	}
}

void polygon(boolean fill){
		page.beginShape();
		for (int i = 0; i < points.size(); i++) {
			page.vertex(points.get(i)[0],points.get(i)[1]);
		}
		page.vertex(mouseX-pageOffset[0],mouseY-pageOffset[1]);

		if (!fill){
			page.endShape();
		}	
		else{
			page.endShape(CLOSE);
		}

}

void addPoint(){
	if (activePage){
		int[] temp = {mouseX-pageOffset[0],mouseY-pageOffset[1]};
		points.add(temp);
		// addUndo();
	}

} 