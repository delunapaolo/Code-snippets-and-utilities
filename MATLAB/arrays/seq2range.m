function ranges = seq2range(seq, varargin)
% seq2range Function to convert a sequence of indices into a tabular format,
% where beginning and end of each segment is stored together with its length.
% 
% Run seq2range without inputs for a demo.

%% DEMO
if ~exist('seq', 'var')
    % Make and show input
    seq = [1, 1, 1, 2, 2, 2, 3, 3, 3, 3, 3, 3, 5, 5, 8];
    fprintf('This is a demonstration of the function <strong>seq2range</strong>\n\n')
    fprintf('Given this sequence of indices:\n')
    disp(seq)
    
    % Compute and show result
    ranges = seq2range(seq, 'return_as_table',true);
    fprintf('\nThe following are the ranges of them:\n');
    disp(ranges)
    
    % Quit demo
    ranges = '-- end of demo ---';
    return
end

%% FUNCTION
% Parse inputs
p = inputParser();
addParameter(p, 'return_as_table', false)  % Whether the input is a table. If false, it is an array
parse(p)
return_as_table = p.Results.return_as_table;

% Make a vector
seq = seq(:);

% Check what to do based on the number of elements in the input array
switch length(seq)
	case 0  % If the input contains no data, return an empty result
	    ranges = [0, 0, NaN];
	    
 	case 1
	 	ranges = [1, 1, 1];
	 	 	
 	otherwise
 		% Look for when indices do not repeat
		ranges = [1; find(diff(seq) > 1) + 1];
		% Concatenate beginning, end and duration of each interval
		if size(ranges, 1) ~= 1  % If there is more than 1 interval
			ranges(:,2) = [ranges(2:end)-1; length(seq)];
			ranges = seq(ranges);
			ranges(:,3) = (ranges(:,2) - ranges(:,1)) + 1;
		else
			ranges(:,2) = length(seq);
			ranges = seq(ranges).';
			ranges(:,3) = ((ranges(:,2) - ranges(:,1)) + 1).';
		end
end

% Convert output, if requested
if return_as_table
	ranges = array2table(ranges, 'VariableNames',{'start', 'end', 'duration'})
end
