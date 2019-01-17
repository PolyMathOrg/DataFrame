# Pharo DataFrame
[![Project Status: Active – The project has reached a stable, usable state and is being actively developed.](http://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/#active)
[![Build Status](https://travis-ci.org/PolyMathOrg/DataFrame.svg?branch=master)](https://travis-ci.org/PolyMathOrg/DataFrame)
[![Build status](https://ci.appveyor.com/api/projects/status/1wdnjvmlxfbml8qo?svg=true)](https://ci.appveyor.com/project/olekscode/dataframe)
[![Coverage Status](https://coveralls.io/repos/github/PolyMathOrg/DataFrame/badge.svg?branch=master)](https://coveralls.io/github/PolyMathOrg/DataFrame?branch=master)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/PolyMathOrg/DataFrame/master/LICENSE)

DataFrame is a tabular data structure for data analysis, similar to [pandas](https://pandas.pydata.org/) in Python or [data.frame](https://www.rdocumentation.org/packages/base/versions/3.5.2/topics/data.frame) in R. It is a spreadsheet-like data structure with an API specifically designed for data exploration and analysis.

## Installation
The following script installs DataFrame into the Pharo image

```smalltalk
Metacello new
  baseline: 'DataFrame';
  repository: 'github://PolyMathOrg/DataFrame/src';
  load.
```
