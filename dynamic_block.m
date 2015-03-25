function dynamic_block(block)
% dynamic_block is a Level-2 MATLAB S-Function for implementing
% a quadrotor nonlinear dynamic model in SIMULINK
setup(block);
%endfunction

%% Function: setup ===================================================
%% Abstract:
%%   Set up the basic characteristics of the S-function block such as:
%%   - Input ports
%      The block handles two inputs:
%       - System states
%       - System inputs
function setup(block)

% Register number of ports
block.NumInputPorts  = 1;
block.NumOutputPorts = 1;

% Setup port properties to be inherited or dynamic
block.SetPreCompInpPortInfoToDynamic;
block.SetPreCompOutPortInfoToDynamic;

% Override input port properties
block.InputPort(1).Dimensions  = 4;
block.InputPort(1).DatatypeID  = 0;  % double
block.InputPort(1).Complexity  = 'Real';
block.InputPort(1).DirectFeedthrough = false;

% Override output port properties
block.OutputPort(1).Dimensions  = 6;
block.OutputPort(1).DatatypeID  = 0; % double
block.OutputPort(1).Complexity  = 'Real';

% Register parameters
block.NumDialogPrms     = 1;

% Register sample times
block.SampleTimes = [0.001 0];

block.RegBlockMethod('PostPropagationSetup', @DoPostPropSetup);
block.RegBlockMethod('InitializeConditions', @InitConditions);
block.RegBlockMethod('Outputs',              @Outputs);
block.RegBlockMethod('Update',               @Update);
%end setup

%% PostPropagationSetup:
%  Discrete state definition
function DoPostPropSetup(block)
block.NumDworks = 1;
  block.Dwork(1).Name            = 'state';
  block.Dwork(1).Dimensions      = 6;
  block.Dwork(1).DatatypeID      = 0;      % double
  block.Dwork(1).Complexity      = 'Real'; % real
  block.Dwork(1).UsedAsDiscState = true;
  
%%
%% InitializeConditions:
%%   Functionality    : Called at the start of simulation and if it is 
%%                      present in an enabled subsystem configured to reset 
%%                      states, it will be called when the enabled subsystem
%%                      restarts execution to reset the states.
%%   Required         : No
%%   C-MEX counterpart: mdlInitializeConditions
%%
function InitConditions(block)
block.Dwork(1).Data = block.DialogPrm(1).Data;
%end InitializeConditions

%%
%% Outputs:
function Outputs(block)

block.OutputPort(1).Data = block.Dwork(1).Data;

%end Outputs

%%
%% Update:
%%   Functionality    : Called to update discrete states
%%                      during simulation step
%%   Required         : No
%%   C-MEX counterpart: mdlUpdate
%%
function Update(block)
block.Dwork(1).Data = rotorDynamics(block.Dwork(1).Data, block.InputPort(1).Data, 0.001);

%end Update

function Terminate(block)

%end Terminate