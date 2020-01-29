"
MooseGroup adds on top of an abstract group the ability to change the type of a group when we change the entities inside. This is determined via class names.

For example, a XYZGroup handles a group of XYZ entities. Thus, ""MooseGroup with: XYZ new"" will return a XYZGroup. The type changing behavior also works at runtime. Thus, ""MooseGroup new add: XYZ"" will also return a XYZGroup.

The goal of this abstraction is to provide a home for behavior that is specific to groups of entities. For example, a visualization that makes sense for a group of XYZ entities will become a method in the XYZGroup class.
"
Class {
	#name : #MooseGroup,
	#superclass : #MooseAbstractGroup,
	#category : #DMModels
}

{ #category : #'*DMModels' }
MooseGroup >> conceptualPackageModels [

	^ (DMPackageModelGroup new addAll: (self packagemodels))
]

{ #category : #'*DMModels' }
MooseGroup >> packagemodels [
	^self collect: [ :each | each packagemodel ]
]
