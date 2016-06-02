warning('off','MATLAB:xlswrite:AddSheet')
disp('It will take some time, do not open xlsx until finished.');
% Write headers
xlswrite('DbExport.xlsx', {'X', 'Y', 'Z', 'Alpha', 'Beta', 'Gamma', 'Noise', 'Measurement x and y'}, 'DataBase', 'A1');
% Write data
for n = 1:size(Db,2)
    disp(strcat('Current iteration: ', num2str(n), '/', num2str(size(Db,2))));
    xlswrite('DbExport.xlsx',Db(n).RelPos.X,    'DataBase',strcat('A', num2str(n*2)));
    xlswrite('DbExport.xlsx',Db(n).RelPos.Y,    'DataBase',strcat('B', num2str(n*2)));
    xlswrite('DbExport.xlsx',Db(n).RelPos.Z,    'DataBase',strcat('C', num2str(n*2)));  
    xlswrite('DbExport.xlsx',Db(n).RelOri.Alpha,'DataBase',strcat('D', num2str(n*2)));
    xlswrite('DbExport.xlsx',Db(n).RelOri.Beta, 'DataBase',strcat('E', num2str(n*2)));
    xlswrite('DbExport.xlsx',Db(n).RelOri.Gamma,'DataBase',strcat('F', num2str(n*2)));      
    xlswrite('DbExport.xlsx',Db(n).Noise,       'DataBase',strcat('G', num2str(n*2)));
    xlswrite('DbExport.xlsx',Db(n).Meas(1,:),   'DataBase',strcat('H', num2str(n*2)));  
    xlswrite('DbExport.xlsx',Db(n).Meas(2,:),   'DataBase',strcat('H', num2str(n*2 + 1)));    
end
disp('DbExport.xlsx created.');
