%% SVD ʵ������ͼ��ά���ع�
% �κ�һ�� m��n(m>=n) �ľ��� A ����д�ɣ�

clc;
clear;
close all;
%% ��ȡ����
% faceMatrix��77760*120�ľ���ÿ�б�ʾһ��ͼ��
% ÿ��ͼ���СΪ243*320����mgRow,imgCol�洢
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

%% �ؽ�ͼ��

[l, n] = size(FaceContainer);
[U, S, V] = svd(FaceContainer,0);
reconFaces = zeros(12, l, n);
for k=10:10:120
	reconFaces(k/10,:,:) = U(:,1:k) * S(1:k,1:k) * V(:,1:k)';
end

%% ��ʾͼƬ
% ����ʾ��һ��ͼƬ��k=10,20,����120ʱ��ͼ��
for f_type=1:15
	figure;
	for k=1:12
		faceData = uint8(reconFaces(k,:,f_type*8));
		faceData = reshape(faceData', imgRow, imgCol);
		subplot(3,4,k);
		imshow(faceData);
	end
end

%%  ���ܱȽ�
%   ����SSD
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
  
%% �洢����
save Mat/allData FaceContainer U S V reconFaces ssd;