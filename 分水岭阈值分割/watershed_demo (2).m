close all;
clear;
clc;

% STEP 1: 读入彩色图像并将其转换为灰度
I_orig = imread('pears.png');
figure;imshow(I_orig);title('原图')
if(length(size(I_orig))==3)
    I = rgb2gray(I_orig);
end
figure;imshow(I), title('灰度图');
figure;imhist(I);title('灰度直方图');

% STEP 2: 使用梯度幅度作为分割函数
gmag = imgradient(I);
figure;imshow(gmag, []);title('梯度幅度')

L = watershed(gmag);
Lrgb = label2rgb(L);
figure;imshow(Lrgb);title('梯度幅度的分水岭变换');

% STEP 3: 标记前景对象,开运算，先腐蚀后膨胀
se = strel('disk', 20);
Io = imopen(I, se);
figure;imshow(Io);title('开运算');

% 膨胀运算
Ie = imerode(I,se);
Iobr = imreconstruct(Ie,I);
figure;imshow(Iobr);title('腐蚀图像');
figure;imhist(I);title('灰度直方图');