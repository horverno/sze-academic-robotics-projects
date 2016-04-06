% Create sample data:
big = ones(10)
small = 9 * ones(3)
% Get sizes
[rowsBig, columnsBig] = size(big);
[rowsSmall, columnsSmall] = size(small);
% Specify upper left row, column of where
% we'd like to paste the small matrix.
row1 = 5;
column1 = 3;
% Determine lower right location.
row2 = row1 + rowsSmall - 1
column2 = column1 + columnsSmall - 1
% See if it will fit.
	% It will fit, so paste it.
	big(row1:row2, column1:column2) = small