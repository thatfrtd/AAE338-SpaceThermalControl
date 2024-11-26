clc
clear all

% Constants and Variables
boltz = 5.67e-8;
emiss = 1;
k_cond = 1500;
thickness = 0.0254;
length = 3;
width = 10;

T_base = 230;
T_guess = input('Initial guess for tip temperature (K): ');

area_base = width*thickness;
const = boltz * emiss / (k_cond * thickness);
x_span = [0 length];

% Iterative Solution for Tip Temperature
T_tip = Temp_iterate(const,length,T_base,T_guess);

% ode45 Solution
yprime = @(t,y) -(0.4*const.*(y.^5) - 0.4*const*(T_tip^5)).^(1/2);
[t,y] = ode45(yprime,x_span,T_base);

Q_dot = k_cond*area_base*sqrt(0.4*const*(T_base^5 - T_tip^5));
fprintf('Rate of Heat Rejection is %.1f W \n',Q_dot)

plot(t,y)
grid on
xlabel('Distance from Base (m)')
ylabel('Radiator Temperature (K)')