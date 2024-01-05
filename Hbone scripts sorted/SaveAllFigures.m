function SaveAllFigures (Folder)
%Folder = fullfile(pwd, '\Angles_cyan');
AllFigH = allchild(groot);
for iFig = 1:numel(AllFigH)
  fig = AllFigH(iFig);
  FileName = [fig.Name, '.png'];
  saveas(fig, fullfile(Folder, FileName));
end
end