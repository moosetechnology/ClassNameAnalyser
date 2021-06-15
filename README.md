# ClassNameAnalyser
![Build Pass](https://github.com/NourDjihan/ClassNameAnalyser/workflows/CI/badge.svg) 
[![Coverage Status](https://coveralls.io/repos/github/NourDjihan/ClassNameAnalyser/badge.svg?branch=master)](https://coveralls.io/github/NourDjihan/ClassNameAnalyser?branch=master)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/NourDjihan/ClassNameAnalyser/master/LICENSE)

## Installation

In order to install this project, execute (Do-it, Ctrl+D) the following script in the Playground of your Moose 9 Image

```Smalltalk
Metacello new
  baseline: 'ClassNameAnalyser';
  repository: 'github://NourDjihan/ClassNameAnalyser/src';
  load.
```
## ClassNameAnalyser Description:
The **ClassNameAnalyser** is a project which provides a visualisation of the distribution of concepts in both **Java** and **Pharo**. The visualization is called *ClassNames Distribution*

## How to use the ClassNameAnalyser With Moose
After loading the *ClassNameAnalyser*, click on *Library* from the top menu then select *ClassNames Distribution*.
For Pharo projects, you can write the name of the project in the list of packages on the left side, then use the shortcut cmd+A to select all packages starting with the project name.
For Java projects, you may want to create an mse file first using: https://github.com/moosetechnology/VerveineJ. Then load your mse file from the mse icon on the top left of the tool.

Once you project is selected/loaded, click on the visualize button.

## Understanding your Visualisation:
The visualisation uses boxes to wrap up packages, which contain suffixes/prefixes boxes that wrap up class boxes belonging to the package and having the suffix/prefix box name as a suffix of the class name. The visualization is based on:

Class Type | Description | Color
--- | --- | --- |
**Mono Class** | a class which belongs to no hierarchy | white
**Trait Class** | a class containing a set of methods that can be used to extend the functionality of a class | white
**Mono Suffix Hierarchy** | Hierarchies which use the same naming convention (all classes of a tree hierarchy have the same suffix) | Gray
**Multi Suffix Hierarchy** | Hierarchies that do not use the same naming convention | a color is selected from the predefined color palette (24 main colors taken by the first biggest 24 hierarchies in descending order)
**Other hierarchies** (*ignored*) | starting from the 25th biggest hierarchy in the system | Black

Class boxes are colored as their root classes, while concept boxes are colored the same as the biggest root which uses the concept's name.

## A Visual Example:
The figure below depicts a *ClassNames Blueprint* of some packages selected from the Moose Image by clicking on the 'st' option as shown in the above-right of the Moose Panel:

![](Images/PharoPackages.png)


The visualisation below shows a *ClassNames Blueprint* for a [Java project(ArgoUML)](https://github.com/argouml-tigris-org) imported as an .mse file by clicking on the 'mse' option as shown in the above-right of the Moose Panel:
![](Images/JavaProject(ArgoUML).png)

Figure below depicts the group of Root Models of the ArgoUML Java project and an example of a root model named 'JPanel' which represents the root of an hierarchy consisting of 23 subclasses that use different suffixes (concepts), which makes this hierarchy a Multi-Suffix hierarchy, and is colored in pink.
![](Images/RootModels.png)





