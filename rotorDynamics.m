function [state_fut] = rotorDynamics(state, input, step)
    % States are defined as:
    % state(1): roll
    % state(2): roll rate of change
    % state(3): pitch
    % state(4): pitch rate of change
    % state(5): yaw
    % state(6): yaw rate of change
    Ix = 8.1E-3;
    Iy = 8.1E-3;
    Iz = 14.2E-3;
    Prop_inertia = 104E-6;
    b = 54.2*10^(-6);  % Thrust factor
    d = 1.1*10^(-6);  % Drag factor
    arm = 0.24;


    thrust = input .^ 2;
    U1 = b * arm * [ 0 -1 0 1] * thrust;
    U2 = b * arm * [-1  0 1 0] * thrust;
    U3 = d * arm * [ 1 -1 1 -1] * thrust;
    U = [-1 1 -1 1] * thrust;
    
    state_fut = zeros(6,1);
    
    state_fut(1) = state(1) + state(2) * step;
    state_fut(2) = state(2) + state(4) * state(6) * (Iy - Iz) * step / Ix + ...
        Prop_inertia * state(2) * U * step / Ix + arm * U1 * step / Ix;
    state_fut(3) = state(3) + state(4) * step;
    state_fut(4) = state(4) + state(2) * state(6) * (Iz - Ix) * step / Iy + ...
        Prop_inertia * state(2) * U * step / Iy + arm * U2 * step / Iy;
    state_fut(5) = state(5) + state(6) * step;
    state_fut(6) = state(6) + state(2) * state(4) * (Ix - Iy) * step / Iz + ...
        U3 / Iz;
    return;
end