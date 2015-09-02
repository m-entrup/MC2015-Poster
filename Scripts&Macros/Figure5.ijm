if (!getBoolean("This macro will close all open images.\nDo you want to start the macro?")) {
	exit();
}
close("*");

input_path = getDirectory("Select the folder that contains the images");
output_path = getDirectory("Select the folder to save the output images");
var bgValue = 255;
var max = 800;
var lineWidth = 16;
var shiftX = 1536;
var shiftY = 1536;
var images = newArray("TEM_3.tif", "TEM_4.tif", "TEM_0.tif", "TEM_2.tif", "TEM_1.tif");

setBatchMode(true);
newImage("Figure5a", "32-bit black", 2048 + shiftX, 2048 + 4 * shiftY, 1);
var figure5a = getImageID();
setPasteMode("Copy");
run("Set...", "value=-12345");

for (var i = 0; i < 5; i+=2) {
	open(input_path + "QSinK7=0%\\Cal4\\" + images[i]);
	run("Line Width...", "line=" + 2*lineWidth);
	makeLine(1811, 0, 2265, 4095);
	run("Colors...", "foreground=white background=black selection=white");
	run("Add Selection...");
	id1 = getImageID();
	setMinAndMax(0, max);
	run("Flatten");
	id2 = getImageID();
	selectImage(id1);
	close();
	run("Bin...", "x=2 y=2 bin=Median");
	run("Copy");
	close();
	selectImage(figure5a);
	makeRectangle(0, i * shiftY, 2048, 2048);
	run("Paste");
}
for (var i = 1; i < 5; i+=2) {
	open(input_path + "QSinK7=0%\\Cal4\\" + images[i]);
	run("Line Width...", "line=" + 2*lineWidth);
	makeLine(1811, 0, 2265, 4095);
	run("Colors...", "foreground=white background=black selection=white");
	run("Add Selection...");
	id1 = getImageID();
	setMinAndMax(0, max);
	run("Flatten");
	id2 = getImageID();
	selectImage(id1);
	close();
	run("Bin...", "x=2 y=2 bin=Median");
	run("Copy");
	close();
	selectImage(figure5a);
	makeRectangle(shiftX, i * shiftY, 2048, 2048);
	run("Paste");
	setMinAndMax(0, 0.5*bgValue);
	run("Line Width...", "line=" + lineWidth);
	run("Draw");
}

run("Select None");
run("Macro...", "code=[if(v == -12345) v=" + bgValue + ";]");
setMinAndMax(0, bgValue);
setBatchMode("exit and display");
run("Out [-]");
if (getBoolean("Save the new image?")) {
	saveAs("PNG", output_path + "Figure5a.png");
}
close();

setBatchMode(true);
run("Image Sequence...", "open=" + input_path + "QSinK7=0%\\Cal4\\SR-EELS_0.tif number=5 starting=0 file=SR-EELS sort");
run("Remove Outliers...", "radius=8 threshold=50 which=Bright stack");
run("Remove Outliers...", "radius=8 threshold=50 which=Dark stack");
run("Z Project...", "projection=[Sum Slices]");
rename("Figure5b");
run("Log");
setMinAndMax(1.0000, 7);
setBatchMode("exit and display");
if (getBoolean("Save the new image?")) {
	saveAs("PNG", output_path + "Figure5b.png");
}
close("*");

setBatchMode(true);
run("Image Sequence...", "open=" + input_path + "QSinK7=-15%\\Cal4\\SR-EELS_0.tif number=5 starting=0 file=SR-EELS sort");
run("Remove Outliers...", "radius=8 threshold=50 which=Bright stack");
run("Remove Outliers...", "radius=8 threshold=50 which=Dark stack");
run("Z Project...", "projection=[Sum Slices]");
rename("Figure5c");
run("Log");
setMinAndMax(1.0000, 7);
setBatchMode("exit and display");
if (getBoolean("Save the new image?")) {
	saveAs("PNG", output_path + "Figure5c.png");
}
close("*");