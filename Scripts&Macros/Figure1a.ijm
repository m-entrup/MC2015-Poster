values = split(getArgument(), ";")
if (values.length == 3) {
	fontSize = parseInt(values[0]);
	input_path = values[1];
	output_path = values[2];
} else {
	exit("Figure1a.ijm needs 3 arguments to run.");
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
run("Scale Bar...", "width=50 height=10 font="+fontSize+" color=White background=None location=[Lower Left]");
saveAs("PNG", output_path + "Figure1a.png");
close();