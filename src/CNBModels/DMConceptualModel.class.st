"
I hold all models of the ClassNamesBlueprint.
"
Class {
	#name : #DMConceptualModel,
	#superclass : #DMModel,
	#instVars : [
		'model',
		'packageModels',
		'motherRoot',
		'rootModels'
	],
	#category : #CNBModels
}

{ #category : #'as yet unclassified' }
DMConceptualModel >> allClassModels [ 
	 ^DMBuilder extractClassModelsFrom: self packageModels.
	
]

{ #category : #initialization }
DMConceptualModel >> initialize [ 
	super initialize.
	rootModels := Set new.
]

{ #category : #accessing }
DMConceptualModel >> model [ 
	^model
]

{ #category : #accessing }
DMConceptualModel >> model: aModel [
	model := aModel
]

{ #category : #accessing }
DMConceptualModel >> motherRoot [ 
	^motherRoot 
]

{ #category : #accessing }
DMConceptualModel >> motherRoot: aClass [ 
	motherRoot := aClass
]

{ #category : #accessing }
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
DMConceptualModel >> rootModels: aCollectionOfRootmodels [
	rootModels := aCollectionOfRootmodels 
]
