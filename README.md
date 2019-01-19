# Pharo DataFrame
[![Build Status](https://travis-ci.org/PolyMathOrg/DataFrame.svg?branch=master)](https://travis-ci.org/PolyMathOrg/DataFrame)
[![Build status](https://ci.appveyor.com/api/projects/status/1wdnjvmlxfbml8qo?svg=true)](https://ci.appveyor.com/project/olekscode/dataframe)
[![Coverage Status](https://coveralls.io/repos/github/PolyMathOrg/DataFrame/badge.svg?branch=master)](https://coveralls.io/github/PolyMathOrg/DataFrame?branch=master)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/PolyMathOrg/DataFrame/master/LICENSE)
[![Pharo version](https://img.shields.io/badge/Pharo-6.1-%23aac9ff.svg)](https://pharo.org/download)
[![Pharo version](https://img.shields.io/badge/Pharo-7-%23aac9ff.svg)](https://pharo.org/download)

DataFrame is a tabular data structure for data analysis in [Pharo](https://pharo.org/), similar to [pandas](https://pandas.pydata.org/) in Python or [data.frame](https://www.rdocumentation.org/packages/base/versions/3.5.2/topics/data.frame) in R. It is a spreadsheet-like collection with an API specifically designed for data exploration and analysis.

## Installation
The following script installs DataFrame into the Pharo image

```smalltalk
Metacello new
  baseline: 'DataFrame';
  repository: 'github://PolyMathOrg/DataFrame/src';
  load.
```
