Class {
	#name : #DMConceptualModel,
	#superclass : #DMModel,
	#instVars : [
		'models',
		'hierarchies',
		'concepts'
	],
	#category : #DMModels
}

{ #category : #accessing }
DMConceptualModel >> concepts [
	^concepts
]

{ #category : #accessing }
DMConceptualModel >> hierarchies [ 	
	^hierarchies
]

{ #category : #accessing }
DMConceptualModel >> hierarchies: hierarchiesCollection [

	hierarchies := hierarchiesCollection asSet
]

{ #category : #initialization }
DMConceptualModel >> initialize [ 

	super initialize.
	hierarchies := Set new.
	concepts := Set new.
]

{ #category : #'as yet unclassified' }
DMConceptualModel >> models [
	^models
]

{ #category : #accessing }
DMConceptualModel >> packagemodels: aCollectionOfPackageModels [

	models := aCollectionOfPackageModels.
	concepts := (aCollectionOfPackageModels flatCollect: [ :eachPackageModel | 
		DMBuilder new extractConceptsFrom: eachPackageModel ]) asSet.
	hierarchies := (aCollectionOfPackageModels flatCollect: [ :eachPackageM | 
		DMBuilder new extractHierarchiesFrom: eachPackageM ] ) asSet.
]
