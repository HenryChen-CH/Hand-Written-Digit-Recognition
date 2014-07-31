%%load training data
%[training_data, training_target, row, column] = load_data('./trainingDigits');

%load training_data;
%randomly disturb the training data three times
training_num = size(training_data,1);
for i = 1:3
    random_order = randperm(training_num);
    training_data = training_data(random_order,:);
    training_target = training_target(random_order,:);
end;

%%set the parameters for the neural network
batch_size = 2000;%Mini-batch size
learning_rate = 0.1;
momentum = 0.9;

input_num_unit = size(training_data,2); % number of unites in the input layer
hidden_num_unit = 30;%number of unites in the hidden layer
output_num_unit = 10;%number of unites in the output layer

%variables for tracking training process


%initialize the weight and biases
% input_to_hidden_weights = random_initialize_weight(input_num_unit, hidden_num_unit);
% hidden_to_output_weights = random_initialize_weight(hidden_num_unit, output_num_unit);
input_to_hidden_weights = randn(input_num_unit, hidden_num_unit);
hidden_to_output_weights = randn(hidden_num_unit, output_num_unit);

hidden_bias = zeros(1, hidden_num_unit);
output_bias = zeros(1, output_num_unit);

%changes in the weights, used in the backpropagation algorithm
input_to_hidden_weights_delta = zeros(input_num_unit, hidden_num_unit);
hidden_to_output_weights_delta = zeros(hidden_num_unit, output_num_unit);
hidden_bias_delta = zeros(1, hidden_num_unit);
output_bias_delta = zeros(1, output_num_unit);

tiny = exp(-30);%To avoid the appearance of 0 when computing log
count = 0;

%traing error
this_chunk_CE = 0;
trainset_CE = 0;

%according to the batch size, resize the training set
batch_num = floor(training_num/batch_size);
training_data = training_data(1:batch_size*batch_num,:);
training_target = training_target(1:batch_size*batch_num,:);

%load the data to gpu
%gpu_training_data = gpuArray(training_data);
%pu_training_target = gpuArray(training_target);


error_deriv = zeros(batch_size, output_num_unit);