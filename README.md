# DataFrame for Pharo
[![Project Status: Active – The project has reached a stable, usable state and is being actively developed.](http://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/#active)
[![Build Status](https://travis-ci.org/PolyMathOrg/DataFrame.svg?branch=master)](https://travis-ci.org/PolyMathOrg/DataFrame)
[![Build status](https://ci.appveyor.com/api/projects/status/1wdnjvmlxfbml8qo?svg=true)](https://ci.appveyor.com/project/olekscode/dataframe)
[![Coverage Status](https://coveralls.io/repos/github/PolyMathOrg/DataFrame/badge.svg?branch=master)](https://coveralls.io/github/PolyMathOrg/DataFrame?branch=master)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/PolyMathOrg/DataFrame/master/LICENSE)

Dataframe was a GSOC 2017 project for Pharo from Oleksandr Zaytsev. See his video presentation here: https://www.youtube.com/watch?v=H-bVVqPPsY8&list=PL4actYd6bfnzoYJYjSRxLezkYOoLhku09&index=2

Data frames are the essential part of the data science toolkit. They are the specialized data structures for tabular data sets that provide us with a simple and powerful API for summarizing, cleaning, and manipulating a wealth of data sources that are currently cumbersome to use. The DataFrame and DataSeries collections, stored in this repository, are specifically designed for working with structured data.

DataFrame library consists of two primary data structures:
* `DataFrame` is a spreadsheet-like tabular data structure that works like a relational database by providing the API for querying the data. Each row represents an observation, and every column is a feature. Both rows and columns of a data frame have names (keys) by which they can be accessed.
* `DataSeries` is an array-like data structure used for working with specific rows or columns of a data frame. It has a name and contains an array of data mapped to a corresponding array of keys. DataSeries is a SequenceableCollection that combines the properties of an Array and a Dictionary, while extending the functionality of both by providing advanced messages for working with data, such as statistical summaries, visualizations etc.

## Tutorial

1. [Installation](#installation)
2. [Creating DataSeries](#creating-dataseries)
3. [Accessing elements of DataSeries](#accessing-elements-of-dataseries)
4. [Adding new elements to DataSeries](#adding-new-elements-to-dataseries)
5. [Creating DataFrame](#creating-dataframe)
    1. [Creating DataFrame from an array of rows or columns](#1-creating-dataframe-from-an-array-of-rows-or-columns)
    2. [Creating DataFrame from a Matrix](#2-creating-dataframe-from-a-matrix)
    3. [Reading data from file](#3-reading-data-from-file)
    4. [Loading the built-in datasets](#4-loading-the-built-in-datasets)
6. [Accessing rows and columns](#accessing-rows-and-columns)
    1. [Head & tail](#head--tail)
7. [Adding new rows and columns to DataFrame](#adding-new-rows-and-columns-to-dataframe)
8. [Transposed DataFrame](#transposed-dataframe)
9. [The select:where: queries](#the-selectwhere-queries)
10. [Aggregation and Grouping](#aggregation-and-grouping)


### Installation
The following script installs DataFrame and its dependencies into a Pharo image. Along with all the other code blocks in this tutorial, this script has been tested on Pharo-6.1 and Pharo64-6.1 for both Linux and OSX, and Pharo-6.1 for Windows.

```smalltalk
Metacello new
  baseline: 'DataFrame';
  repository: 'github://PolyMathOrg/DataFrame';
  load.
```

### Creating DataSeries
DataSeries can be created from an array of values

```smalltalk
series := DataSeries fromArray: #(a b c).
```

By extending the Collection class DataFrame library provides us with a handy shortcut for converting any collection (e.g. an Array) to DataSeries

```smalltalk
series := #(a b c) asDataSeries.
```

By default the keys will be initialized with an interval `(1 to: self size)`. The name of a newly created series is considered empty and set by default to `nil`. You can always change the name and keys of your series using these messages

```smalltalk
series name: 'letters'.
series keys: #(k1 k2 k3).
```

### Accessing elements of DataSeries
When accessing the elements of a DataSeries, you can think of is as an Array. `at:` message allows you to access elements by their index, with `at:put:` you can modify the given element.

```smalltalk
series at: 2.    "b"
series at: 3 put: 'x'.
``` 

Besides the standard Array accessors, DataSeries provides additional operations for accessing elements by their keys

```smalltalk
series atKey: #k2.    "b"
series atKey: #k3 put: 'x'.
``` 

Messages for enumerating, such as `do:` or `withIndexDo:` work the same as in Array, and the `collect:` message creates a new DataSerie preserving the name and keys of the receiver.

```smalltalk
newSeries := series collect: [ :each | each, 'x' ].
newSeries name.         "letters"
newSeries atKey: 'k1'.  "ax"
```

### Adding new elements to DataSeries
Since all the elements of DataSeries are expected to have keys, in order to add a new element you must specify a key that should be associated with it

```smalltalk
series add: 'x' atKey: #k4.
``` 

In future there will also be an `add:` message that will choose a default key value or even predict the next element of a sequence of keys. For example, if keys are `#(1 2 3 4 5)`, the new element will be associated with key `6`, if the sequence of keys is `#(2 4 6)`, the next key will be `8`. Perhaps, it will even be possible to predict the next key in symbolic sequences, such as `#(a b c d)` or `#(k1 k2 k3)`. Such functionality is not easy to implement, so we leave it for future releases of DataFrame library.

Another way of adding an element to DataSeries is by using the `atKey:put:` message with a non-existing key. Inspired by Pandas, `atKey:put:` modifies an element at a given key if such key exists in a DataSeries, or adds a new element associeted with that key, if it wasn't found.

```smalltalk
series atKey: #k4 put: 'x'.
```

Keep in mind that both `add:atKey:` and `atKey:put:` messages don't create a new series, but modify the existing one. So use them with caution.

### Creating DataFrame
There are four ways of creating a data frame:
1. [from an array of rows or columns](#1-creating-dataframe-from-an-array-of-rows-or-columns)
2. [from matrix](#2-creating-dataframe-from-a-matrix)
3. [from file](#3-reading-data-from-file)
4. [loading a built-in dataset](#4-loading-the-built-in-datasets)

#### 1. Creating DataFrame from an array of rows or columns
The easiest and most straightforward way of creating a DataFrame is by passing all data in an array of arrays to `fromRows:` or `fromColumns:` message. Here is an example of initializing a DataFrame with rows:

```smalltalk
df := DataFrame fromRows: #(
   ('Barcelona' 1.609 true)
   ('Dubai' 2.789 true)
   ('London' 8.788 false)).
```

The same data frame can be created from the array of columns

```smalltalk
df := DataFrame fromColumns: #(
   ('Barcelona' 'Dubai' 'London')
   (1.609 2.789 8.788)
   (true true false)).
```

Since the names of rows and columns are not provided, they are initialized with their default values: `(1 to: self numberOfRows)` and `(1 to: self numberOfColumns)`. Both `rowNames` and `columnNames` can always be changed by passing an array of new names to a corresponding accessor. This array must be of the same size as the number of rows and columns.

```smalltalk
df columnNames: #(City Population BeenThere).
df rowNames: #(A B C).
```

You can convert this data frame to a pretty-printed table that can be coppied and pasted into letters, blog posts, and tutorials (such as this one) using `df asStringTable` message

```
   |  City       Population  BeenThere  
---+----------------------------------
A  |  Barcelona       1.609       true  
B  |  Dubai           2.789       true  
C  |  London          8.788      false
```

#### 2. Creating DataFrame from a Matrix
By it's nature DataFrame is similar to a matrix. It works like a table of values, supports matrix accessors, such as `at:at:` or `at:at:put:` and in some cases can be treated like a matrix. Some classes provide tabular data in matrix format. For example TabularWorksheet class of [Tabular]() package that is used for reading XLSX files. To initialize a DataFrame from a maxtrix of values, use `fromMatrix:` method

```smalltalk
matrix := Matrix
   rows: 3 columns: 3
   contents:
      #('Barcelona' 1.609 true
        'Dubai' 2.789 true
        'London' 8.788 false).
         
df := DataFrame fromMatrix: matrix.
```

Once again, the names of rows and columns are set to their default values.

#### 3. Reading data from file
In most real-world scenarios the data is located in a file or database. The support for database connections will be added in future releases. Right now DataFrame provides you the methods for loading data from two most commot file formats: CSV and XLSX

```smalltalk
DataFrame fromCSV: 'path/to/your/file.csv'.
DataFrame fromXLSX: 'path/to/your/file.xlsx'.
```

Since JSON does not store data as a table, it is not possible to read such file directly into a DataFrame. However, you can parse JSON using [NeoJSON](https://ci.inria.fr/pharo-contribution/job/EnterprisePharoBook/lastSuccessfulBuild/artifact/book-result/NeoJSON/NeoJSON.html) or any other library, construct an array of rows and pass it to `fromRows:` message, as described in previous sections.

#### 4. Loading the built-in datasets
DataFrame provides several famous datasets for you to play with. They are compact and can be loaded with a simple message. An this point there are three datasets that can be loaded in this way - [Iris flower dataset](https://en.wikipedia.org/wiki/Iris_flower_data_set), a simplified [Boston Housing dataset](https://www.kaggle.com/c/house-prices-advanced-regression-techniques/data), and [Restaurant tipping dataset](https://vincentarelbundock.github.io/Rdatasets/doc/reshape2/tips.html).

```smalltalk
DataFrame loadIris.
DataFrame loadHousing.
DataFrame loadTips.
```

### Accessing rows and columns
Rows and columns of a data frame can be accessed either by their names or their numeric indexes. You can access row _'C'_ and the column _'Population'_ of a data frame created in the previous sections by writing

```smalltalk
df row: 'C'.
df column: 'Population'.
```

Alternatively, you can use numeric indexes. Here is how you can ask a data frame for a third row or a second column:

```smalltalk
df rowAt: 3.
df columnAt: 2.
```

The important feature of a `DataFrame` is that when asked for a specific row or column, it responds with a `DataSeries` object that preserves the same indexing. This way, if you extract row _'B'_ from a data frame, it will still remember that _'Dubai'_ is a city with a population of 2.789 million people

```
            |      B  
------------+-------
      City  |  Dubai  
Population  |  2.789  
 BeenThere  |   true 
```

You can access multiple columns at a same time by providing an array of column names or indexes, or by specifying the numeric range. For this purpose DataFrame provides messages `rows:`, `columns:`, `rowsAt:`, `columnsAt:`, `rowsFrom:to:`, and `columnsFrom:to:`

```smalltalk
df columns: #(City BeenThere).
df rowsAt: #(3 1).
df columnsFrom: 2 to: 3.
df rowsFrom: 3 to: 1.
```

The result will be a data frame with requested rows and columns in a given order. For example, the last line will give you a data frame "flipped upside-down" (with row indexes going in the descending order).

You can change the values of a specific row or column by passing an array or series of the same size to one of the messages: `row:put:`, `column:put:`, `rowAt:put:`, `columnAt:put:`. Be careful though, because these messages modify the data frame and may result in the loss of data.

```smalltalk
df column: #BeenThere put: #(false true false).
```

As it was mentioned above, single cell of a data frame can be accessed with `at:at:` and `at:at:put:` messages

```smalltalk
df at: 3 at: 2.
df at: 3 at: 2 put: true.
```

#### Head & tail
When working with bigger datasets it's often useful to access only the first or the last 5 rows. This can be done using `head` and `tail` messages. To see how they work let's load the Housing dataset.

```smalltalk
df := DataFrame loadHousing.
```

This dataset has 489 entries. Printing all these rows in order to understand how this data looks like is unnecessary. On larger datasets it can also be time consuming. To take a quick look on your data, use `df head` or `df tail`

```
   |     RM  LSTAT  PTRATIO      MDEV  
---+---------------------------------
1  |  6.575   4.98     15.3  504000.0  
2  |  6.421   9.14     17.8  453600.0  
3  |  7.185   4.03     17.8  728700.0  
4  |  6.998   2.94     18.7  701400.0  
5  |  7.147   5.33     18.7  760200.0  
```

The resuld will be another data frame. `head` and `tail` messages are just shortcuts for `df rowsFrom: 1 to: 5` and `df rowsFrom: (df numberOfRows - 5) to: df numberOfRows.`. But what if you want a different number of rows? You can do that using parametrized messages `head:` and `tail:` with a given number of rows.

```smalltalk
df head: 10.
df tail: 3.
```

You can also look at the head or tail of a specific column, since all these messages are also supported by DataSeries

```smalltalk
(df column: #LSTAT) head: 2.
```

The result will be another series

```
   |  LSTAT  
---+-------
1  |   4.98  
2  |   9.14
```

### Adding new rows and columns to DataFrame
New rows and columns can be appended to the data frame using messages `addRow:named` and `addColumn:named`. Like in the case of DataSeries, you must provide a name for these new elements, since it can not continue the existing sequence of names.

```smalltalk
df addRow: #('Lviv' 0.724 true) named: #D.
df addColumn: #(4 3 4) named: #Rating.
```

The same can be done using messages `row:put:` and `column:put:` with non-existing keys. DataFrame will append the new key and associate it with a given row or column

```smalltalk
df at: #D put: #('Lviv' 0.724 true).
df at: #Rating put: #(4 3 4).
```

### Transposed DataFrame
Sometimes it is useful to transpose a data frame made out of columns and rows into rows and columns. For example, if you want to transpose the data frame created in section [Creating DataFrame from an array of rows or columns](#1-creating-dataframe-from-an-array-of-rows-or-columns), you can simply write `df transposed` and it will return you a new data frame which looks like this

```
            |          A      B       C  
------------+----------------------------
      City  |  Barcelona  Dubai  London  
Population  |      1.609  2.789   8.788  
 BeenThere  |       true   true   false
 ```

### The select:where: queries
[SELECT](https://www.w3schools.com/sql/sql_select.asp) is the most commonly used SQL statement that allows you to subset your data by applying filters to it using [WHERE](https://www.w3schools.com/sql/sql_where.asp) clause. The query language of DataFrame is designed to resemble SQL, so if you have some experience with relational databases, you should "feel like home".

The examples in this section will be using Iris dataset

```smalltalk
df := DataFrame loadIris.
```

There are two things you need to specify in order to subset your data with `select:where:` message:
1. What features (columns) do you want to get
2. What conditions should the observations (rows) satisfy in order to be selected

First argument of the `select:where:` message should be an array of column names. They will not affect the selection of rows, but the resulting data frame will contain only these columns. Second argument should be a block with boolean conditions that will be applied to each row of data frame. Only those rows that make a block return `true` will be selected. In your conditions you will be referencing the features of your observations. For example, in Iris dataset you might want to select those flowers that belong to `#setosa` species and have the width of sepal equal to `3`. To make queries more readable, DataFrame provides a querying language that allows you to specify the columns which you are using in your conditions as arguments of the where-block, and use these arguments in your conditions. So, for example, a block `[ :species | species = #setosa ]` passed to `select:where:` message will be translated to `[ :row | (row atKey: #species) = #setosa ]` and applied to every row of data frame. This means that all the arguments of the block you pass must correspond to the column names of your data frame.

Here is a query that selects `petal_width` and `petal_length` columns, and all the rows that satisfy the condition described in the previous paragraph

```smalltalk
df select: #(petal_width petal_length)
   where: [ :species :sepal_width |
      species = #setosa and: sepal_width = 3 ].
```

If you rather want to select all the columns of a data frame, use the `selectAllWhere:` message. It works in a same way as `SELECT * WHERE` in SQL

```smalltalk
df selectAllWhere: [ :species :sepal_width |
   species = #setosa and: sepal_width = 3 ].
```

This query will return a data frame will all 5 columns of Iris dataset and 6 rows that satisfy the given condition.

```
    |  sepal_length  sepal_width  petal_length  petal_width  species  
----+---------------------------------------------------------------
 2  |           4.9            3           1.4          0.2  setosa   
13  |           4.8            3           1.4          0.1  setosa   
14  |           4.3            3           1.1          0.1  setosa   
26  |             5            3           1.6          0.2  setosa   
39  |           4.4            3           1.3          0.2  setosa   
46  |           4.8            3           1.4          0.3  setosa
```

The previous query will return you only the `petal_width` and `petal_length` columns of this data frame. Try it yourself!

### Aggregation and Grouping
All code in this section will be based on Tipping dataset

```smalltalk
df := DataFrame loadTips.
```

The simplest example of applying a `groupBy:` operator is grouping the values of a series by the values of another one of the same size.

```smalltalk
bill := tips column: #total_bill.
sex := tips column: #sex.

bill groupBy: sex.
```

The result of this query will be an object of DataSeriesGrouped, which splits the bill into two series, mapped to the unique `'Male'` and `'Female'` values of sex series.

Since most of the time the series that are grouped are both columns of a same data frame, there is a handy shortcut

```smalltalk
tips group: #total_bill by: #sex.
```

The result of `groupBy:` operator is rather useless unless combined with 

```smalltalk
df select: #(sepal_length species)
   where: [ :petal_length :petal_width |
      (petal_length < 4.9 and: petal_length > 1.6) and:
      (petal_width < 0.4 or: petal_width > 1.5) ]
   groupBy: #species
   aggregate: #sum.
```

The result of this query will be a data frame with a single column

```
            |  sepal_length  
------------+--------------
    setosa  |          15.9  
versicolor  |          18.2  
 virginica  |          17.1
```
