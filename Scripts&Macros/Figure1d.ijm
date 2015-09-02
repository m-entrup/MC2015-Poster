values = split(getArgument(), ";")
if (values.length == 2) {
	input_path = values[0];
	output_path = values[1];
} else {
	exit("Figure1b.ijm needs 2 arguments to run.");
}

open(input_path + "QSinK7=-15%\\prepared_corrected_Cal1.tif");
makeRectangle(0, 400, 4096, 3250);
run("Crop");
setMinAndMax(0, 370);
saveAs("PNG", output_path + "Figure1d.png");
close();