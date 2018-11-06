void displayPage(){
	if(activePage){
		drawPage(drawingType);
		backGround.beginDraw();
		backGround.background(pageColor);
		backGround.image(page,0,0);
		backGround.endDraw();
		image(backGround,pageOffset[0],pageOffset[1]);
	
	}
}



void displaySideMenu(PGraphics sidemenu){
	if (activeMenu>0){
		pageOffset[0] = (width-pageWidth+iD.menuWidth)/2;
	} else {
		pageOffset[0] = (width-pageWidth)/2;
	}
	switch (activeMenu) {
		case 1:
			iD.display(sidemenu);
		break;	
	}
}
