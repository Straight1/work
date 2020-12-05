f=imread("catdog.jpg");
f=rgb2gray(f);
%h=[1,1,1;1,1,1;1,1,1]/9;  %滤波模板
%g=imfilter(f,h,'corr','replicate');  %滤波

%创建自定义的二维滤波器fspecial()函数
h1=fspecial('gaussian',[3,3],0.5);
h2=fspecial('gaussian',[5,5],0.5);
h3=fspecial('gaussian',[7,7],0.5);  %从h3�?�?  sigma 过于�?  高斯函数只分布在中间3*3的矩阵块�?/89*
h4=fspecial('gaussian',[9,9],0.5);
h5=fspecial('gaussian',[11,11],0.5);  
h6=fspecial('gaussian',[11,11],1.8);

g1=imfilter(f,h1);
g2=imfilter(f,h2);
g3=imfilter(f,h3);
g4=imfilter(f,h4);
g5=imfilter(f,h5);


g6=imfilter(f,h6);
G6=imfilter(f,h6,'symmetric');
%X(给定数字)  用固定数值X填充虚拟边界，默认情况是�?0填充  �?以g6边界是黑�?
%symmetric表示填充边界做镜�?98 78�?78 98
%replicate表示重复�?近元�?98 78�?78 78 

%same输出图像与输入图像尺寸相同（默认�?
%full 输出图像与输入图像填充虚拟边界后尺寸相同

subplot(1,2,1);
imshow(g6);  %边界默认�?0填充
subplot(1,2,2);
imshow(G6);  %边界像素做镜像得�?'

imwrite(G6,'G6.png');









