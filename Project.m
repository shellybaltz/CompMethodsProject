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


%Reads MRI Images
mri1 = dicomread(info1);
mri2 = dicomread(info2);
mri3 = dicomread(info3);
mri4 = dicomread(info4);

%Displays all 4 images
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
j_1 = imadjustn(mri1);%thresholds original mri image #1
imshow(j_1, [])
title('MRI Image 1')

j_2 = imadjustn(mri2); %thresholds original mri image #1
j_3 = imadjustn(mri3); %thresholds original mri image #2
j_4 = imadjustn(mri4); %thresholds original mri image #3

a = char('This thresholding is for viewing purposes.');
b = char('The function imadjustn was used.');
c = char('This function increases contrast of the image by saturating the');
d = char('botton and top 1 percent of all pixel values');

disp(a)
disp(b)
disp(c)
disp(d)

ROI_1 = drawfreehand %draws region of interes (user input)
bw = createMask(ROI_1); %bionary mask image with pixels insie ROI, supressed


OGimage1 = j_1;%setting OGimage to first mri image
OGimage1(bw) = 255; %sets masked ROI section above to original mri thresholded image
MaskedIm1 = j_1;
MaskedIm1(~bw) = 0; %everywhere not masked is set to black
subplot(2,2,1) 
imshow(MaskedIm1) %shows RIO
title('Ablation Area in MRI Image 1')

structBoundaries = bwboundaries(bw);
xy = structBoundaries{1};
x = xy(:,2);
y = xy(:,1);


subplot(2,2,2)
OGimage2 = j_2;%setting OGimage to first mri image
OGimage2(bw) = 255; %sets masked ROI section above to original mri thresholded image
MaskedIm2 = j_2;
MaskedIm2(~bw) = 0; %everywhere not masked is set to black
imshow(MaskedIm2)
hold on
plot(x,y); 
drawnow;%updates figures and processes pending callbacks
title('Ablation Area in MRI Image 2')

subplot(2,2,3)
OGimage3 = j_3;%setting OGimage to first mri image
OGimage3(bw) = 255; %sets masked ROI section above to original mri thresholded image
MaskedIm3 = j_3;
MaskedIm3(~bw) = 0; %everywhere not masked is set to black
imshow(MaskedIm3)
hold on
plot(x,y); 
drawnow; %updates figures and processes pending callbacks
title('Ablation Area in MRI Image 3')

subplot(2,2,4)
OGimage4 = j_4;%setting OGimage to first mri image
OGimage4(bw) = 255; %sets masked ROI section above to original mri thresholded image
MaskedIm4 = j_4;
MaskedIm4(~bw) = 0; %everywhere not masked is set to black
imshow(MaskedIm4)
hold on
plot(x,y); 
drawnow; %updates figures and processes pending callbacks
title('Ablation Area in MRI Image 4')

%adjust pixel number to be user input/slider
ab1 = zeros(368,512); %initializing vector
for k = 1:512
    for j = 1:368
        if MaskedIm1(j,k) > 60000 %finds when image is greater than 60,000 (ablation pixel values)
            ab1(j,k) = MaskedIm1(j,k); %sets vector equal to ablation pixel value
        else
            ab1(j,k) = 0; %everything but ablation pixels = 0
        end
    end
end

ab2 = zeros(368,512); %initializing vector
for k = 1:512;
    for j = 1:368;
        if MaskedIm2(j,k) > 60000; %finds when image is greater than 60,000 (ablation pixel values)
            ab2(j,k) = MaskedIm2(j,k); %sets it equal to value if greater than
        else
            ab2(j,k) = 0; %everything but ablation pixels = 0
        end
    end
end

ab3 = zeros(368,512); %initializing vector
for k = 1:512;
    for j = 1:368;
        if MaskedIm3(j,k) > 60000; %finds when image is greater than 60,000 (ablation pixel values)
            ab3(j,k) = MaskedIm1(j,k); %sets vector equal to ablation pixel value
        else
            ab3(j,k) = 0; %everything but ablation pixels = 0
        end
    end
end

ab4 = zeros(368,512); %initializing vector
for k = 1:512;
    for j = 1:368;
        if MaskedIm4(j,k) > 60000; %finds when image is greater than 60,000 (ablation pixel values)
            ab4(j,k) = MaskedIm1(j,k); %sets vector equal to ablation pixel value
        else
            ab4(j,k) = 0; %everything but ablation pixels = 0
        end
    end
end


ab2 = zeros(368,512); %initializing vector
for k = 1:512;
    for j = 1:368;
        if MaskedIm2(j,k) > 60000; %finds when image is greater than 60,000 (ablation pixel values)
            ab2(j,k) = MaskedIm2(j,k); %sets it equal to value if greater than
        else
            ab2(j,k) = 0; %everything but ablation pixels = 0
        end
    end
end

ab3 = zeros(368,512); %initializing vector
for k = 1:512;
    for j = 1:368;
        if MaskedIm3(j,k) > 60000; %finds when image is greater than 60,000 (ablation pixel values)
            ab3(j,k) = MaskedIm1(j,k); %sets vector equal to ablation pixel value
        else
            ab3(j,k) = 0; %everything but ablation pixels = 0
        end
    end
end

ab4 = zeros(368,512); %initializing vector
for k = 1:512;
    for j = 1:368;
        if MaskedIm4(j,k) > 60000; %finds when image is greater than 60,000 (ablation pixel values)
            ab4(j,k) = MaskedIm1(j,k); %sets vector equal to ablation pixel value
        else
            ab4(j,k) = 0; %everything but ablation pixels = 0
        end
    end
end

%Plots ablation scar tissue pixels in each mri image
figure
subplot(2,2,1)
imshow(ab1)
title('Ablation in MRI Image 1')

subplot(2,2,2)
imshow(ab2)
title('Ablation in MRI Image 2')

subplot(2,2,3)
imshow(ab3)
title('Ablation in MRI Image 3')

subplot(2,2,4)
imshow(ab4)
title('Ablation in MRI Image 4')

%% Finding area
Area1 = nnz(ab1); % Counts all of the nonzero elements, aka white pixels, present in the masked images
Area2 = nnz(ab2);
Area3 = nnz(ab3);
Area4 = nnz(ab4);
spacing = info1.PixelSpacing; % The pixel spacing is equal for all of the dicom images, so we can probably just use one variable
pixelarea = spacing(1)*spacing(2);
Areamm1 = Area1*pixelarea;
Areamm2 = Area2*pixelarea;
Areamm3 = Area3*pixelarea;
Areamm4 = Area4*pixelarea;

%% Volume Calculation
thickness = info1.SliceThickness; % Thickness of each slice in mm
Volume1 = Areamm1*thickness; % Calculates the volume of each slice by multiplying with the slice thickness
Volume2 = Areamm2*thickness;
Volume3 = Areamm3*thickness;
Volume4 = Areamm4*thickness;
TotalVolume = Volume1+Volume2+Volume3+Volume4 % The sum of each slice will result in the final volume








