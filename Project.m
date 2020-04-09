% Comp Methods Project 

%% 
clear, clc

test = license('test','image_toolbox');
if test == 0
    disp('To run this project you must have the Image Processing Toolbox. It looks like you do not have it and you should please install it before using this program.')
else
    disp('The test to check if you have the Image Processing Toolbox is approved.')
end

%% Loading Data into Matlab
clear, clc, close all

% stores information about the MRI images into a structure
info1 = dicominfo('IM-0001-0001.dcm');
info2 = dicominfo('IM-0001-0002.dcm');
info3 = dicominfo('IM-0001-0003.dcm');
info4 = dicominfo('IM-0001-0004.dcm');

mri1 = dicomread(info1);
mri2 = dicomread(info2);
mri3 = dicomread(info3);
mri4 = dicomread(info4);

figure
subplot(2,2,1)
imshow(mri1,[])
title('MRI Image 1')
 
subplot(2,2,2)
imshow(mri2,[])
title('MRI Image 2')

subplot(2,2,3)
imshow(mri3,[])
title('MRI Image 3')
 
subplot(2,2,4)
imshow(mri4,[])
title('MRI Image 4')

%% Thresholding and Selecting ROI

figure
j_1 = imadjustn(mri1);
imshow(j_1, [])
title('MRI Image 1 - Thresholding')


ROI_1 = drawfreehand
bw = createMask(ROI_1);
imshow(bw)

%% Finding area
Area1 = nnz(bw)
Area2 = nnz(bw2)
Area3 = nnz(bw3)
Area4 = nnz(bw4)
spacing = info1.PixelSpacing % The pixel spacing is equal for all of the dicom images, so we can probably just use one variable
pixelarea = spacing(1)*spacing(2)
Areamm1 = Area1*pixelarea
Areamm2 = Area2*pixelarea
Areamm3 = Area3*pixelarea
Areamm4 = Area4*pixelarea
