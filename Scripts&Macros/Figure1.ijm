if (!getBoolean("This macro will close all open images.\nDo you want to start the macro?")) {
	exit();
}
close("*");
setBatchMode(true);
setPasteMode("Copy");

/*
 * How to get the correct font size?
 * The poster uses 72 dpi as reference and a font size of 26 pt.
 * The image is displayed with 239.7 dpi.
 * fontSize = 26 pt / 72 dpi * 233.7 dpi = 86.56 pt
 */
fontSize = 86;
script_path = getDirectory("Select the folder that contains the Scripts");
input_path = getDirectory("Select the folder that contains the images");
output_path = getDirectory("Select the folder to save the output images");
/*
 * runMacro() accepts a single parameter. A string is passed that contains several parameters delimited by semicolons.
 * The macro uses split(getArgument(), ";") to create an array containing the parameters.
 */
runMacro(script_path + "Figure1a.ijm", fontSize + ";" + input_path + ";" + output_path);
runMacro(script_path + "Figure1b.ijm", input_path + ";" + output_path);
runMacro(script_path + "Figure1c.ijm", input_path + ";" + output_path);
runMacro(script_path + "Figure1d.ijm", input_path + ";" + output_path);
width_full = 4096;
space_c_d = 64;
space_a_b = 128;
font_offset = 10;
height_filter = 600;

var img_a; var img_b; var img_c; var img_d;
var height_a; var height_c; var height_d; var width_a; var width_b;
openImages();

height_full = height_a + height_filter + height_c + space_c_d + height_d;
pos_a_x = 0; // round(0.5 * (width_full - width_a - width_b - space_a_b));
pos_b_x = pos_a_x + width_b + space_a_b;
offset_c = height_full - height_c - height_d - space_c_d;

setFont("Serif", fontSize, "antialiased");
newImage("Figure1", "RGB white", width_full, height_full, 1);

drawFilter(pos_b_x + width_b/2);
placeMaps();
placeSREELS();
drawEnergyScale();
/*
 * I can't pass arguments to a JavaScript file that is invoked by runMacro().
 * As a work arround it is checked, if Figure8.png exists.
 */
if (File.exists(output_path + "Figure8.png")) {
	placeLineScan();
} else {
	showMessage("Figure8 not found", "Figure8.png does not exist.\n" +
	"Skiping to place the inset.\n" +
	"Run Figure8.js to create the missing fille.");
}
run("Select None");
setBatchMode("exit and display");
if (getBoolean("Save the new image?\n(This will take a while...)")) {
	saveAs("PNG", output_path + "Figure1.png");
	showMessage("Image saved!");
}

function openImages() {
	open(output_path + "Figure1a.png");
	img_a = getImageID();
	width_a = getWidth;
	height_a = getHeight;
	open(output_path + "Figure1b.png");
	img_b = getImageID();
	width_b = getWidth;
	open(output_path + "Figure1c.png");
	img_c = getImageID();
	height_c = getHeight;
	open(output_path + "Figure1d.png");
	img_d = getImageID();
	height_d = getHeight;
}

function drawFilter(pos) {
	selectWindow("Figure1");
	run("Line Width...", "line=32");
	makeLine(pos, height_a, pos, height_a + height_filter/2);
	setForegroundColor(0, 0, 0);
	run("Fill");
	pos_start_x = round(height_a +  2 * height_filter/3);
	makeLine(pos, pos_start_x, pos + 200, offset_c + 16);
	setForegroundColor(255, 0, 0);
	run("Fill");
	makeLine(pos, pos_start_x, pos - 200, offset_c + 16);
	setForegroundColor(0, 0, 255);
	run("Fill");
	makeLine(pos, pos_start_x, pos, offset_c + 16);
	setForegroundColor(0, 255, 0);
	run("Fill");
	setForegroundColor(0, 99, 151); // EMI-blue
	makeRectangle(pos - height_filter/2, height_a +  height_filter/3, height_filter, height_filter/3);
	run("Fill");
	setColor("white");
	setFont("SansSerif", fontSize, "antialiased");
	setJustification("center");
	drawString("energy filter", pos, height_a +  height_filter/2 + fontSize/2);
	setJustification("left");
}

function placeMaps() {
	setJustification("left");
	selectImage(img_a);
	height = getHeight;
	run("Copy");
	close();
	selectWindow("Figure1");
	makeRectangle(pos_a_x, 0, width_a, height);
	run("Paste");
	setColor("white");
	drawString("a) superposition of 2 elemental maps", pos_a_x + font_offset, fontSize + font_offset);
	setJustification("center");
	//drawString("Superposition of two elemental maps", pos_a_x + width_a/2, fontSize + font_offset);
	setJustification("left");
	selectImage(img_b);
	height = getHeight;
	run("Copy");
	close();
	selectWindow("Figure1");
	makeRectangle(pos_a_x + width_a + space_a_b, 0, width_b, height);
	run("Paste");
	drawString("b)", pos_a_x + width_a + space_a_b + font_offset, fontSize + font_offset);
	setJustification("center");
	drawString("slit aperture\nat the\nfilter entrance plane", pos_a_x + width_a + space_a_b + 1*width_b/4, 5*height/6);
	setJustification("left");
}

function placeSREELS() {
	selectImage(img_d);
	run("Copy");
	close();
	selectWindow("Figure1");
	offset = getHeight - height_d;
	makeRectangle(0, offset, getWidth, height_d);
	run("Paste");
	setColor("white");
	offset = offset + fontSize + font_offset;
	drawString("d)", font_offset, offset);
	setJustification("right");
	drawString("SR-EELS data set with optimised filter parameters", getWidth - font_offset, offset);
	setJustification("left");
	selectImage(img_c);
	width = getWidth;
	run("Copy");
	close();
	selectWindow("Figure1");
	offset = getHeight - height_d - height_c - space_c_d;
	makeRectangle(0, offset, getWidth, height_c);
	run("Paste");
	offset = offset + fontSize + font_offset;
	drawString("c)", font_offset, offset);
	setJustification("right");
	drawString("SR-EELS data set with default energy filter parameters", getWidth - font_offset, offset);
	setJustification("left");
	offset = getHeight - height_d - height_c - space_c_d - font_offset;
	setColor("blue");
	drawString("oxygen K-edge", 60 / 4096 * width, offset);
	setColor("green");
	drawString("chromium L-edges", 880 / 4096 * width, offset);
	setColor("red");
	drawString("iron L-edges", 3580 / 4096 * width, offset);
}

function drawEnergyScale() {
	setJustification("center");
	setColor("white");
	run("Colors...", "foreground=white background=black selection=yellow");
	run("Line Width...", "line=8");
	selectWindow("Figure1");
	drawString("Energy loss [eV]", getWidth/2, getHeight - font_offset);
	offset1 = getHeight - 2*font_offset - fontSize;
	offset2 = offset1 - fontSize - font_offset;
	offset3 = offset2 - fontSize;
	open(input_path + "QSinK7=-15%\\prepared_corrected_Cal1.tif");
	img_d = getImageID();
	for (var i = 540; i < 740; i += 20) {
		selectImage(img_d);
		var x = i;
		var y = 0;
		toUnscaled(x, y);
		selectWindow("Figure1");
		drawString(i, x, offset1);
		makeLine(x, offset2, x, offset3);
		run("Fill");
	}
	selectImage(img_d);
	close();
}

function placeLineScan() {
	id1 = getImageID();
	open(output_path + "Figure8.png");
	id2 = getImageID();
	selectImage(id1);
	run("Add Image...", "image=Figure8.png x=1580 y=4550 opacity=60");
	selectImage(id2);
	close();
	selectImage(id1);
	height_d = 3250;
	// figure1d is croped by 400 px and the line profiles are made with only a crop of 255 px.
	// 537 nm is the lower limit of the plot and 0.2701 nm/px is the lateral dispersion.
	// The higer limit of the plot is 900 nm.
	yOffset = getHeight - height_d - 400 + 255 + round(537 / 0.2701);
	length = (900 - 537) / 0.2701;
	// Energy dispersion in eV/px and offset in px.
	eDis = 0.05094;
	eOffset = -10418;
	// Signal is integrated at a 20 eV interval -> width in px.
	width = 20 / eDis;
	run("Line Width...", "line="+width);
	// Center of the interval is start + 10 eV.
	crPos = (575+10) / eDis + eOffset;
	fePos = (708+10) / eDis + eOffset;
	run("Colors...", "foreground=white background=black selection=green");
	makeLine(crPos, yOffset, crPos, yOffset + length);
	run("Add Selection...");
	run("Colors...", "foreground=white background=black selection=red");
	makeLine(fePos, yOffset, fePos, yOffset + length);
	run("Add Selection...");
}