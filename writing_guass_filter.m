F=imread('catdog.jpg');
Fimg=rgb2gray(F);

%1.扩充边界 生成新图data
[R,C]=size(Fimg);
%ceil()  floor()
Hsize=11;  %滤波模板大小
padding=floor(Hsize/2);%边界
data=zeros(R+2*padding,C+2*padding);

%先把原图像放进data�?
for i=1:R
    for j=1:C
        data(i+padding,j+padding)=Fimg(i,j);
    end
end

%镜像四个�?
for i=1:R+Hsize-1
    for j=1:C+Hsize-1
        %左上�?
        if(i<=padding && j<=padding)
            data(i,j)=data(Hsize-i,Hsize-j);
        end
        %右上�?
        if(i<=padding && j>padding+C)
            data(i,j)=data(Hsize-i,2*(C+padding)+1-j);
        end
        %左下�?
        if(i>R+padding && j<=padding)
            data(i,j)=data(2*(R+padding)+1-i,Hsize-j);
        end
        %右下�?
        if(i>R+padding && j>C+padding)
            data(i,j)=data(2*(R+padding)+1-i,2*(C+padding)+1-j);
        end         
    end
end

%镜像四个边界
for i=1:R+Hsize-1
    for j=1:C+Hsize-1
        %上边�?
        if(i<=padding && j>padding && j<=padding+C)
             data(i,j)=data(Hsize-i,j);
        end
        %左边�?
        if(j<=padding && i>padding &&i<=padding+R)
             data(i,j)=data(i,Hsize-j);
        end
        %右边�?
        if(j>padding+C && i>padding && i<padding+R)
             data(i,j)=data(i,2*(C+padding)+1-j);
        end
        %下边�?
        if(i>padding+R &&j>padding &&j<=padding+C) 
             data(i,j)=data(2*(R+padding)+1-i,j);
        end       
    end
end

%2.生成高斯模板
%Hsize在上面初始化过了
H=zeros(Hsize,Hsize);
center_H=(Hsize+1)/2;
H_row=Hsize;
H_col=Hsize;
sigma=1.8;  %sigma在这里修�?
for i=1:H_row
    for j=1:H_col
        distance=double((i-center_H).^2+(j-center_H).^2);
        H(i,j)=exp((-1)*distance/(2*sigma^2))/(2*pi*(sigma^2));
    end
end

[m,n]=size(data);
G=zeros(R,C);

%3.卷积
for i=6:m-padding
    for j=6:n-padding
        part=data(i-padding:i+padding,j-padding:j+padding);   
        part=double(part);
        temp=H.*part;
        G(i-padding,j-padding)=sum(sum(temp));
    end
end

G=int16(G);
I=mat2gray(G);
imshow(I);
imwrite(I,'G.png');





