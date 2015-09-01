values = split(getArgument(), ";")
if (values.length == 2) {
	input_path = values[0];
	output_path = values[1];
} else {
	exit("Figure1b.ijm needs 2 arguments to run.");
}

open(input_path + "EFTEM_FeCr.tif");
run("Scale...", "x=0.75 y=0.75 z=1.0 width=1536 height=1536 depth=2 interpolation=Bilinear average");
makeRectangle(255,255,1536,1536);
run("Crop");
setSlice(1);
setMinAndMax(0, 66);
setSlice(2);
setMinAndMax(0, 120);
run("RGB Color");
selectWindow("EFTEM_FeCr.tif");
close();
run("Colors...", "foreground=white background=black selection=yellow");
makePolygon(632,0,725,0,899,1535,800,1535);
run("Clear Outside");
run("Line Width...", "line=8");
makeLine(725,0,899,1535);
run("Fill");
makeLine(632,0,800,1535);
run("Fill");
saveAs("PNG", output_path + "Figure1b.png");
close();