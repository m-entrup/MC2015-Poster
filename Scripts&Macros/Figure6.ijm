if (!getBoolean("This macro will close all open images.\nDo you want to start the macro?")) {
	exit();
}
close("*");
setBatchMode(true);
/*
 * I can't pass arguments to a JavaScript file that is invoked by runMacro().
 * To preserve the same order of dialogs (Scripts, Input and Outout), I moved the second getDirectory() to the JavaScript file and I moved the third getDirectory() below runMacro().
 */
script_path = getDirectory("Select the folder that contains the Scripts");
/*
 * SR-EELS_Characterisation.js will soon replace SR-EELS_Characterisation.ijm as part of EFTEMj.
 * The version I use is a draft that is modified to create the diagram I need for my poster.
 */
runMacro(script_path + "SR-EELS_Characterisation.js");
selectWindow("Figure6");
close();
selectWindow("Figure6_HiRes");
output_path = getDirectory("Select the folder to save the output images");
setBatchMode("exit and display");
if (getBoolean("Save the new image?")) {
	saveAs("PNG", output_path + "Figure6.png");
	showMessage("Image saved!");
}