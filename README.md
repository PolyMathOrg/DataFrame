# DataFrame for Pharo [![Build Status][travis_b]][travis_url] [![Coverage Status][coveralls_b]][coveralls_url]
In Smalltalk despite the fact that many important analysis tools are already present (for example, in the [PolyMath](https://github.com/PolyMathOrg/PolyMath) library), we are still missing this essential part of the data science toolkit. These specialized data structures for tabular data sets can provide us with a simple and powerful API for summarizing, cleaning, and manipulating a wealth of data sources that are currently cumbersome to use. The DataFrame and DataSeries collections, stored in this repository, are specifically designed for working with structured data.

## Installation
The following script installs DataFrame and its dependencies in Pharo 6

```smalltalk
Metacello new
  baseline: 'DataFrame';
  repository: 'github://PolyMathOrg/DataFrame';
  load.
```

## Tutorial
There are two primary data structures in this package:
* `DataSeries` can be seen as an Ordered Collection that combines the properties of an Array and a Dictionary, while extending the functionality of both. Every DataSeries has a name and contains an array of data mapped to a corresponding array of keys (that are used as index values).
* `DataFrame` is a tabular data structure that can be seen as an ordered collection of columns. It works like a spreadsheet or a relational database with one row per subject and one column for each subject identifier, outcome variable, explanatory variable etc. A DataFrame has both row and column indices which can be changed if needed.

### Creating DataSeries
The easiest way of creating a series is to convert another collection (for example, an Array) to DataSeries

```smalltalk
series := #(a b c) asDataSeries.
```

The keys will be automatically set to the numeric sequence of the array indexes, which can be described as an interval (1 to: n), where n is the size of array. The name of the series at this point will remain empty. Both the name and the keys of a DataSeries can be changed later, as follows:

```smalltalk
series name: 'letters'.
series keys: #(k1 k2 k3).
```

### Creating a DataFrame
There are four ways of creating a data frame:
1. Creating an empty data frame, then filling it with data
2. Creating a data frame from an array of rows
3. Creating a data frame from an array of columns
4. Reading data from a file

#### Creating an empty DataFrame
You can create an empty instance of `DataFrame` using the `new` message

```smalltalk
df := DataFrame new.
```
The data can be added later using the `add:` message.
```smalltalk
df add: #('Barcelona' 1.609 true).
```

#### Creating a DataFrame from an array of rows
This way is the best for creating simple examples for testing since you can see how the data will be arranged in your data frame.

```smalltalk
df := DataFrame fromRows: #(
   ('Barcelona' 1.609 true)
   ('Dubai' 2.789 true)
   ('London' 8.788 false)).
```

#### Creating a DataFrame from an array of columns
We can do the same by passing an array of columns

```smalltalk
df := DataFrame fromColumns: #(
   ('Barcelona' 'Dubai' 'London')
   (1.609 2.789 8.788)
   (true true false)).
```

#### Reading data from a file
This is the most common way of creating a data frame. You have some dataset in a file (CSV, Excel etc.) - just ask a `DataFrame` to read it. At this point only CSV files are supported, but very soon you will also be able to read the data from other formats.

```smalltalk
df := DataFrame fromCSV: 'path/to/your/file.csv'.
```

### Loading the built-in datasets
DataFrame provides several famous datasets for you to play with. They are compact and can be loaded with a simple message. At this only two datasets are supported - [Iris flower dataset](https://en.wikipedia.org/wiki/Iris_flower_data_set) and a simplified [Boston Housing dataset](https://www.kaggle.com/c/house-prices-advanced-regression-techniques/data).

```smalltalk
df := DataFrame loadIris.
df := DataFrame loadHousing.
```

### Exploring the created DataFrame
If we print (Ctrl+P) the data frame that was created from an array of rows or columns as described in previous sections, we will see the following table

```
     1            2      3
1    'Barcelona'  1.609  true
2    'Dubai'      2.789  true
3    'London'     8.788  false
```

As you can see, both row and column names were automatically set to numeric sequences. We can using change them by passing an array of new names. This array must be of the same size as the number of rows and columns.

```smalltalk
df columnNames: #(City Population SomeBool).
df rowNames: #(A B C).
```

Now if we print our data frame, it will look like this

```
     City         Population  SomeBool
A    'Barcelona'  1.609       true
B    'Dubai'      2.789       true
C    'London'     8.788       false
```

To get the dimensions of a data frame, its rows, and columns, we can say

```smalltalk
df dimensions.
df dimensions rows.
df dimensions columns.
```

The first line will return an object of `DataDimensions` class. It is just a specialized `Point` which responds to `rows` and `columns` messages instead of `x` and `y`. It also reimplements the `printOn:` message, so if you press `Ctrl+P` on `df dimensions`, you will see something like this

```
3 rows
3 columns
```

#### Head & tail
Now let's take a look at some bigger dataset, for example, Boston Housing Data

```smalltalk
df := DataFrame loadHousing.
```

This dataset has 489 entries. Printing this many rows is unnecessary. On larger datasets it can also be time consuming. So in order to make sure that the data was loaded and to take a quick look on it, we can print its head (first 5 rows) or tail (last 5 rows)

```smalltalk
df head.
df tail.
```

Data frame responds to these messages with another `DataFrame` object containing the requested rows. Here is the example output of the `df head` message

```
    RM      LSTAT   PTRATIO MDEV
1   6.575   4.98    15.3    504000.0
2   6.421   9.14    17.8    453600.0
3   7.185   4.03    17.8    728700.0
4   6.998   2.94    18.7    701400.0
5   7.147   5.33    18.7    760200.0
```

It is also possible to specify the number of rows that must be printed

```smalltalk
df head: 10.
df tail: 3.
```

The same messages are also supported by the objects of `DataSeries` class. This means that we can also look at a head or tail of a specific column

```smalltalk
(df column: #LSTAT) head: 2.
```

The result will be another series

```
[LSTAT]
1   4.98
2   9.14
```

### Accessing rows and columns
Rows and columns of a data frame can be accessed either by their names or their numeric indexes. Afrer changing the names of rows and columns to `#(A B C)` and `#(City Population SomeBool)`, as shown above, how we can now access row _'C'_ and the column _'Population'_ of a data frame

```smalltalk
df row: 'C'.
df column: 'Population'.
```

We can also access them by their numeric indexes

```smalltalk
df rowAt: 3.
df columnAt: 2.
```

The important feature of a `DataFrame` is that whenever we ask for a specific row or column, it responds with a `DataSeries` object that preserves the same indexing. So, for example, if you take row _'B'_ of a data frame described above, you will get a series named _'B'_ with keys _'City'_, _'Population'_, and _'SomeBool'_.

```
[B]
City        Dubai
Population  2.789
SomeBool    true
```
