% Mat3Dclass function
% Resample image/VOI matrix
function stat = subsample(self,ix,iy,iz)
% Inputs:   ix = dim1 indices to keep (empty keeps all)
%           iy = dim2 
%           iz = dim3 

stat = false;
if self.check && (nargin==4)
    if isempty(ix)
        ix = 1:self.dims(1);
    end
    if isempty(iy)
        iy = 1:self.dims(1);
    end
    if isempty(iz)
        iz = 1:self.dims(1);
    end
    
    % new code from CJG
    FOV = self.dims(1:3).*self.voxsz;
    self.voxsz(1) = FOV(1)/length(ix);
    self.voxsz(2) = FOV(2)/length(iy);
    self.voxsz(3) = FOV(3)/length(iz);
    %----
    
    self.mat = self.mat(ix,iy,iz,:);
    self.dims(1) = length(ix);
    self.dims(2) = length(iy);
    self.dims(3) = length(iz);
    
    stat = true;
    if isa(self,'ImageClass')
        if self.mask.check
            self.mask.subsample(ix,iy,iz);
        else
            self.mask.setDims(self.dims(1:3));
        end
        if self.prm.check
            self.prm.subsample(ix,iy,iz);
        end
    end
end

