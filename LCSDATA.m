%% Function for taking the data and cleaning it and plotting it so that it is values that we can use

clc;
clear;
close all;

%% Go into the folder
addpath("Locomotive_Data_2020/");

%% Call function
filenames = ["Test1_5pt5V"; "Test1_6pt5V"; "Test1_7pt5V"; "Test1_8pt5V"; "Test1_9pt5V"; "Test1_10pt5V"];

for i = 1: size(filenames)
    [theta_exp, w_exp, v_exp, time] = extractData(filenames(i));

    figure();
    plot(v_exp, theta_exp, 'b-', 'LineWidth', 1);
    xlim([-2000 2500]);
    title("Experimental Velocity vs. Experimental Angular Velocity for " + filenames(i), 'Interpreter', 'none');
    xlabel("Experimental Velocity (mm/s)");
    ylabel("Experimental Angular Velocity (deg/s)");
    grid on;
end

%% Create a data extraction function
function [theta_exp, w_exp, v_exp, time] = extractData(filename)

test_data = readmatrix(filename);

index1 = find(test_data(:, 3) < 1, 1, "first");
subtraction_value = test_data(index1, 2) - 152.5;
test_data(:, 2) = test_data(:, 2) - subtraction_value;

index2 = find(test_data(:, 2) >= 0, 1, "first");

index3 = find(test_data(:, 2) >= 2160, 1, "first");
test_data = test_data(index2:index3, :);

theta_exp = test_data(:, 2);
w_exp = test_data(:, 4);
v_exp = test_data(:, 5);
time = test_data(:, 1);

end

