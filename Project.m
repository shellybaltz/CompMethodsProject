clear all
clc

% info = dicominfo('IM-0001-0001.dcm');
% I = dicomread(info);
% imshow(I,'DisplayRange',[])
filefolder = fullfile(pwd, '/Volumes/ShellsSSD/CompMethodsProject');
collection = dicomCollection(fullfile(filefolder, 'dicomimages'));


