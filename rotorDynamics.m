function [state_fut] = rotorDynamics(state, input, step)
    % States are defined as:
    % state(1): roll
    % state(2): roll rate of change
    % state(3): pitch
    % state(4): pitch rate of change
    % state(5): yaw
    % state(6): yaw rate of change
    Ix = 4;
    Iy = 4;
    Iz = 16;
    Prop_inertia = 1;
    drag = 0.0005;
    arm = 0.15;
    
    thrust = input .^ 2;
    U1 = drag * arm * [ 0 -1  0 1] * thrust;
    U2 = drag * arm * [ 1  0 -1 0] * thrust;
    U3 = drag * arm * [-1  1 -1 1] * thrust;
    U = [1 1 1 1] * thrust;
    
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