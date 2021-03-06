% CMIclass function
% Manually subsample Image
function imgSubsample(self,x,~)

if isa(x,'matlab.ui.container.Menu')
    answer = inputdlg({'Dim1 indices:','Dim2 indices:','Dim3 indices:'},...
                      'Subsample Image',1,{['1:',num2str(self.img.dims(1))],...
                                           ['1:',num2str(self.img.dims(2))],...
                                           ['1:',num2str(self.img.dims(3))]});
    if ~isempty(answer)
        x = cellfun(@str2num,answer,'UniformOutput',false);
    end
end
if iscell(x) && (length(x)==3)
    stat = self.img.subsample(x{:});
    self.slc = round(self.img.dims(1:3)/2);
    if stat
        self.setView(self.orient);
    end
end