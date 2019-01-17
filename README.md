# Pharo DataFrame
[![Project Status: Active – The project has reached a stable, usable state and is being actively developed.](http://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/#active)
[![Build Status](https://travis-ci.org/PolyMathOrg/DataFrame.svg?branch=master)](https://travis-ci.org/PolyMathOrg/DataFrame)
[![Build status](https://ci.appveyor.com/api/projects/status/1wdnjvmlxfbml8qo?svg=true)](https://ci.appveyor.com/project/olekscode/dataframe)
[![Coverage Status](https://coveralls.io/repos/github/PolyMathOrg/DataFrame/badge.svg?branch=master)](https://coveralls.io/github/PolyMathOrg/DataFrame?branch=master)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/PolyMathOrg/DataFrame/master/LICENSE)

DataFrame is a tabular data structure for data analysis, similar to [pandas](https://pandas.pydata.org/) in Python or [data.frame](https://www.rdocumentation.org/packages/base/versions/3.5.2/topics/data.frame) in R. It is a spreadsheet-like data structure with an API specifically designed for data exploration and analysis.

DataFrame library consists of two primary data structures:
* `DataFrame` is a spreadsheet-like tabular data structure that works like a relational database by providing the API for querying the data. Each row represents an observation, and every column is a feature. Both rows and columns of a data frame have names (keys) by which they can be accessed.
* `DataSeries` is an array-like data structure used for working with specific rows or columns of a data frame. It has a name and contains an array of data mapped to a corresponding array of keys. DataSeries is a SequenceableCollection that combines the properties of an Array and a Dictionary, while extending the functionality of both by providing advanced messages for working with data, such as statistical summaries, visualizations etc.

## Installation
The following script installs DataFrame into the Pharo image

```smalltalk
Metacello new
  baseline: 'DataFrame';
  repository: 'github://PolyMathOrg/DataFrame/src';
  load.
```
