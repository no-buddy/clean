# CodeBook

### Structure

The data was unzipped and combined int osingle data frame ordered as:

* subject ID (1-30)
* activity code (1-6)
* 561 columns from test.txt (labels were collected from features.txt)

7352 samples in test data and 2947 in train data.
All these were combined to one table.

Only the columns which represent *means* and *standard deviations* were collected,

### Column Data

The definitions of columns can be found in **features\_info.txt** in the UCI data zipfile.
