//Think of RAM and image size before running this!

#@ File (style="directory") imageFolder;
dir = File.getDefaultDir;
dir = replace(dir,"\\","/");

title = getTitle();
run("Hyperstack to Stack");
rename("original");
run("Slice Keeper", "first=2 last=33 increment=1");
run("Reverse");
rename("reverted1");
run("Concatenate...", "keep image1=[reverted1] image2=original image3=[-- None --]");
rename("original2");
maxslice = nSlices
maxslice_2 = maxslice-1;
maxslice_32 = maxslice-31;
run("Slice Keeper", "first=maxslice_32 last=maxslice_2 increment=1");
run("Reverse");
rename("reverted2");
run("Concatenate...", "keep image1=[original2] image2=reverted2 image3=[-- None --]");

lstr = lengthOf(title);
substr = lstr - 4;
mintif = substring(title, 0, substr);
title_neg7 = mintif + "_offset=-31.tif"; 
rename(title_neg7);

selectWindow("reverted1");
run("Close");
selectWindow("reverted2");
run("Close");

selectWindow(title_neg7);
lstr = lengthOf(title_neg7);
n = 31
for (i=0;i<32;i++){	
	run("Duplicate...", "duplicate");
	substr = lstr - 6; //Change this to how many digits the largest offse is -31.tif = 6 digits
	mintif = substring(title_neg7, 0, substr);
	title_neg = mintif + n + ".tif"; 
	run("Slice Remover", "first=1 last=1 increment=1");
	rename(title_neg);
	save(dir + title_neg);
	n -= 1;
}


