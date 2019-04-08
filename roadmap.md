# DataFrame Roadmap

In this document, I describe the functionality that we want to add to DataFrame or existing functionality that we want to improve in the nearest future. For the specific features that need to be added, please check the [issues](https://github.com/PolyMathOrg/DataFrame/issues).

## Improvements

* **DataFrameTypeDetector** - this class can take a data frame of string values such as #('3' '2.1' 'true'), detect the best type for each column and convert all values to those types. This is especially useful when reading data frames from CSV files. All values are read as strings and we need to infer their types. DataFrameTypeDetector must be refactored and improved: add support for more types, make it possible to extend it and add custom types later, etc.
* **Improve the inspector view** - current inspector view based on FastTable needs many improvements: columns must be aligned based on data types, sizes of columns must be chosen in a smarter way, if there are too many columns, we should see a scroll bar, if there is too much data, the image should not freeze, etc.

## New functionality

* Handling missing values
* Joins
* Time series
* Support for more file formats

## Experimental

* Database backend

## Documentation

* Examples
* Tutorials

## Tools around DataFrame

* Datasets
* DataFrame editor
