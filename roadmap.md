# DataFrame Roadmap

## DataFrame-Core
This package should implement the basic functionality of DataFrame as a collection. It should provide all the basic functionality of data frames in that you can find usually in tools like Pandas and R. Some of this functionality is still missing, for example:
* Handling missing values
* Time series

We should find time to go over the documentation of pandas and R and create the complete list of everything we don't have.

Another issue with the Core package is querrying. We have implemented a good interface for queries like SELECT or GROUP BY, but this functionality is incomplete. DataFrame should support all the basic queries we have in SQL. To find out what functionality is missing, we should try reproducing some famous examples from SQL tutorials using DataFrame.

It would be perfect if we had something like LINQ.

## DataFrame-Tools
Pretty much all the tools in this package need to be improved, fixed, or redesigned.

__GTInspector__
Right now it shows you a FastTable some basic visualisations. But here is the problem - if you have a DataFrame of textual data, Inspector will try to show you a boxplot in one of its views. I think that DataFrame should automatically detect the kind of data that is stored in it (and not just the classes of values, but also have some "intuition" about the purpose of this data - is it discrete, or does it represent continuous values, like time series? is it a matrix of numbers, for example, a MNIST image, or a list of students with names, grades etc.). When DataFrame has this information about the data, it should change its behaviour accordingly. For example, Inspector must show you statistical data with visualizations (the right visualization could also be detected automatically), textual data in some readable (and searchable / editable) form , images as images etc.

__Visualizations__
I think we need a tool for data visualizations just as powerful as matplotlib. It should be built on top of Roassal, but be specifically designed for visualizing data. The basic idea is this: if you want a boxplot, you say "Hello, DataFrame, show me a boxplot of your second column", you shouldn't write some long script defining axes, boxes and other things. I have implemented some basic visualizations, but some of them don't work as expected (for example, histogram is not a histogram at all). And this functionality is nowhere near matplotlib or ggplot.

__FastTable__
What we have right now is more like a demo than an actual tool. It's broken in so many places, for example, last column is not visible, row names are replaced with numbers, big tables turn into big mess etc. Besides, a lot of important functionality should be introduced. Columns should be resizable and sortable. I think we need to create a separate tool which will have all the functionality of Excel tables and allow you to edit the data through it.
