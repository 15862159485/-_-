clear;
clc;
MAX=200;
img = imread('N9.jpg');       %��ȡͼƬ
fid = fopen('E:\MatlabProject\Num0\N9.coe', 'w'); %����COE�ļ�

fprintf(fid, 'memory_initialization_radix=2;\n');
fprintf(fid, 'memory_initialization_vector=\n');

m = size(img);  %��ȡͼƬ�ߴ磬m(1)Ϊ�ߣ�m(2)Ϊ��
for i = 1:m(1)
    for j = 1:m(2)
        % ��RGB����д��һ��
        if(img(i,j,1)<=MAX||img(i,j,2)<=MAX||img(i,j,3)<=MAX)
            flag=0;
        else 
            flag=1;
        end
    	fprintf(fid, '%d,\n', flag);     % R 
    end
end
fseek(fid, -2, 1); % �����һ�������÷ֺŸ���
fprintf(fid, ';');

fclose(fid); %�ر��ļ�