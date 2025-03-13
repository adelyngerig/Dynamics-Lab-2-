clc;
clear;
close all;

%% Call LCSMODEL Function
r = 7.5;
d = 15.5;
l = 26.0;

filenames = ["Test1_5pt5V"; "Test1_6pt5V"; "Test1_7pt5V"; "Test1_8pt5V"; "Test1_9pt5V"; "Test1_10pt5V"];


figure();
for i = 1: length(filenames)
    [theta_exp, w_exp, v_exp, time] = extractData(filenames(i));
    
    w = mean(w_exp) * (pi / 180);

    [v_mod] = LCSMODEL(r, d, l, theta_exp, w);
    subplot(2, 3, i);
    plot(theta_exp, v_mod, 'k-', 'LineWidth', 1);
    yline(0, 'r-', 'LineWidth', 1);
    xlim([0 2160]);
    ylim([-165 216]);
    title("Model Velocity vs. Model Angle for " + filenames(i), 'Interpreter', 'none');
    ylabel("Model Velocity (cm/s)");
    xlabel("Model Angle (deg)");
    grid on;
end

%% Call LCSDATA function

figure();
for i = 1: length(filenames)
    [theta_exp, w_exp, v_exp, time] = extractData(filenames(i));

    w = w_exp .* (pi / 180);

    [v_mod] = LCSMODEL(r, d, l, theta_exp, w);

    subplot(2, 3, i);
    plot(theta_exp, v_exp, 'g-', 'LineWidth', 1);
    hold on;
    plot(theta_exp, v_mod, 'k-', 'LineWidth', 1);
    hold off;
    yline(0, 'r-', 'LineWidth', 1);
    xlim([0 2160]);
    ylim([-165 216]);
    title("Velocity vs. Angle for " + filenames(i), 'Interpreter', 'none');
    ylabel("Velocity (cm/s)");
    xlabel("Angle (deg)");
    legend('Experimental Data', 'Model');
    grid on;
end

%% Residual and Error

figure();
for i = 1: length(filenames)
    [theta_exp, w_exp, v_exp, time] = extractData(filenames(i));

    w = mean(w_exp) * (pi / 180);

    [v_mod] = LCSMODEL(r, d, l, theta_exp, w);

    v_diff = v_exp - v_mod;

    subplot(2, 3, i);
    plot(time, v_diff, 'r-', 'LineWidth', 1);
    yline(0, 'k-', 'LineWidth', 1);
    ylim([-50 50]);
    xlim([0 7]);
    title("Residuals vs. Time for " + filenames(i), 'Interpreter', 'none');
    ylabel("Velocity (cm/s)");
    xlabel("Time (s)");
    grid on;

    % mean and stardard deviation
    average(i) = mean(v_diff);
    sigma(i) = std(v_diff);

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



