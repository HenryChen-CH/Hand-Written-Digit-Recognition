
expension_matrix = eye(output_num_unit);

while true
    epoches = input('The number of iterations: ');
    if(epoches == 0)
        break;
    end;
    
    for epoch = 1:epoches
        fprintf('Epoch %d \n',epoch);
        
        for m = 1:batch_num
            batch_training_data = training_data(((m-1)*batch_size+1):m*batch_size,:);
            batch_training_target = training_target(((m-1)*batch_size+1):(m*batch_size),:);
            
            %forward propagation 
            [hidden_state, output_state] = fprop(batch_training_data, input_to_hidden_weights, hidden_to_output_weights, hidden_bias, output_bias);
            
            %compute the derivative of the cost function
            expended_target = expension_matrix(batch_training_target(:),:);
            error_deriv = output_state - expended_target;
            
            %%compute the cost function
            CE = -sum(sum(expended_target .* log(output_state) + (1 - expended_target).*log(1 - output_state)));
            CE = CE / batch_size / output_num_unit;
            fprintf('Batch %d Train CE: %f \n ',m,CE);
            trainset_CE = trainset_CE + (CE - trainset_CE) / m;
            %test = test + CE;
            
            %%back propagation
            %output layer
            hidden_to_output_weights_gradient = hidden_state' * error_deriv;
            output_bias_gradient = sum(error_deriv,1);            
            %hidden layer
            back_propagated_error_deriv_1 = (error_deriv * hidden_to_output_weights').*hidden_state.*(1 - hidden_state);
            input_to_hidden_weights_gradient = batch_training_data' * back_propagated_error_deriv_1;
            hidden_bias_gradient = sum(back_propagated_error_deriv_1,1);
            
            %update weight and bias
            %%update with momentum
            input_to_hidden_weights_delta = momentum .* input_to_hidden_weights_delta + input_to_hidden_weights_gradient./batch_size;
            input_to_hidden_weights = input_to_hidden_weights - learning_rate .* input_to_hidden_weights_delta;
            
            hidden_bias_delta = momentum .* hidden_bias_delta + hidden_bias_gradient./batch_size;
            hidden_bias = hidden_bias - learning_rate .* hidden_bias_delta;
            
            hidden_to_output_weights_delta = momentum.* hidden_to_output_weights_delta + hidden_to_output_weights_gradient./batch_size;
            hidden_to_output_weights = hidden_to_output_weights - learning_rate.*hidden_to_output_weights_delta;
            
            output_bias_delta = momentum .* output_bias_delta + output_bias_gradient ./ batch_size;
            output_bias = output_bias - learning_rate .* output_bias_delta;
            
        end;
        fprintf('Train set CE: %f \n',trainset_CE);
        %fprintf('Test CE: %f',test/batch_num); test show that two ways of
        %compute the trainset CE is equal. test == trainset_CE
    end;
end;


%output the parameter of the neural network
model.input_to_hidden_weights = input_to_hidden_weights;
model.hidden_to_output_weights = hidden_to_output_weights;
model.hidden_bias =hidden_bias;
model.output_bias = output_bias;

















