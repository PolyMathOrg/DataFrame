# Pharo DataFrame
[![Build Status](https://travis-ci.org/PolyMathOrg/DataFrame.svg?branch=master)](https://travis-ci.org/PolyMathOrg/DataFrame)
[![Build status](https://ci.appveyor.com/api/projects/status/1wdnjvmlxfbml8qo?svg=true)](https://ci.appveyor.com/project/olekscode/dataframe)
[![Coverage Status](https://coveralls.io/repos/github/PolyMathOrg/DataFrame/badge.svg?branch=master)](https://coveralls.io/github/PolyMathOrg/DataFrame?branch=master)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/PolyMathOrg/DataFrame/master/LICENSE)
[![Pharo version](https://img.shields.io/badge/Pharo-6.1-%23aac9ff.svg)](https://pharo.org/download)
[![Pharo version](https://img.shields.io/badge/Pharo-7.0-%23aac9ff.svg)](https://pharo.org/download)
[![Pharo version](https://img.shields.io/badge/Pharo-8.0-%23aac9ff.svg)](https://pharo.org/download)

DataFrame is a tabular data structure for data analysis in [Pharo](https://pharo.org/), similar to [pandas](https://pandas.pydata.org/) in Python or [data.frame](https://www.rdocumentation.org/packages/base/versions/3.5.2/topics/data.frame) in R. It is a spreadsheet-like collection with an API specifically designed for data exploration and analysis.

[![Screenshot](img/example.png)](https://raw.githubusercontent.com/PolyMathOrg/DataFrame/master/img/example.png)

## Installation
The following script installs DataFrame into the Pharo image

```smalltalk
Metacello new
  baseline: 'DataFrame';
  repository: 'github://PolyMathOrg/DataFrame/src';
  load.
```

## Example

This is a small example that will demonstrate how DataFrame can be used for collecting and preprocessing the dataset of methods. For more detailed information read the [DataFrame booklet](https://github.com/SquareBracketAssociates/Booklet-DataFrame).

### Collecting all methods from the image

First we collect an array of all methods in the image - instances of CompiledMethod class that belong to some package:
```Smalltalk
methods := CompiledMethod allInstances select: [ :method |
	method package isNotNil ].
```
From each method we extract its name, source code, package name, and class name. We remove first line of source code of each method to remove method's name from it:
```Smalltalk
rows := methods collect: [ :method |
  {
    method package name .
    method methodClass name .
    method selector .
    method sourceCode copyAfter: Character cr
  } ].
```
### Creating a DataFrame
We create a DataFrame and specify the names of its columns:
```Smalltalk
methodsData := (DataFrame fromRows: rows)
  columnNames: #(packageName className methodName sourceCode);
  yourself.
```
### Adding a column
We add a new column with number of arguments for each method. To do that we count the number of occurences of `:` symbol in method's name:
```Smalltalk
methodsData atColumn: #numberOfArgs put: 
  ((methodsData column: #methodName) collect: [ :name |
    name occurrencesOf: $: ]).
```
### Filtering data
Now we select only those methods that belong to package [Renraku](https://github.com/Uko/Renraku), have at least one argument, and source code with less than 5 tokens:
```Smalltalk
renrakuMethods := methodsData select: [ :row |
  ((row atKey: #packageName) = 'Renraku' and: 
  (row atKey: #numberOfArgs) > 0) and:
  ((row atKey: #sourceCode) findTokens: ' ') size < 5 ].
```
### Sorting rows by values of a column
First we sort methods by their names and then we sort the result by number of arguments in descending order:
```Smalltalk
renrakuMethods
  orderBy: #methodName;
  orderDescendingBy: #numberOfArgs.
```
### Selecting specific columns
We selecting only 4 columns (without className) and specify their order. If you inspect the result of this query, you will see the table similar to the one in a screenshot above.
```Smalltalk
renrakuMethods columns: #(packageName numberOfArgs methodName sourceCode).
```
