class Undo {

	ArrayList<PImage> pageBuffer= new ArrayList<PImage>();
	int undoDepth = 0;
	int undoLimit = pageBuffer.size();

	public Undo () {
		
	}

	void addPage(){
		println("Undobuffer now at", pageBuffer.size());
		pageBuffer.add(page.get());
		undoDepth+=1;
	}

	void reset(){
		println("Reset");
		pageBuffer.clear();
		addPage();
		undoDepth=0;
	}

	void rollBack(){
		println("Roll");
		page.beginDraw();
		page.clear();
		page.image(pageBuffer.get(undoDepth),0,0);
		page.endDraw();
	}

	void addUndo(){
	println("addUndo");
	if (activePage){
		if (undoDepth<pageBuffer.size()-1){
			int temp = pageBuffer.size()-1;
			for (int i = undoDepth; i < temp; i++) {
				pageBuffer.remove(pageBuffer.size()-1);
			}
		}


		// if (!pageEquals(pageBuffer.get(pageBuffer.size()-1),page.get())){
			addPage();
			
			// }
		}
	}

	void removeUndo(){
		println("removeundo");
		if (activePage){
			pageBuffer.remove(pageBuffer.size()-1);
		}
	}

	void undoRedo(int direction){
		println("undoredo",direction);
		undoDepth += direction;
		undoDepth = constrain(undoDepth, 0, pageBuffer.size()-1);
		println(undoDepth);
		rollBack();
		displayPage();	
	}

}


