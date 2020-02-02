function act_ima(block)
%% This function is a Level-2 MATLAB S-Function that is used to send Image 
% data from Simulink and display it within a MATLAB GUI. It uses the
% Level-2 S-Function template supplied by MathWorks.
%
% Created by Juan Felipe, 4-Sep-2018
  setup(block);

%endfunction

function setup(block)
  
  %% Register number of ports
  block.NumInputPorts  = 3; % If you want to disply a RGB video.
  block.NumOutputPorts = 0; % Only a 'sink'.
  
  %% Setup functional port properties
  block.SetPreCompInpPortInfoToDynamic;

  % Need three inputs for each color. Level-2 sfunctions can't receieve
  % signals greater than 2 dimensions, so have to split the input to 3
  % signals.... :-(
  block.InputPort(1).DatatypeID   = 1; 
  block.InputPort(1).Complexity   = 'Real';
  block.InputPort(1).SamplingMode = 0.01;
  block.InputPort(2).DatatypeID   = 1; 
  block.InputPort(2).Complexity   = 'Real';
  block.InputPort(1).SamplingMode = 0.01;
  block.InputPort(3).DatatypeID   = 1; 
  block.InputPort(3).Complexity   = 'Real';
  block.InputPort(3).SamplingMode = 0.01;
  
  %
  %-1 for 'inherited',
%0 for 'double',
%1 for 'single',
%2 for 'int8',
%3 for 'uint8',
%4 for 'int16',
%5 for 'uint16',
%6 for 'int32',
%7 for 'uint32',
%8 for 'boolean"
  %
  %% Register dialog parameters
  block.NumDialogPrms = 0; % Not needed.

  %% Set the block simStateCompliance to none.
  % This will ensure that the handle store in dwork is not saved and restored
  block.SimStateCompliance = 'HasNoSimState';

  %'HasNoSimState'
  %'UnknownSimState', 'DefaultSimState', 'CustomSimState', 'DisallowSimState'
  %% Register block methods
  block.RegBlockMethod('SetInputPortDimensions',  @SetInpPortDims);
  block.RegBlockMethod('Outputs',                 @Output);


function SetInpPortDims(block,idx,di) %#ok<INUSL>
  block.InputPort(1).Dimensions = di; % Get the dimension from the block.
  block.InputPort(2).Dimensions = di;
  block.InputPort(3).Dimensions = di;
%endfunction
  
function Output(block)
% Concatenate the 3 images into one.
img = cat(3,...
    block.InputPort(1).Data,...
    block.InputPort(2).Data, ...
    block.InputPort(3).Data);
%Send data to axes
setappdata(0,'Name',img)
