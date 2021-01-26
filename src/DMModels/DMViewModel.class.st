Class {
	#name : #DMViewModel,
	#superclass : #DMConceptualModel,
	#instVars : [
		'packageViewModels',
		'intruders'
	],
	#category : #DMModels
}

{ #category : #'as yet unclassified' }
DMViewModel >> countIntruders [ 
	 intruders:= (DMBuilder countIntrudersIn: self)
]

{ #category : #initialization }
DMViewModel >> initialize [
	super initialize.
	intruders := 0
]

{ #category : #accessing }
DMViewModel >> intruders [
	^intruders
]

{ #category : #'as yet unclassified' }
DMViewModel >> modelsOrderedAscending [
	^packageViewModels sorted: #size ascending
]

{ #category : #'as yet unclassified' }
DMViewModel >> modelsOrderedDescending [
	^ packageViewModels sorted: #size descending
]

{ #category : #accessing }
DMViewModel >> packageViewModels [
	^ packageViewModels 
]

{ #category : #accessing }
DMViewModel >> packageViewModels: collectionOfPackageViewModels [
 
	packageViewModels := collectionOfPackageViewModels 
]
