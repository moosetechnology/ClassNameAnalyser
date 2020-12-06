# ClassNameAnalyser

[![Build Status](https://travis-ci.org/NourDjihan/ClassNameAnalyser.svg?branch=master)](https://travis-ci.org/NourDjihan/ClassNameAnalyser)
[![Build status](https://ci.appveyor.com/api/projects/status/fduj9iv10jpvip6v?svg=true)](https://ci.appveyor.com/project/NourDjihan/classnameanalyser)
[![Coverage Status](https://coveralls.io/repos/github/NourDjihan/ClassNameAnalyser/badge.svg?branch=master)](https://coveralls.io/github/NourDjihan/ClassNameAnalyser?branch=master)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/NourDjihan/ClassNameAnalyser/master/LICENSE)

## Installation

In order to install this project, execute (Do-it, Ctrl+D) the following script in the Playground of your Moose 8 Image

```Smalltalk
Metacello new
  baseline: 'ClassNameAnalyser';
  repository: 'github://NourDjihan/ClassNameAnalyser/src';
  load.
```
## ClassNameAnalyser Description:
The ClassNameAnalyser is a visualisation of the distribution of concepts in a specific Java or Pharo project using the ClassNames Blueprint. The distribution of concepts in the project starts from the simple hypothesis: Most Programmers use english as their programming language so when naming their classes, the standard format of the class name is written as follows: XYConcept (for example a class named: ClassNameAnalyser, the concept is at the end of the word which is 'Analyser').

## How to use the ClassNameAnalyser With Moose
After loading ClassNameAnalyser, load your project/packages into your Moose Panel, scroll to see the ClassNames Blueprint visualisation, the conceptual model, the view model and all the root models (all hierarchies) of your packages. The Moose Panel has the option of loading Java projects, but first one must create the .mse file of the java project so it can be loaded and analysed.

In case you are not familiar with Moose, or do not know how to create .mse file of your java project, I suggest you have a look at the [Moose Book](http://www.themoosebook.org/book/).

## A Visual Example:


