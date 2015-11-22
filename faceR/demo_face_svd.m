%% SVD 实现人脸图像降维和重构
% 任何一个 m×n(m>=n) 的矩阵 A 可以写成：

clc;
clear;
close all;
%% 读取数据
% faceMatrix是77760*120的矩阵，每列表示一张图像。
% 每张图像大小为243*320，用mgRow,imgCol存储
%[imgRow,imgCol]	- image size
% FaceContainer		- images

img=imread('./yalefaces/subject01.glasses');
[imgRow,imgCol]=size(img);
FaceContainer=zeros(120,imgRow*imgCol);

a={'.glasses';'.happy';'.leftlight';'.noglasses';'.normal';'.rightlight';'.sad';'.sleepy'};

for i=1:15
    strPath='./yalefaces/subject';
    i1=mod(i,10);
    i0=char(i/10);
    strPath=strcat(strPath,'0'+i0);
    strPath=strcat(strPath,'0'+i1);
    tempStrPath=strPath;
    for j=1:8
        strPath=tempStrPath;
        strPath=strcat(strPath,a{j});
        img=imread(strPath);
        FaceContainer((i-1)*8+j,:)=img(:)';
    end
end

FaceContainer = FaceContainer';

%% 重建图像

[l, n] = size(FaceContainer);
[U, S, V] = svd(FaceContainer,0);
reconFaces = zeros(12, l, n);
for k=10:10:120
	reconFaces(k/10,:,:) = U(:,1:k) * S(1:k,1:k) * V(:,1:k)';
end

%% 显示图片
% 仅显示第一张图片在k=10,20,……120时的图像
for f_type=1:15
	figure;
	for k=1:12
		faceData = uint8(reconFaces(k,:,f_type*8));
		faceData = reshape(faceData', imgRow, imgCol);
		subplot(3,4,k);
		imshow(faceData);
	end
end

%%  性能比较
%   计算SSD
ssd = zeros(12,15);
for f_type=1:15
	for k=1:12
		mat1 = FaceContainer(:,f_type*8-7);
		mat2 = reconFaces(k,:,f_type*8-7)';
		if(size(mat1)~=size(mat2))
			ssd = 'null';
		else
			ssd(k,f_type) = norm(mat1-mat2);
		end
	end
end
  
%% 存储数据
save Mat/allData FaceContainer U S V reconFaces ssd;