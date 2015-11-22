clc;
clear;
close all;

% 人脸数据集的主成分分析
%
% 输入：k --- 降至 k 维

% 定义图像高、宽的全局变量 imgRow 和 imgCol，它们在 ReadFaces 中被赋值

%% 读取数据
%从yaleface人脸库中读取120张人脸图片，每个人读取8张，有15个人，总共120张
%FaceContainer向量化人脸容器，有120行，每行对应一个人脸向量

disp('读入人脸数据...');
%imgRow,imgCol,FaceContainer,faceLabel

img=imread('./yalefaces/subject01.glasses');
[imgRow,imgCol]=size(img);

FaceContainer=zeros(120,imgRow*imgCol);
faceLabel=zeros(120,1);

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
        faceLabel((i-1)*8+j)=i;
    end        
end
save('Mat/FaceMat.mat','FaceContainer')
display('..............................');

% pca 有label

img=imread('./yalefaces/subject01.glasses');
[imgRow,imgCol]=size(img);

FaceContainer=zeros(120,imgRow*imgCol);
faceLabel=zeros(120,1);

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
        faceLabel((i-1)*8+j)=i;
    end        
end
save('Mat/FaceMat.mat','FaceContainer')

nFaces=size(FaceContainer,1);%样本（人脸）数目

display('PCA降维...');

% LowDimFaces是120*20的矩阵, 每一行代表一张主成分脸(共15人，每人8张)，每个脸20个维特征
% W是分离变换矩阵, 10304*20 的矩阵
[LowDimFaces, W] = fastpca(FaceContainer, 20); % 主成分分析PCA

%% 显示主成分脸
% 显示主成分分量（主成分脸，即变换空间中的基向量）
% 输入：E --- 矩阵，每一列是一个主成分分量

figure
img = zeros(imgRow, imgCol);
for ii = 1:20
    img(:) = W(:, ii);
    subplot(4, 5, ii);
    imshow(img, []);
end

save('Mat/LowDimFaces.mat', 'LowDimFaces');
display('计算结束。');