# Pharo DataFrame
[![Build status](https://github.com/PolyMathOrg/DataFrame/workflows/CI/badge.svg)](https://github.com/PolyMathOrg/DataFrame/actions/workflows/test.yml)
[![Coverage Status](https://coveralls.io/repos/github/PolyMathOrg/DataFrame/badge.svg?branch=master)](https://coveralls.io/github/PolyMathOrg/DataFrame?branch=master)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/PolyMathOrg/DataFrame/master/LICENSE)

DataFrame is a tabular data structure for data analysis in [Pharo](https://pharo.org/). It organizes and represents data in a tabular format, resembling a spreadsheet or database table. It is designed to handle structured data and offer various functionalities for data manipulation and analysis. DataFrames are used as visualization tools for Machine Learning and Data Science related tasks.

<img width="700" src="img/weatherDfDataInspector.png">

## Installation
To install the latest stable version of DataFrame (`pre-v3`), go to the Playground (`Ctrl+OW`) in your Pharo image and execute the following Metacello script (select it and press Do-it button or `Ctrl+D`):

```st
EpMonitor disableDuring: [
    Metacello new
      baseline: 'DataFrame';
      repository: 'github://PolyMathOrg/DataFrame:pre-v3/src';
      load ].
```

Use this script if you want the latest version of DataFrame:

```st
EpMonitor disableDuring: [
    Metacello new
      baseline: 'DataFrame';
      repository: 'github://PolyMathOrg/DataFrame/src';
      load ].
```

If you'd be interested in (basic, read-only for now) SQLite support, use `load: 'sqlite'` at the end:

```st
EpMonitor disableDuring: [
    Metacello new
      baseline: 'DataFrame';
      repository: 'github://PolyMathOrg/DataFrame/src';
      load: 'sqlite' ].
```

_Note:_ `EpMonitor` serves to deactive [Epicea](https://github.com/pharo-open-documentation/pharo-wiki/blob/3cfb4ebc19821d607bec35c34ee928b4e06822ee/General/TweakingBigImages.md#disable-epicea), a Pharo code recovering mechanism, during the installation of DataFrame.

## How to depend on it?

If you want to add a dependency on `DataFrame` to your project, include the following lines into your baseline method:

```Smalltalk
spec
  baseline: 'DataFrame'
  with: [ spec repository: 'github://PolyMathOrg/DataFrame/src' ].
```

If you are new to baselines and Metacello, check out the [Baselines](https://github.com/pharo-open-documentation/pharo-wiki/blob/master/General/Baselines.md) tutorial on Pharo Wiki.

## What are data frames?

Data frames are the one of the essential parts of the data science toolkit. They are the specialized data structures for tabular data sets that provide us with a simple and powerful API for summarizing, cleaning, and manipulating a wealth of data sources that are currently cumbersome to use.

A data frame is like a database inside a variable. It is an object which can be created, modified, copied, serialized, debugged, inspected, and garbage collected. It allows you to communicate with your data quickly and effortlessly, using just a few lines of code. DataFrame project is similar to [pandas](https://pandas.pydata.org/) library in Python or built-in [data.frame](https://www.rdocumentation.org/packages/base/versions/3.5.3/topics/data.frame) class in R.

## Very simple example

In this section I show a very simple example of creating and manipulating a little data frame. For more advanced examples, please check the [DataFrame Booklet](#dataframe-booklet).

### Creating a data frame

```Smalltalk
weather := DataFrame withRows: #(
  (2.4 true rain)
  (0.5 true rain)
  (-1.2 true snow)
  (-2.3 false -)
  (3.2 true rain)).
```
|       | 1    | 2     | 3    |
|-------|------|-------|------|
| **1** | 2.4  | true  | rain |
| **2** | 0.5  | true  | rain |
| **3** | -1.2 | true  | snow |
| **4** | -2.3 | false | -    |
| **5** | 3.2  | true  | rain |


### Removing the third row of the data frame

```Smalltalk
weather removeRowAt: 3.
```
|       | 1    | 2     | 3    |
|-------|------|-------|------|
| **1** | 2.4  | true  | rain |
| **2** | 0.5  | true  | rain |
| **4** | -2.3 | false | -    |
| **5** | 3.2  | true  | rain |

### Adding a row to the data frame

```Smalltalk
weather addRow: #(-1.2 true snow) named: 6.
```
|       | 1    | 2     | 3    |
|-------|------|-------|------|
| **1** | 2.4  | true  | rain |
| **2** | 0.5  | true  | rain |
| **4** | -2.3 | false | -    |
| **5** | 3.2  | true  | rain |
| **6** | -1.2 | true  | snow |

### Replacing the data in the first row and third column with 'snow'

```Smalltalk
weather at:1 at:3 put:#snow.
```
|       | 1    | 2     | 3    |
|-------|------|-------|------|
| **1** | 2.4  | true  | snow |
| **2** | 0.5  | true  | rain |
| **4** | -2.3 | false | -    |
| **5** | 3.2  | true  | rain |
| **6** | -1.2 | true  | snow |

### Transpose of the data frame

```Smalltalk
weather transposed.
```
|       | 1    | 2    | 4     | 5    | 6    |
|-------|------|------|-------|------|------|
| **1** | 2.4  | 0.5  | -2.3  | 3.2  | -1.2 |
| **2** | true | true | false | true | true |
| **3** | snow | rain | -     | rain | snow |

### Load data from SQLite query:
```st
"If you have a connection ready in conn"
df := DataFrame readFromSqliteCursor: (conn execute: 'SELECT * FROM table').
```

## Documentation and Literature

1. [Data Analysis Made Simple with Pharo DataFrame](https://github.com/SquareBracketAssociates/Booklet-DataFrame) - a booklet that serves as the main source of documentation for the DataFrame project. It describes the complete API of DataFrame and DataSeries data structures, and provides examples for each method.

[![DataFrame Booklet](img/booklet.png)](https://github.com/SquareBracketAssociates/Booklet-DataFrame)

2. Zaytsev Oleksandr, Nick Papoulias and Serge Stinckwich. [Towards Exploratory Data Analysis for Pharo](https://dl.acm.org/doi/10.1145/3139903.3139918) In Proceedings of the 12th edition of the International Workshop on Smalltalk Technologies, pp. 1-6. 2017.
