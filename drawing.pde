void drawPage(int drawingType){
	
	switch (drawingType) {
		case 0:
			painting();
			break;
		case 1:
			polygon(false);
			break;
		case 2:
			polygon(true);
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

	if (points.size() > 0){

		page.beginDraw();
		undo.rollBack();
		
		page.noFill();
		page.stroke(brushColor);
		page.strokeWeight(StrokeWeight);
		page.beginShape();
		for (int i = 0; i < points.size(); i++) {
			page.vertex(points.get(i)[0],points.get(i)[1]);
		}
		page.vertex(mouseX-pageOffset[0],mouseY-pageOffset[1]);
		if (!fill){
			page.endShape();
		}	else{
			page.endShape(CLOSE);
		}
		page.endDraw();

	}
}

void addPoint(){
	if (activePage){
		int[] temp = {mouseX-pageOffset[0],mouseY-pageOffset[1]};
		points.add(temp);
		// addUndo();
	}

} 