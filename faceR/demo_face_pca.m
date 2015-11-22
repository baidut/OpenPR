clc;
clear;
close all;

% �������ݼ������ɷַ���
%
% ���룺k --- ���� k ά

% ����ͼ��ߡ����ȫ�ֱ��� imgRow �� imgCol�������� ReadFaces �б���ֵ

%% ��ȡ����
%��yaleface�������ж�ȡ120������ͼƬ��ÿ���˶�ȡ8�ţ���15���ˣ��ܹ�120��
%FaceContainer������������������120�У�ÿ�ж�Ӧһ����������

disp('������������...');
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

% pca ��label

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

nFaces=size(FaceContainer,1);%��������������Ŀ

display('PCA��ά...');

% LowDimFaces��120*20�ľ���, ÿһ�д���һ�����ɷ���(��15�ˣ�ÿ��8��)��ÿ����20��ά����
% W�Ƿ���任����, 10304*20 �ľ���
[LowDimFaces, W] = fastpca(FaceContainer, 20); % ���ɷַ���PCA

%% ��ʾ���ɷ���
% ��ʾ���ɷַ��������ɷ��������任�ռ��еĻ�������
% ���룺E --- ����ÿһ����һ�����ɷַ���

figure
img = zeros(imgRow, imgCol);
for ii = 1:20
    img(:) = W(:, ii);
    subplot(4, 5, ii);
    imshow(img, []);
end

save('Mat/LowDimFaces.mat', 'LowDimFaces');
display('���������');