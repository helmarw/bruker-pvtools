% ElxClass function
% Set Elastix parameters in existing schedule
function setTx0par(self,varargin)
% Set current parameter value
% OR add new parameter value
% OR remove existing parameter (value of Name/Value pair is empty)

if (nargin>2)
    if isstruct(varargin{1})
        tstruct = varargin{1};
        str = fieldnames(tstruct);
        for j = 1:length(str)
            if isfield(self.Tx0,str{j})
                self.Tx0.(str{j}) = tstruc.(str{j});
            end
        end
    elseif mod(length(varargin),2)==0 % Name/Value pairs
        for j = 1:2:length(varargin)
            if ischar(varargin{j})
                if strcmp(varargin{j},'check')
                    if islogical(varargin{j+1})
                        self.T0check = varargin{j+1};
                    end
                elseif isempty(varargin{j+1}) && isfield(self.Tx0,varargin{j})
                    self.Tx0 = rmfield(self.Tx0,varargin{j});
                else
                    self.Tx0.(varargin{j}) = varargin{j+1};
                end
            end
        end
    else
        error('Invalid inputs.')
    end
end
