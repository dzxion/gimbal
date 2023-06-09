function attitude_dynamic(block)
% Level-2 MATLAB file S-Function.

%   Copyright 1990-2009 The MathWorks, Inc.

  setup(block);
  
%endfunction

function setup(block)
  %% Register number of dialog parameters   
  block.NumDialogPrms = 1;
  
  %% Register number of input and output ports
  block.NumInputPorts  = 1;
  block.NumOutputPorts = 1;

  %% Setup functional port properties to dynamically
  %% inherited.
  block.SetPreCompInpPortInfoToDynamic;
  block.SetPreCompOutPortInfoToDynamic;
 
  block.InputPort(1).Dimensions        = [3,1];
  block.InputPort(1).DirectFeedthrough = false;
  
%   block.InputPort(2).Dimensions        = [3,1];
%   block.InputPort(2).DirectFeedthrough = false;
  
  block.OutputPort(1).Dimensions       = [3,3];
  
  %% Set block sample time to continuous
  block.SampleTimes = [0 0];
  
  %% Setup Dwork
  block.NumContStates = 9;
  
  %% Set the block simStateCompliance to default (i.e., same as a built-in block)
  block.SimStateCompliance = 'DefaultSimState';

  %% Register methods
%   block.RegBlockMethod('PostPropagationSetup',    @DoPostPropSetup);
  block.RegBlockMethod('InitializeConditions',    @InitConditions);  
  block.RegBlockMethod('Outputs',                 @Output);  
%   block.RegBlockMethod('Update',                  @Update); 
  block.RegBlockMethod('Derivatives',             @Derivative);
  
%endfunction

function DoPostPropSetup(block)

  %% Setup Dwork
%   block.NumDworks = 1;
%   block.Dwork(1).Name = 'x0'; 
%   block.Dwork(1).Dimensions      = 1;
%   block.Dwork(1).DatatypeID      = 0;
%   block.Dwork(1).Complexity      = 'Real';
%   block.Dwork(1).UsedAsDiscState = true;

%endfunction

function InitConditions(block)

%% Initialize Dwork
%   block.Dwork(1).Data = block.DialogPrm(1).Data;
pa = block.DialogPrm(1).Data;
euler_init = pa.euler_init;
R_init = eul2rot(euler_init);
block.ContStates.Data = [R_init(1,1);
                         R_init(2,1);
                         R_init(3,1);
                         R_init(1,2);
                         R_init(2,2);
                         R_init(3,2);
                         R_init(1,3);
                         R_init(2,3);
                         R_init(3,3);];
  
%endfunction

function Output(block)

block.OutputPort(1).Data = [block.ContStates.Data(1:3),block.ContStates.Data(4:6),block.ContStates.Data(7:9)];
  
%endfunction

function Derivative(block)

omega = block.InputPort(1).Data;
Sw = skew_symmetric_matrix(omega);
R = [block.ContStates.Data(1:3),block.ContStates.Data(4:6),block.ContStates.Data(7:9)];
R_dot = R*Sw;
block.Derivatives.Data = [R_dot(:,1);
                          R_dot(:,2);
                          R_dot(:,3);];

%endfunction

function Update(block)

%   block.Dwork(1).Data = block.InputPort(1).Data;
  
%endfunction

