%% Call LCSDATA function
filenames = ["Test1_5pt5V"; "Test1_6pt5V"; "Test1_7pt5V"; "Test1_8pt5V"; "Test1_9pt5V"; "Test1_10pt5V"];

figure();
for i = 1: length(filenames)
    [theta_exp, w_exp, v_exp, time] = LCSDATA(filenames(i));

    subplot(2, 3, i);
    plot(theta_exp, v_exp, 'b-', 'LineWidth', 1);
    yline(0, 'r-', 'LineWidth', 1);
    xlim([0 2160]);
    ylim([-1650 2160]);
    title("Experimental Velocity vs. Experimental Angular Velocity for " + filenames(i), 'Interpreter', 'none');
    ylabel("Experimental Velocity (mm/s)");
    xlabel("Experimental Angular Velocity (deg/s)");
    grid on;
end


%% Go into the folder
addpath("Locomotive_Data_2020/");

%% Omega Calculation
filenames = ["Test1_5pt5V"; "Test1_6pt5V"; "Test1_7pt5V"; "Test1_8pt5V"; "Test1_9pt5V"; "Test1_10pt5V"];

%% Function

r = 75;
d = 155;
l = 260;
theta = [0: 2160];

figure();
for i = 1: length(filenames)
    [theta_exp, w_exp, v_exp, time] = LCSDATA(filenames(i));
    
    w = mean(w_exp);

    [v_mod] = LCSMODEL(r, d, l, theta, w);
    subplot(2, 3, i);
    plot(theta, v_mod, 'b-', 'LineWidth', 1);
    yline(0, 'r-', 'LineWidth', 1);
    xlim([0 2160]);
    ylim([-1650 2160]);
    title("Model Velocity vs. Model Angular Velocity for " + filenames(i), 'Interpreter', 'none');
    ylabel("Model Velocity (mm/s)");
    xlabel("Model Angular Velocity (deg/s)");
    grid on;
end
