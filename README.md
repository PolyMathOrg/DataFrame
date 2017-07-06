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

# Usage
Let's start by creating a data frame from a collection of rows
```smalltalk
df := DataFrame rows:
  #(('Barcelona' 1.609 true)
   ('Dubai' 2.789 true)
   ('London' 8.788 false)).
```
We can do the same by passing an array of columns
```smalltalk
df := DataFrame rows:
  #(('Barcelona' 'Dubai' 'London')
   (1.609 2.789 8.788)
   (true true false)).
```
In both cases the created data frame will look like this
```
      1            2      3
1    ('Barcelona'  1.609  true)
2    ('Dubai'      2.789  true)
3    ('London'     8.788  false))
```
