% CMIclass function
% Set Cmax for current view
function tclim = setClim(self,x,~)
% x = GUI object handle
%     [cmin cmax] (1x2 vector)
tclim = [];
% Determine input value:
if nargin>1
    if (nargin==3) && ishghandle(x) % input from GUI  
        if self.applyallcheck
            tvec = 0;
            tclim = self.clim(self.vec,:);
        elseif self.bgcheck
            tvec = self.bgvec;
            tclim = self.clim(tvec,:);
        else
            tvec = self.vec;
            tclim = self.clim(tvec,:);
        end
        if strcmp(x.Tag(end-2:end),'min')
            ind = 1;
        else % 'max'
            ind = 2;
        end
        if strcmp(x.Tag(1:4),'edit')
            tclim(ind) = str2double(x.String);
        else % 'slider'
            tclim(ind) = x.Value;
        end
    elseif isnumeric(x) && (size(x,2)==3) && ismember(x(1),0:self.img.dims(4))
        tvec = x(:,1);
        tclim = x(:,2:3);
    end
end
% If valid, set properties
if ~isempty(tclim) && ~any(isnan(tclim(:)))
    % Update CMIclass properties & display
    if tvec==0 % update foreground & background images
        self.clim = ones(self.img.dims(4),1)*tclim;
%         self.clim(:,ind) = (tclim(ind)'*ones(1,size(self.clim,1)))';
        self.dispUDbg;
        self.dispUDimg;
    elseif self.bgcheck % update background image
        self.clim(tvec,:) = tclim;
        self.dispUDbg;
    else % only update foreground image
        self.clim(tvec,:) = tclim;
        self.dispUDimg;
    end
    % Update GUI properties
    if self.guicheck
        val = tclim(1);
        if val < self.h.slider_cmin.Min
            val = self.h.slider_cmin.Min;
        elseif val > self.h.slider_cmin.Max
            val = self.h.slider_cmin.Max;
        end
        self.h.slider_cmin.Value = val;
        val = tclim(2);
        if val < self.h.slider_cmax.Min
            val = self.h.slider_cmax.Min;
        elseif val > self.h.slider_cmax.Max
            val = self.h.slider_cmax.Max;
        end
        self.h.slider_cmax.Value = val;
        self.h.edit_cmin.String = num2str(tclim(1));
        self.h.edit_cmax.String = num2str(tclim(2));
    end
    % Update histogram if necessary
    self.dispUDhist;
end
