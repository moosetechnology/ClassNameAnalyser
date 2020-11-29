Class {
	#name : #DMConceptualModel,
	#superclass : #DMModel,
	#instVars : [
		'packagemodels',
		'hierarchies'
	],
	#category : #DMModels
}

{ #category : #accessing }
DMConceptualModel >> hierarchies [ 	
	^hierarchies
]

{ #category : #accessing }
DMConceptualModel >> hierarchies: Hierarchies [

	hierarchies := Hierarchies asSet
]

{ #category : #initialization }
DMConceptualModel >> initialize [ 

	super initialize.
	hierarchies := Set new.
]

{ #category : #accessing }
DMConceptualModel >> packagemodels [
	^packagemodels
]

{ #category : #accessing }
DMConceptualModel >> packagemodels: aCollectionOfPackageModels [

	packagemodels := aCollectionOfPackageModels.
	self hierarchies: (DMHierarchy elements copy).
]
