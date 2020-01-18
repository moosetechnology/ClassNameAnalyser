Class {
	#name : #DMConceptualModel,
	#superclass : #DMModel,
	#instVars : [
		'name',
		'packagemodels',
		'hierarchies'
	],
	#category : #DMConceptualModel
}

{ #category : #'instance creation' }
DMConceptualModel >> from: aModel [
	^ aModel buildConceptualModel.
]

{ #category : #accessing }
DMConceptualModel >> hierarchies [ 	
	^hierarchies
]

{ #category : #accessing }
DMConceptualModel >> hierarchies: Hierarchies [

	hierarchies := Hierarchies
]

{ #category : #accessing }
DMConceptualModel >> name [
	^name
]

{ #category : #accessing }
DMConceptualModel >> name: aName [
	name := aName
]

{ #category : #'as yet unclassified' }
DMConceptualModel >> name: aName with: conceptualpackagemodels [

	self name: aName.
	self packagemodels: conceptualpackagemodels.
	self hierarchies: (DMHierarchy elements copy) asSet.
	DMHierarchy elements removeAll
]

{ #category : #accessing }
DMConceptualModel >> packagemodels [
	^packagemodels
]

{ #category : #accessing }
DMConceptualModel >> packagemodels: aCollectionOfPackageModels [
	packagemodels := aCollectionOfPackageModels 
]
