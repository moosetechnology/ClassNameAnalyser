Class {
	#name : #DMConceptualModel,
	#superclass : #DMModel,
	#instVars : [
		'packageModels',
		'mooseModel',
		'rootModels',
		'motherRoot'
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

{ #category : #'as yet unclassified' }
DMConceptualModel >> buildRootModels [ 
	self rootModels: (DMBuilder buildRootsOf: mooseModel accordingto: motherRoot)  
]

{ #category : #initialization }
DMConceptualModel >> initializeBuild [
	^DMBuilder build: self 
	
]

{ #category : #initialization }
DMConceptualModel >> initializePackageModels [
	| packages |
	packages := (mooseModel allModelNamespaces ifEmpty: mooseModel allModelPackages)
		asMooseGroup.
	self packageModels: (DMBuilder doPackageModelsUsing: packages)
]

{ #category : #initialization }
DMConceptualModel >> initializeRootModels [
	^DMBuilder initializeRootModelsUsing: self
]

{ #category : #accessing }
DMConceptualModel >> mooseModel [ 
	^mooseModel 
]

{ #category : #accessing }
DMConceptualModel >> mooseModel: aModel [
	mooseModel := aModel.
	self initializeBuild.
]

{ #category : #accessing }
DMConceptualModel >> motherRoot [
	^motherRoot
]

{ #category : #accessing }
DMConceptualModel >> motherRoot: aClass [ 
	motherRoot := aClass
]

{ #category : #'as yet unclassified' }
DMConceptualModel >> packageModels [
	^packageModels
]

{ #category : #accessing }
DMConceptualModel >> packageModels: aCollectionOfPackageModels [

	packageModels := aCollectionOfPackageModels.
]

{ #category : #accessing }
DMConceptualModel >> rootModels [
	^rootModels 
]

{ #category : #accessing }
DMConceptualModel >> rootModels: aCollectionOfRootModels [
	rootModels := aCollectionOfRootModels
]
