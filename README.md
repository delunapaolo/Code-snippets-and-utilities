This repository contains utility functions and some snippets of code that I wrote or collected. The repo is public for others to take and improve.

Functions, marked by _**F(x)**_, do not usually have any dependency on other files in this repository. This means that you can simply copy the file containing it and use it in your work (if all other external dependencies are satisfied). Functions marked by _**G(x)**_, instead, need other functions in this repository to work correctly. Dependencies are indicated in the file itself. Code snippets are not marked.

---

# python

## console
**[ask](python/console/ask.py)** _**F(x)**_ Function to request user input from console, suggesting possible answers, and with answer data-type validation.

**[numpy_printing](python/console/numpy_printing.py)** Commands to improve printing of numpy arrays.

**[pandas_printing](python/console/pandas_printing.py)** Commands to improve printing of pandas DataFrames.

## Anaconda
**[reinstall_package](python/anaconda/reinstall_package.txt)** Reinstall a package.



## I/O operations
**[matlab_file](python/IO_operations/matlab_file.py)** _**F(x)**_ Function to load MATLAB file containing structures.

**[convert_avi_to_mp4](python/IO_operations/convert_avi_to_mp4.py)** _**F(x)**_ Function to convert AVI videos (e.g., screen captures) to MP4.


## pyQt 5
**[Qt_window](python/pyQt/Qt_window.py)** _**F(x)**_ Subclasses QMainWindow to react to window resizing. Also, the window cannot be closed by (accidentally) clicking the close button, because of a boolean flag that has to be turned on to allow this to happen.


---

# MATLAB

## Arrays
**[idx2range](MATLAB/arrays/idx2range.m)** _**F(x)**_ Function to convert indices, which usually come from a find() call, into a tabular format, where beginning and end of each segment is stored together with its length.

## Strings and Cells
**[uniqueCellRows](MATLAB/strings_and_cells/uniqueCellRows.m)** _**F(x)**_ Fast function to get unique rows in cell array of mixed data types.


---

# R
## console
**[clear_console](R/console/clear_console.txt)** Command to clear all messages from console. Useful at startup.

**[clear_environment](R/console/clear_environment.txt)** Command to remove all variables from environment. Useful at startup.

## Reference cards / Cheatsheets
**[dplyr cheatsheet](reference_cards/dplyr.pdf)** Reference card of commands for data transformation with dplyr.

**[ggplot2 cheatsheet](reference_cards/ggplot2.pdf)** Reference card of commands for data visualization with ggplot2.

**[R for data science cheatsheet](reference_cards/R_for_data_science.pdf)** Tidyverse reference created by [DataCamp](DataCamp.com).

**[Rmarkdown cheatsheet](reference_cards/Rmarkdown.pdf)** Rmarkdown cheatsheet.

**[lubridate cheatsheet](reference_cards/lubridate.pdf)** Dates and times with lubridate.




---
# SQL

---
# Javascript

---
# git
**[BFG_repo_cleaner](git/BFG_repo_cleaner.txt)** Shell commands remove a file history from a repo.

---
# TeX & Co.

**[TeX cheatsheet](reference_cards/TeX.pdf)** Reference card of commands for typesetting in TeX.
