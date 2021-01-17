Class {
	#name : #DMConceptualModel,
	#superclass : #DMModel,
	#instVars : [
		'hierarchies',
		'models',
		'concepts'
	],
	#category : #DMModels
}

{ #category : #'as yet unclassified' }
DMConceptualModel class >> buildPackageModels [
	^ self new
		initializePackageModels
]

{ #category : #'as yet unclassified' }
DMConceptualModel class >> buildRootModels [ 
	^ self new 
		buildRootModels 
]

{ #category : #accessing }
DMConceptualModel >> allClassModels [ 
	^DMBuilder extractClassModelsFrom: self 
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
DMConceptualModel >> initializeBuild [
	^DMBuilder build: self 
	
]

{ #category : #initialization }
DMConceptualModel >> initializeRootModels [
	^DMBuilder initializeRootModelsUsing: self
]

{ #category : #'as yet unclassified' }
DMConceptualModel >> models [
	^models
]

{ #category : #'as yet unclassified' }
DMConceptualModel >> packagemodels: aCollectionOfPackageModels [

	models := aCollectionOfPackageModels.
	concepts := (aCollectionOfPackageModels flatCollect: [ :eachPackageModel | 
		DMBuilder new extractConceptsFrom: eachPackageModel ]) asSet.
	hierarchies := (aCollectionOfPackageModels flatCollect: [ :eachPackageM | 
		DMBuilder new extractHierarchiesFrom: eachPackageM ] ) asSet.
]
