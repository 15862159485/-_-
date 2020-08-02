clear;
clc;
MAX=200;
img = imread('N9.jpg');       %读取图片
fid = fopen('E:\MatlabProject\Num0\N9.coe', 'w'); %创建COE文件

fprintf(fid, 'memory_initialization_radix=2;\n');
fprintf(fid, 'memory_initialization_vector=\n');

m = size(img);  %获取图片尺寸，m(1)为高，m(2)为宽
for i = 1:m(1)
    for j = 1:m(2)
        % 将RGB数据写在一起
        if(img(i,j,1)<=MAX||img(i,j,2)<=MAX||img(i,j,3)<=MAX)
            flag=0;
        else 
            flag=1;
        end
    	fprintf(fid, '%d,\n', flag);     % R 
    end
end
fseek(fid, -2, 1); % 将最后一个逗号用分号覆盖
fprintf(fid, ';');

fclose(fid); %关闭文件