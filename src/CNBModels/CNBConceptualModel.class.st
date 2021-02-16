"
I hold all models of the ClassNamesBlueprint.
"
Class {
	#name : #CNBConceptualModel,
	#superclass : #CNBAbstractModel,
	#instVars : [
		'model',
		'packageModels',
		'rootModels'
	],
	#category : #CNBModels
}

{ #category : #accessing }
CNBConceptualModel >> allClassModels [ 
	 ^DMBuilder extractClassModelsFrom: self packageModels.
	
]

{ #category : #initialization }
CNBConceptualModel >> initialize [ 
	super initialize.
	rootModels := Set new.
]

{ #category : #accessing }
CNBConceptualModel >> model [ 
	^model
]

{ #category : #accessing }
CNBConceptualModel >> model: aModel [
	model := aModel
]

{ #category : #accessing }
CNBConceptualModel >> packageModels [
	^packageModels
]

{ #category : #accessing }
CNBConceptualModel >> packageModels: aCollectionOfPackageModels [
	packageModels := aCollectionOfPackageModels.
]

{ #category : #accessing }
CNBConceptualModel >> rootModels [
	^rootModels
]

{ #category : #accessing }
CNBConceptualModel >> rootModels: aCollectionOfRootmodels [
	rootModels := aCollectionOfRootmodels 
]
