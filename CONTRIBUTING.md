# How to contribute to DataFrame?
DataFrame is an [open source](https://en.wikipedia.org/wiki/Open-source_software) project developed in a collaborative public manner.
We need your help to make it better.
Every contribution counts - should it be a fixed typo in documentation or the implementation of a faster algorithm.
> There is no such thing as small contribution

1. [What can you do?](#what-can-you-do)
2. [Setting up the environment](#setting-up-the-environment)
    1. [Download a fresh Pharo 6.1 image](#download-a-fresh-pharo-61-image)
    2. [Update Iceberg](#update-iceberg)
    3. [Connect to GitHub with SSH](#connect-to-github-with-ssh)
    4. [Settings](#settings)
    5. [Load DataFrame](#load-dataframe)
3. [Making changes to DataFrame](#making-changes-to-dataframe)

## What can you do?
The best way to find out how you can help make DataFrame better is to look at the [list of open issues](https://github.com/PolyMathOrg/DataFrame/issues). 

## Setting up the environment
In order to make your conributions you need to set up the environment that will allow you to have a local version of DataFrame repository and push your changes directly from your Pharo image.

### Download a fresh Pharo 6.1 image
It is recommended to make your contributions using the fresh Pharo 6.1 image.
You can download it from the [official website](https://pharo.org/download).
Just follow the instructions for your OS.

### Update Iceberg
[Iceberg](https://github.com/pharo-vcs/iceberg) Iceberg is a set of tools that allow one to handle git repositories directly from a Pharo image.
Since Pharo 6.0, iceberg is included in the image, so you don't need to install it.
However, there are some bugs that will produce an LGit error if you try to enable Metacello integration
(we will be doing it in the next steps).
According to the [instructions](https://github.com/pharo-vcs/iceberg#update-iceberg), you should update Iceberg on your new Pharo 6 image by executing this script in your Playground

```Smalltalk
MetacelloPharoPlatform select.
#(
  'BaselineOfTonel'
  'BaselineOfLibGit'
  'BaselineOfIceberg'
  'Iceberg-UI' 
  'Iceberg-Plugin-GitHub' 
  'Iceberg-Plugin' 
  'Iceberg-Metacello-Integration' 
  'Iceberg-Libgit-Tonel' 
  'Iceberg-Libgit-Filetree' 
  'Iceberg-Libgit' 
  'Iceberg' 
  'LibGit-Core'
  'MonticelloTonel-Tests'
  'MonticelloTonel-Core'
  'MonticelloTonel-FileSystem' ) 
do: [ :each | (each asPackageIfAbsent: [ nil ]) ifNotNil: #removeFromSystem ].
Metacello new
   baseline: 'Iceberg';
   repository: 'github://pharo-vcs/iceberg:v0.6.5';
   load.
```

Now Iceberg should be working correctly and you should get no errors while loading DataFrame.

### Connect to GitHub with SSH
Iceberg has a bug that makes it hard to work with HTTPS connections.
If you don't have SSH keys for connecting to GitHub follow [these instructions](https://help.github.com/articles/connecting-to-github-with-ssh/) to set them up.
Otherwise you can just continue to the next section.

### Settings
Make sure that "Enable Metacello Integration" is checked. Now you should also check "Use custom SSH keys".

### Load DataFrame
Execute the following Metacello script in your Pharo playground. It will load all packages of DataFrame, including DataFrame-Core, DataFrame-Tools, and all the tests.

```Smalltalk
Metacello new
   baseline: 'DataFrame';
   repository: 'github://PolyMathOrg/DataFrame';
   load.
```
## Making changes to DataFrame
DataFrame consists of 4 packages:
* DataFrame-Core
* DataFrame-Core-Tests
* DataFrame-Tools
* DataFrame-Tools-Tests

Assuming that you loaded DataFrame using the script from the previous section, you should have the exact same packages in your image.
