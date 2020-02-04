Class {
	#name : #DMConceptualModel,
	#superclass : #DMModel,
	#instVars : [
		'name',
		'packagemodels',
		'hierarchies'
	],
	#category : #DMModels
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
	packagemodels := aCollectionOfPackageModels 
]
