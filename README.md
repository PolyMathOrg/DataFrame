# DataFrame in Pharo
GSoC 2017 project of Oleksandr Zaytsev (Oleks)

# Installation
The following script installs DataFrame and its dependencies in Pharo 6:
```smalltalk
Metacello new
  baseline: 'DataFrame';
  repository: 'github://PolyMathOrg/DataFrame';
  load.
```

# Tutorial
There are two primary data structures in this package:
* `DataSeries` can be seen as an Ordered Collection that combines the properties of an Array and a Dictionary, while extending the functionality of both. Every DataSeries has a name and contains an array of data mapped to a corresponding array of keys (that are used as index values).
* `DataFrame` is a tabular data structure that can be seen as an ordered collection of columns. It works like a spreadsheet or a relational database with one row per subject and one column for each subject identifier, outcome variable, explanatory variable etc. A DataFrame has both row and column indices which can be changed if needed. The important feature of a DataFrame is that whenever we ask for a specific row or column, it responds with a DataSeries object that preserves the same indexing.

## Creating a DataFrame
There are four ways of creating a data frame

### 1. Creating an empty DataFrame
You can create an empty instance of `DataFrame` using the `new` message
```smalltalk
df := DataFrame new.
```
The data can be added later using the `add:` message.
```smalltalk
df add: #('Barcelona' 1.609 true).
```

### 2. Creating a DataFrame from an array of rows
This way is the best for creating simple examples for testing since you can see how the data will be arranged in your data frame.
```smalltalk
df := DataFrame rows: #(
   ('Barcelona' 1.609 true)
   ('Dubai' 2.789 true)
   ('London' 8.788 false)).
```

### 3. Creating a DataFrame from an array of columns
We can do the same by passing an array of columns
```smalltalk
df := DataFrame rows: #(
   ('Barcelona' 'Dubai' 'London')
   (1.609 2.789 8.788)
   (true true false)).
```
In both cases the created data frame will look like this
```
     1            2      3
1    'Barcelona'  1.609  true
2    'Dubai'      2.789  true
3    'London'     8.788  false
```

### 4. Reading the data from file
This is the most common way of creating a data frame. You have some dataset in a file (CSV, Excel etc.) - just ask a `DataFrame` to read it. At this point only CSV files are supported, but very soon you will also be able to read the data from other formats.

```smalltalk
df := DataFrame fromCsv: 'path/to/your/file.csv'.
```
