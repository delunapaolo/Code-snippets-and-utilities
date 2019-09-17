function ranges = idx2range(idx, varargin)
% idx2range Function to convert indices, which usually come from a find() call, 
% into a tabular format, where beginning and end of each segment is stored 
% together with its length.
% 
% Run idx2range without inputs for a demo.

%% DEMO
if ~exist('idx', 'var')
    % Make and show input
    fprintf('This is a demonstration of the function <strong>idx2range</strong>\n\n')
    fprintf('Given this array:\n')
    ar = [1, 1, 1, 1, 1, 2, 2, 1, 1, 2, 1, 1, 1, 2, 1, 2, 2, 1, 1, 1];
    disp(ar)
    
    fprintf('The following is the location of the number 1:\n')
    idx = find(ar == 1);
    disp(idx)
    
    % Compute and show result
    ranges = idx2range(idx, 'return_as_table',true);
    fprintf('\nThe following are the ranges of continuous indices:\n');
    disp(ranges)
    
    % Quit demo
    ranges = '-- end of demo ---';
    return
end

%% FUNCTION
% Parse inputs
p = inputParser();
addParameter(p, 'return_as_table', false)  % Whether the input is a table. If false, it is an array
parse(p, varargin{:})
return_as_table = p.Results.return_as_table;

% Convert to unique, sorted vector
idx = unique(idx(:));

% Check what to do based on the number of elements in the input array
switch length(idx)
	case 0  % If the input contains no data, return an empty result
	    ranges = [0, 0, NaN];
	    
 	case 1
	 	ranges = [1, 1, 1];
	 	 	
 	otherwise
 		% Look for when indices do not repeat
		ranges = [1; find(diff(idx) > 1) + 1];
		% Concatenate beginning, end and duration of each interval
		if size(ranges, 1) ~= 1  % If there is more than 1 interval
			ranges(:,2) = [ranges(2:end)-1; length(idx)];
			ranges = idx(ranges);
			ranges(:,3) = (ranges(:,2) - ranges(:,1)) + 1;
		else
			ranges(:,2) = length(idx);
			ranges = idx(ranges).';
			ranges(:,3) = ((ranges(:,2) - ranges(:,1)) + 1).';
		end
end

% Convert output, if requested
if return_as_table
	ranges = array2table(ranges, 'VariableNames',{'first_idx', 'last_idx', 'n'});
end
