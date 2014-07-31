function [ error_rate ] = test( model, choice )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
[test_data, test_target, row] = load_data('./trainingDigits');


input_to_hidden_weights = model.input_to_hidden_weights ;
hidden_to_output_weights = model.hidden_to_output_weights ;
hidden_bias = model.hidden_bias ;
output_bias = model.output_bias ;

error_example = 0;
num_example = size(test_data,1);
[hidden_state, output_state] = fprop(test_data, input_to_hidden_weights, hidden_to_output_weights, hidden_bias, output_bias);

result = zeros(num_example,1);
for i =1:num_example
    result(i) = find(output_state(i,:) == max(output_state(i,:)));
    if(result(i) ~= test_target(i))
        error_example = error_example + 1;
        if(choice == 1)
            plot_data(test_data(i,:),row);
            fprintf('The number is %d, the detected result is %d \n',test_target(i),result(i));
            pause;
        end;
    end;
end;


error_rate = error_example/num_example;
end

