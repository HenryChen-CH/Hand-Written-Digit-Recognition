function [hidden_state, output_state] = fprop(training_data, input_to_hidden_weights, hidden_to_output_weights, hidden_bias, output_bias)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

num_training = size(training_data,1);%number of examples in the training set

%% compute using the cpu
hidden_unit = training_data * input_to_hidden_weights;
hidden_unit = hidden_unit + repmat(hidden_bias, num_training, 1);
hidden_state = sigmoid(hidden_unit);

%compute the output
output_unit = hidden_state * hidden_to_output_weights;
output_unit = output_unit + repmat(output_bias, num_training, 1);
output_state = sigmoid(output_unit);
%%
%comppute using gpu
% gpu_training_data = gpuArray(training_data);
% hidden_unit = gpu_training_data * input_to_hidden_weights;
% hidden_unit = hidden_unit + repmat(hidden_bias, num_training, 1);
% hidden_state = 1./( 1 + exp(-hidden_unit));
% 
% %compute the output state
% output_unit = hidden_state * hidden_to_output_weights;
% output_unit = output_unit + repmat(output_bias, num_training, 1);
% output_state = 1./( 1 + exp(-output_unit));
% 
% hidden_state = gather(hidden_state);
% output_state = gather(output_state);

%%
end

