input_path = getDirectory("Select the folder that contains the images");
output_path = getDirectory("Select the folder to save the output images");
height = 360;
/*
 * How to get the correct font size?
 * The poster uses 72 dpi as reference and a font size of 26 pt.
 * The image is displayed with 309.6 dpi.
 * fontSize = 26 pt / 72 dpi * 309.6 dpi = 111.8 pt
 */
font_size = 112;
font_offset = 10;

open(input_path + "QSinK7=-15%\\SR-EELS_SM125_-15%_635eV_B1_90s.tif");
run("Remove Outliers...", "radius=5 threshold=100 which=Bright");
run("Remove Outliers...", "radius=5 threshold=100 which=Dark");
resetMinAndMax();
makeRectangle(0, 1042, 4096, height);
run("Crop");
run("Log");
run("Enhance Contrast", "saturated=0.35");
raw = getImageID();

/*
 * For figure 1 I used Cal1 to correct the SR-EELS data set. Slightly better results are achieved when using Cal2.
 * To compare with Cal1, change useCal1 to true.
 */
useCal1 = false;
if (useCal1 == true) {
	open(input_path + "QSinK7=-15%\\prepared_corrected_Cal1.tif");
	makeRectangle(0, 1626, 4096, height);
} else {
	open(input_path + "QSinK7=-15%\\prepared_corrected_Cal2.tif");
	makeRectangle(0, 1398, 4096, height);
}
run("Crop");
run("Log");
run("Enhance Contrast", "saturated=0.35");
corrected = getImageID();

newImage("Untitled", "RGB black", 4096, 2*height + 3*font_size + 6*font_offset, 1);
fig = getImageID();
selectImage(raw);
run("Copy");
close();
selectImage(fig);
makeRectangle(0, font_size + 2*font_offset, 4096, height);
run("Paste");
selectImage(corrected);
run("Copy");
close();
selectImage(fig);
makeRectangle(0, 2*font_size + 4*font_offset + height, 4096, height);
run("Paste");
setFont("Serif", font_size, "antialiased");
setColor("white");
drawString("Section of uncorrected SR-EELS data set:", font_offset, font_size + font_offset);
drawString("Section of corrected SR-EELS data set:", font_offset, 2*font_size + 3*font_offset + height);
makeRectangle(0, 2*height + 2*font_size + 4*font_offset, getWidth, font_size + 2*font_offset);
setForegroundColor(0, 99, 151);
run("Fill");
setColor("white");
setJustification("center");
drawString("A direct comparisson of two sections of the uncorrected and the corrected data set.", getWidth/2, 3*font_size + 5*font_offset + 2*height);
if (getBoolean("Save the new image?")) {
	saveAs("PNG", output_path + "Figure4.png");
	showMessage("Image saved!");
}