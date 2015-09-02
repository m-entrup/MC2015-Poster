values = split(getArgument(), ";")
if (values.length == 2) {
	input_path = values[0];
	output_path = values[1];
} else {
	exit("Figure1b.ijm needs 2 arguments to run.");
}

open(input_path + "QSinK7=0%\\SR-EELS_SM125_0%_635eV_B1_45s.tif");
run("Remove Outliers...", "radius=5 threshold=100 which=Bright");
run("Remove Outliers...", "radius=5 threshold=100 which=Dark");
makeRectangle(0, 1575, 4096, 875);
run("Crop");
setMinAndMax(0, 1240);
saveAs("PNG", output_path + "Figure1c.png");
close();