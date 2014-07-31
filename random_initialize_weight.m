function [ weight, range ] = random_initialize_weight( input, output )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

range = sqrt(6/(input + output));

weight = unifrnd(-range,range,input,output);

end

