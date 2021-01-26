Class {
	#name : #DMCNBDescriptionModel,
	#superclass : #DMViewModel,
	#instVars : [
		'nbrClasses',
		'nbrMonoSuffix',
		'nbrMonoClasses',
		'nbrMultiSuffix',
		'nbrIntruders',
		'nbrRoots',
		'nbrSuffixes'
	],
	#category : #DMModels
}

{ #category : #'as yet unclassified' }
DMCNBDescriptionModel >> countConcepts [
	nbrSuffixes := (self allClassModels collect: #concept ) asSet size
]

{ #category : #'as yet unclassified' }
DMCNBDescriptionModel >> countIntruders [ 
	 nbrIntruders:= (DMBuilder countIntrudersIn: self)
]

{ #category : #'as yet unclassified' }
DMCNBDescriptionModel >> countMonoClasses [

	nbrMonoClasses := (self rootModels select: [ :each | each isMonoClass ]) size
]

{ #category : #'as yet unclassified' }
DMCNBDescriptionModel >> countMonoSuffixHierarchies [
	nbrMonoSuffix := (self rootModels select: [ :each | each isMonoSuffix ] ) size
]

{ #category : #'as yet unclassified' }
DMCNBDescriptionModel >> countNumberOfClasses [
	nbrClasses := self allClassModels size
]

{ #category : #'as yet unclassified' }
DMCNBDescriptionModel >> countRootModels [
	nbrRoots := self rootModels size
]

{ #category : #'as yet unclassified' }
DMCNBDescriptionModel >> countnMultiSuffixHierarchies [
	nbrMultiSuffix := (self rootModels select: [ :each | each isMultiSuffix ] ) size
]

{ #category : #operations }
DMCNBDescriptionModel >> create [
	self countIntruders.
	self countNumberOfClasses.
	self countMonoClasses.
	self countMonoSuffixHierarchies.
	self countRootModels.
	self countnMultiSuffixHierarchies.
	self countConcepts.
	
]

{ #category : #accessing }
DMCNBDescriptionModel >> nbrClasses [ 
	^nbrClasses 
]

{ #category : #accessing }
DMCNBDescriptionModel >> nbrClasses: aNumber [
	nbrClasses := aNumber 
]

{ #category : #accessing }
DMCNBDescriptionModel >> nbrIntruders [
	^nbrIntruders
]

{ #category : #accessing }
DMCNBDescriptionModel >> nbrMonoClasses [
	^nbrMonoClasses
]

{ #category : #accessing }
DMCNBDescriptionModel >> nbrMonoClasses: aNumber [
	nbrMonoClasses:= aNumber
]

{ #category : #accessing }
DMCNBDescriptionModel >> nbrMonoSuffix [
	^nbrMonoSuffix
]

{ #category : #accessing }
DMCNBDescriptionModel >> nbrMonoSuffix: aNumber [
	nbrMonoSuffix := aNumber
]

{ #category : #accessing }
DMCNBDescriptionModel >> nbrMultiSuffix [
	^nbrMultiSuffix
]

{ #category : #accessing }
DMCNBDescriptionModel >> nbrMultiSuffix: aNumber [
	nbrMultiSuffix := aNumber
]

{ #category : #accessing }
DMCNBDescriptionModel >> nbrRoots [
	^nbrRoots
]

{ #category : #accessing }
DMCNBDescriptionModel >> nbrRoots: aNumber [ 
	nbrRoots := aNumber
]

{ #category : #accessing }
DMCNBDescriptionModel >> nbrSuffixes [
	^nbrSuffixes
]

{ #category : #accessing }
DMCNBDescriptionModel >> nbrSuffixes: aNumber [
	nbrSuffixes := aNumber
]
