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

	 ^ CNBBuilder extractClassModelsFrom: self packageModels.
	
]

{ #category : #accessing }
CNBConceptualModel >> model [ 

	^ model
]

{ #category : #accessing }
CNBConceptualModel >> model: aModel [

	model := aModel
]

{ #category : #accessing }
CNBConceptualModel >> packageModels [

	^ packageModels
]

{ #category : #accessing }
CNBConceptualModel >> packageModels: packages [

	packageModels := packages.
]

{ #category : #accessing }
CNBConceptualModel >> rootModels [

	^ rootModels
]

{ #category : #accessing }
CNBConceptualModel >> rootModels: roots [

	rootModels := roots 
]
