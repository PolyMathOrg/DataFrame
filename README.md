# DataFrame in Pharo
GSoC 2017 project of Oleksandr Zaytsev (Oleks)

The following script installs DataFrame and its dependencies in Pharo 6:
```smalltalk
Metacello new
  baseline: 'DataFrame';
  repository: 'github://PolyMathOrg/DataFrame';
  load.
```
