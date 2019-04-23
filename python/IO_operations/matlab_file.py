import h5py
import scipy.io as spio


def load(filename, force_dictionary=False, return_metadata=False, **kwargs):
    """
    This function should be called instead of direct spio.load
    as it cures the problem of not properly recovering python dictionaries
    from mat files. It calls the function check keys to cure all entries
    which are still mat-objects.
    
    :param force_dictionary: [bool] Whether to force the output to be a
    	dictionary when there is only 1 variable in the MAT file.
    :param return_metadata: [bool] Whether to return metadata of MAT file.
    :param kwargs are passed to scipy.io.loadmat()
    
    :return data: [dict] Content of MAT file.
    :return metadata: [dict] Optional metadata of MAT file.
    """
    
    # Override default parameters
    user_kwargs = kwargs.keys()
    if 'struct_as_record' in user_kwargs:
        kwargs.pop('struct_as_record')
    if 'squeeze_me' in user_kwargs:
        kwargs.pop('squeeze_me')
    # Extract user inputs
	variable_names = kwargs.get('variable_names', None)

    try:
        data = spio.loadmat(filename, struct_as_record=False, squeeze_me=True, **kwargs)
        # Convert objects to nested dictionaries and return
        data = _check_keys(data)
        # Extract metadata
        metadata = {v: data[v] for v in ['__version__', '__header__', '__globals__']}
        # Remove metadata
        data = {v: data[v] for v in data.keys() if v not in ['__version__', '__header__', '__globals__']}

    except NotImplementedError:
    	# Fallback method
        with h5py.File(filename, mode='r', libver='latest') as f:
            data = {k: f[k][:] for k in list(f.keys()) if not k.startswith('#')}
            metadata = dict()

    # If user requested only some variables, return only those
    if variable_names is not None:
        # Make 'variable_names' a list
        if isinstance(variable_names, str):
            variable_names = [variable_names]
        data = {v: data[v] for v in variable_names}

    else:
        variable_names = list(data.keys())

    # Return result directly if only one variable requested
    if len(variable_names) == 1 and not force_dictionary:
        data = data[variable_names[0]]

    if not return_metadata:
        return data
    else:
        return data, metadata


def _check_keys(dict):
    """
    checks if entries in dictionary are mat-objects. If yes
    _todict is called to change them to nested dictionaries
    """
    for key in dict:
        if isinstance(dict[key], spio.matlab.mio5_params.mat_struct):
            dict[key] = _todict(dict[key])
    return dict


def _todict(matobj):
    """
    A recursive function which constructs from matobjects nested dictionaries
    """
    dict = {}
    for strg in matobj._fieldnames:
        elem = matobj.__dict__[strg]
        if isinstance(elem, spio.matlab.mio5_params.mat_struct):
            dict[strg] = _todict(elem)
        else:
            dict[strg] = elem
    return dict
