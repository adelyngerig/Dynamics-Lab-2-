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
    title("Experimental Velocity vs. Experimental Angle for " + filenames(i), 'Interpreter', 'none');
    ylabel("Experimental Velocity (mm/s)");
    xlabel("Experimental Angle (deg)");
    grid on;
end

%% Call LCSMODEL Function
r = 0.75;
d = 1.55;
l = 2.60;
theta = 0: 2160;

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
    title("Model Velocity vs. Model Angle for " + filenames(i), 'Interpreter', 'none');
    ylabel("Model Velocity (mm/s)");
    xlabel("Model Angle (deg)");
    grid on;
end
