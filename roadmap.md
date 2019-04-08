# DataFrame Roadmap

In this document, I describe the functionality that we want to add to DataFrame or existing functionality that we want to improve in the nearest future. For the specific features that need to be added, please check the [issues](https://github.com/PolyMathOrg/DataFrame/issues).

## Improvements

* **DataFrameTypeDetector** - this class can take a data frame of string values such as #('3' '2.1' 'true'), detect the best type for each column and convert all values to those types. This is especially useful when reading data frames from CSV files. All values are read as strings and we need to infer their types. DataFrameTypeDetector must be refactored and improved: add support for more types, make it possible to extend it and add custom types later, etc.
* **Improve the inspector view** - current inspector view based on FastTable needs many improvements: columns must be aligned based on data types, sizes of columns must be chosen in a smarter way, if there are too many columns, we should see a scroll bar, if there is too much data, the image should not freeze, etc.

## New functionality

* **Handling missing values** - finding missing values, replacing them with something. Reading files with missing values. Detecting types of columns that have missing values.
* **Joins** - left, right, inner join of sevaral data frames
* **Time series** - similar to the [Time Series / Date functionality](https://pandas.pydata.org/pandas-docs/stable/user_guide/timeseries.html) in pandas
* **Support for more file formats** - at this moment, we can read/write data from CSV files. Add support for more file formats, for example, Excel. Are there other formats that we should consider?

## Experimental

* **Database backend** - DataFrame is designed using the [Adapter pattern](https://en.wikipedia.org/wiki/Adapter_pattern) to support multiple backends (see DataFrameInternal class). Basically, DataFrame is just a layer of abstraction over some collection (which actually stores the data) that provides a handy API for data analysis. At this point, the data is stored in an Array2D. We would like to try using other backends. One cool thing to try would be a database connection. The user works with DataFrame as before, but under the hood, data is stored in a database (e.g. SQLLite) and DataFrame acts as an interface for querying that database.

## Documentation

* **Examples** - simple examples of using specific methods of DataFrame. They should be stored in DataFrame-Examples packages and executable.
* **Tutorials** - demonstrate the application of data frames to practical data analysis problems. Take some dataset, analyse it, and wrte down the steps. We can reproduce something from [Kaggle](https://www.kaggle.com/).

## Tools around DataFrame

* **Toy Datasets** - a separate repository that contains many popular datasets (such as Iris, Housing, etc.) and a Loader that can load a selected dataset as data frame into your image. There is a similar tool in [scikit-learn](https://scikit-learn.org/stable/datasets/index.html) as well as [data() function in R](https://www.rdocumentation.org/packages/utils/versions/3.5.3/topics/data).
* **DataFrame editor** - it would be nice to have a [Spec](https://github.com/pharo-spec/Spec) view for previewing data frames, searching, querying, and editing them. Inspector only shows a simple table view, but it would be useful to have something similar to Excel (in the end, DataFrame already implements Excel functionality, we only need to add a view for it in Pharo image).
