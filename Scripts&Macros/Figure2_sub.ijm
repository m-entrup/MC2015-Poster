input_path = getArgument();

var plotHeight = 400;
var plotWidth = 3 * plotHeight;
/*
 * How to get the correct font size?
 * The poster uses 72 dpi as reference and a font size of 26 pt.
 * The image is displayed with 372.2 dpi.
 * The Plot.makeHighResolution() method is used with factor 5.
 * fontSize = 22 pt / 72 dpi * 372.2 dpi / 5 = 22.75 pt
 */
var fontSize = 22;
var baseLineWidth = 2;

setFont("Serif", fontSize, "antialiased");

close("*");
setBatchMode(true);
open(input_path +"QSinK7=0%\\SR-EELS_SM125_0%_635eV_B1_45s.tif");
makeRectangle(0, 1600, 4096, 850);
y1 = getProfile();
n = y1.length;
x1 = Array.getSequence(n);
y = Array.getSequence(n);
toScaled(x1, y);
y1Sorted = Array.sort(Array.copy(y1));
close();
open(input_path + "QSinK7=-15%\\prepared_corrected_Cal1.tif");
makeRectangle(0, 255, 4096, 3328);
y2 = getProfile();
y2Sorted = Array.sort(Array.copy(y2));
y3 = newArray(n);
y1Max = y1Sorted[n-1];
y2Max = y2Sorted[n-1];
for (i = 0; i < n; i++) {
	y1[i] /= y1Max;
	y3[i] = 0.75 * y2[i] / y2Max;
	y2[i] /= y2Max;
}
/*
 * The energy dispersion has slightly decreased when using QSinK7 = -15%.
 * A correction is done to fit the same scale as the
 */
step = (x1[1] - x1[0]) * 132.01 / 126.36;
x2 = newArray(n);
x2[0] = x1[0] - 3.51;
for (i = 1; i < n; i++) {
	x2[i] = x2[i-1] + step;
}
close();
Plot.create("Figure2", "Energy loss [eV]", "Intensity [a.u.]");
Plot.setFrameSize(plotWidth, plotHeight)
Plot.setFontSize(fontSize);
Plot.setColor("red");
Plot.setLineWidth(baseLineWidth + 1);
Plot.setFormatFlags("11000100111111");
Plot.add("line", x1, y1);
Plot.setColor("black");
Plot.setLineWidth(baseLineWidth);
Plot.add("line", x2, y2);
Plot.setColor("blue");
Plot.add("line", x1, y3);
Plot.setLimits(x1[0], x1[n-1], 0.3, 1.05);
Plot.addLegend("EEL signal extracted from figure c\nCorrected EEL signal extracted from figure d\nRaw EEL signal extracted from figure d");
Plot.makeHighResolution("Figure2_HiRes", 5.0, "false");
setBatchMode("exit and display");