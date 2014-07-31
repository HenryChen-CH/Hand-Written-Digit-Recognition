function [ data target  row column] = load_data( folder_name )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
fnames = dir(folder_name);
file_num = length(fnames);
t1 = clock;
%%initial the matrix
file_name = folder_name;
file_name = strcat(file_name,'/');
file_name = strcat(file_name,fnames(3).name);
[a row column] = read_txt(file_name);
len = length(a);

data = zeros(file_num - 2,len);
target = zeros(file_num -2 ,1);

data(1,:) = a';
target(1) = fnames(3).name(1) - '0';
if(target(1)== 0)
    target(1) = 10;
end;

%%read all the data
for i = 4:file_num
    file_name = folder_name;
    file_name = strcat(file_name,'/');
    file_name = strcat(file_name,fnames(i).name);
    a = read_txt(file_name);
    data(i - 2,:) = a';
    
    target(i - 2) = fnames(i).name(1) - '0';
    if(target(i - 2) == 0)
        target(i - 2) = 10;
    end;
end;
t2 = clock;
fprintf('Load data consumed time %.4fs\n',etime(t2,t1));
end

