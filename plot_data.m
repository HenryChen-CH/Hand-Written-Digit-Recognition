function [  ] = plot_data( pic ,row )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
column = ceil(length(pic)/row);
m = max(pic);
n = min(pic);

pic = reshape(pic(:),row,column);

colormap(gray);

imagesc(pic,[n,m]);

end

