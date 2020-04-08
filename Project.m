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
clear, clc

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
subplot(2,2,1)
j_1 = imadjustn(mri1);
imshow(j_1, [])
title('MRI Image 1 - Thresholding')

ROI_1 = drawfreehand
bw = createMask(ROI_1);
imshow(bw)


subplot(2,2,2)
j_2 = imadjustn(mri2);
imshow(j_2, [])
title('MRI Image 2 - Thresholding')

ROI_2 = drawfreehand
bw2 = createMask(ROI_2);
imshow(bw2)

subplot(2,2,3)
j_3 = imadjustn(mri3);
imshow(j_3, [])
title('MRI Image 2 - Thresholding')

ROI_3 = drawfreehand
bw3 = createMask(ROI_3);
imshow(bw3)

subplot(2,2,4)
j_4 = imadjustn(mri4);
imshow(j_4, [])
title('MRI Image 2 - Thresholding')

ROI_4 = drawfreehand
bw4 = createMask(ROI_4);
imshow(bw4)

%% Finding area
Area1 = regionprops(bw,'area')
Area2 = regionprops(bw2,'area')
Area3 = regionprops(bw3,'area')
Area4 = regionprops(bw4,'area')

