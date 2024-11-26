function T_tip = Temp_iterate(const,length,T_base,T_guess)

% Bounds for Integral
v_min = 0;
v_max = sqrt(T_base/T_guess - 1);

% Integral Definition
fun = @(v) ( (v.^2 + 1).^4 + (v.^2 + 1).^3 + (v.^2 + 1).^2 + (v.^2 + 1) + 1 ).^(-1/2);
q = integral(fun,v_min,v_max);
T_compare = T_guess - ((10/const)*(q / length)^2)^(1/3);

% Convergent Method for Final Tip Temperature
while abs(T_compare) > 0.1
    q = integral(fun,v_min,v_max);
    T_compare = T_guess - ((10/const)*(q / length)^2)^(1/3);
    T_guess = T_guess - 0.005 * T_compare / abs(T_compare);
    v_max = sqrt(T_base/T_guess - 1);
end

T_tip = T_guess;

end