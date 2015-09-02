/*
 * 1.50b is needed to display the plot properly:
 * https://list.nih.gov/cgi-bin/wa.exe?A1=ind1508&L=IMAGEJ#24
 */
requires("1.50b");
script_path = getDirectory("Select the folder that contains the Scripts");
input_path = getDirectory("Select the folder that contains the images");
output_path = getDirectory("Select the folder to save the output images");
runMacro(script_path + "Figure2_sub.ijm", input_path);
selectWindow("Figure2");
close();
if (getBoolean("Save the new image?")) {
	saveAs("PNG", output_path + "Figure2.png");
	showMessage("Image saved!");
}