function [ y ] = sigmoid( x )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
% t1 = clock;
% 
% gpu_x = gpuArray(x);
% gpu_y = 1 ./(1 + exp(-gpu_x));
% y = gather(gpu_y);

y = 1./(1 + exp(-x));
end

