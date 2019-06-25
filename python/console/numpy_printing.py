# https://docs.scipy.org/doc/numpy/reference/generated/numpy.set_printoptions.html

# suppress : bool
#    If True, always print floating point numbers using fixed point notation, in which case numbers equal to zero in the current precision will print as zero. If False, then scientific notation is used when absolute value of the smallest number is < 1e-4 or the ratio of the maximum absolute value to the minimum is > 1e3. The default is False.


import numpy as np


np.set_printoptions(suppress=True)
