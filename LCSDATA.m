function [theta_exp, w_exp, v_exp, time] = LCSDATA(filename)

%% Go into the folder
addpath("Locomotive_Data_2020/");

%% Create a data extraction function

test_data = readmatrix(filename);

index1 = find(test_data(:, 3) < 1, 1, "first");
subtraction_value = test_data(index1, 2) - 152.5;
test_data(:, 2) = test_data(:, 2) - subtraction_value;

index2 = find(test_data(:, 2) >= 0, 1, "first");

index3 = find(test_data(:, 2) >= 2160, 1, "first");
test_data = test_data(index2:index3, :);

theta_exp = test_data(:, 2);
w_exp = test_data(:, 4);
v_exp = test_data(:, 5) / 10;
time = test_data(:, 1);

end

