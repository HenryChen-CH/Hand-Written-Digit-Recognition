function [ data row column ] = read_txt( a )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
fidin = fopen(a,'r');

column = 0;
row = 0;
data = [];

if ~feof(fidin)
    tline = fgetl(fidin);
    column = length(tline);
    tmp = zeros(1,length(tline));
    for i = 1:column
        if(tline(i) == '0')
            tmp(i) = 0;
        elseif(tline(i)=='1')
            tmp(i) = 1;
        end;
    end;
    row = row + 1;
    data = [data;tmp];
end;
    
while ~feof(fidin)
    tline = fgetl(fidin);
    tmp = zeros(1,column);
    for i = 1:column
        if(tline(i) == '0')
            tmp(i) = 0;
        elseif (tline(i)=='1')
            tmp(i) = 1;
        end;
    end;
    row = row + 1;
    data = [data;tmp];
end;

data = data(:);
fclose(fidin);

end

