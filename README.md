# data-viz
This repo will eventually be a ressource for good data-viz techniques and tips in R.

## Currently planned :
- data viz principles (how to choose the type of graph, axis labelled, proportionnality of ink, one plot per idea, etc ...)
- ggplot2 basic explanations
- Colors (colorblind, emotions associated to colors)
- Classic pitfalls (p-value and error bars in multiple testing)
- Dimensionality reduction for data viz (Link to the general DimRed repo ?)

## Planned structure of the repo :
- scripts/ contain the scripts used to plot everything
- plots/ contain the differents plots that will eventually be used in that README (or on the website ?) as examples
- data/ might eventually contains a dataset for which we do a bit of example, otehrwise we will just use the iris dataset.


## Introduction
Visually representing data is necessary to summarise the data in a way a human brain can understand. However there are multiples way to do it, and a lot of ways to do it horribly wrong. In this article (TODO ?) we will go over some important principles in data visualisation, some good practices and the pitfalls to avoid in order to make the best graphs possible.

## More important dataviz principle
As examples, we will use the classic "iris" dataset, which is present in the R "datasets" library

# Know what you are trying to communicate.
The first question you have to ask when you are winding up to make a graph, is what you are trying to communicate with said graphs. If we want to compare the length of petals between species, the two following graphs do contain the desired information. But which one of those is the best ?

![Plot : Pental Length comparison by species](plots/intro.png?raw=true "Comparison of petal Length by Species")

It is best, when possible to use only one plot per idea. Plots that can carry multiple ideas exists, but they are best used when summarising results that have already been presented or when exploring the dataset.


# Choose your type of graph accordingly
Why use a scatterplot, violinplot, boxplot, heatmap etc ...

# Take care of your axis
Clear labels, make clear if the axis does not start at zero

## Proportionality of ink

##
