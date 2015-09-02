/*
 * Use this macro to open the SR-EELS data set with CSI (cornell-spectrum-imager).
 * You can download CSI from:
 * https://code.google.com/p/cornell-spectrum-imager/
 * After loading the image, run "Plugins > CSI >  CSI Spectrum Analizer".
 * I used LCPL as fit method and the following parameters to integrate the element signal:
 * Chromium
 * 	Background
 * 		Start: 547
 * 		Width: 25
 * 	Integration
 * 		Start: 575 
 * 		Width: 20
 * Iron
 * 	Background
 * 		Start: 660
 * 		Width: 40
 * 	Integration
 * 		Start: 708 
 * 		Width: 20
 */
input_path = getDirectory("Select the folder that contains the images");
open(input_path + "QSinK7=-15%\\prepared_corrected_Cal1.tif");
makeRectangle(0, 255, 4096, 3328);
run("Crop");
run("Properties...", "channels=1 slices=1 frames=1 unit=eV pixel_width=0.0509400 pixel_height=0.2701 voxel_depth=0.0509400 origin=-10418,0,-10418");