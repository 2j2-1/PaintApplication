run :
	/opt/processing/processing-java --sketch=$(PWD) --run

build :
	/opt/processing/processing-java --sketch=$(PWD) --output=$(PWD)/build-tmp/ --build


clean:
	rm -f -r build-tmp/