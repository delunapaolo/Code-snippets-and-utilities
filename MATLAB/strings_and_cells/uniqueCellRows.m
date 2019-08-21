function varargout = uniqueCellRows(cell_array_in, varargin)
%uniqueCellRows Function to get the unique rows in a cell array. It can handle
%columns with mixed data types.

p = inputParser;
addOptional(p, 'return_indices', false);
parse(p, varargin{:})
return_indices = p.Results.return_indices;


%% DEMO
if ~exist('cell_array_in', 'var')
    fprintf('This is a demonstration of the function <strong>uniqueCellRows</strong>\n\n')
    
    % Reference: https://uk.mathworks.com/matlabcentral/answers/52708-how-to-find-unique-rows-in-cell-array-in-matlab
    cell_array_in = {'1', '1'; '1', '1'; '1', 1; '1', 1; '2', NaN; '2', NaN};

    fprintf('Given this cell array with mixed data types in the second column:\n\n')
    disp(cell_array_in)
    
    res = uniqueCellRows(cell_array_in);
    fprintf('\n\nThe following are the unique rows of it:\n');
    disp(res)
    
    return
end


%% FUNCTION
% Get number of variables
n_variables = size(cell_array_in, 2);

% Initialize internal variables
variable_map = cell(1, n_variables);
variable_type = cell(1, n_variables);
cell_array_in_converted = NaN(size(cell_array_in));

for i_var = 1:n_variables
    % Get unique values and their indices
    try
        % Use builtin function
        [unique_values, ~, indices] = unique(cell_array_in(:, i_var), 'stable');
        % Mark variable type
        this_variable_type = 'string';
    
    catch ME
        if strcmpi(ME.identifier, 'MATLAB:UNIQUE:InputClass')  % it occurs when cells contain numeric values or content is of mixed data types            
            try
                % Transform cells to matrix
                [unique_values, ~, indices] = unique(cell2mat(cell_array_in(:, i_var)), 'stable');
                % Mark variable type
                this_variable_type = 'numeric';
                
            catch subME
                if strcmpi(subME.identifier, 'MATLAB:cell2mat:MixedDataTypes')  % it occurs when cells contain mixed data types
                    % Get data type of each value
                    values_in = cell_array_in(:, i_var);
                    data_types = cellfun(@class, values_in, 'UniformOutput',false);
                    % Convert everything to a string and then to character array
                    values_in = cellfun(@string, values_in, 'UniformOutput',false);
                    % Replace missing values with 
                    values_in(cellfun(@(x) ismissing(x), values_in)) = {"NaN"};
                    values_in = cellfun(@char, values_in, 'UniformOutput',false);
                    % Concatenate with data type and then select unique
                    % combinations of value and type
                    [~, indices] = uniqueCellRows([values_in, data_types], 'return_indices',true);
                    % The unique pairs of indices correspond the unique values
                    % in the mixed array
                    [~, ~, indices] = unique(indices, 'stable', 'rows');
                    % Take position of each unique value
                    [~, first_index, ~] = unique(indices, 'stable');                    
                    unique_values = cell_array_in(first_index, i_var);
                    % Mark variable type
                    this_variable_type = 'mixed';
            
                else
                    rethrow(subME)
                end
            end
        else
            rethrow(ME)
        end
    end
    
    % Store information
    variable_map{i_var} = unique_values;
    cell_array_in_converted(:, i_var) = indices;
    variable_type{i_var} = this_variable_type;
end

% Get unique rows of indices array
unique_array_out = unique(cell_array_in_converted, 'rows');

% Use the index to retrieve the actual value
cell_array_out = cell(size(unique_array_out));
for i_var = 1:n_variables
    switch variable_type{i_var}
        case {'string', 'mixed'}
            cell_array_out(:, i_var) = variable_map{i_var}(unique_array_out(:, i_var));
            
        case 'numeric'
            cell_array_out(:, i_var) = num2cell(variable_map{i_var}(unique_array_out(:, i_var)));
    end
end

% Return outputs
varargout{1} = cell_array_out;
if return_indices
    varargout{2} = cell_array_in_converted;
end

