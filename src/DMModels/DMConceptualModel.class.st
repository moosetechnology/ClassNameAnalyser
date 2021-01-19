Class {
	#name : #DMConceptualModel,
	#superclass : #DMModel,
	#instVars : [
		'hierarchies',
		'model',
		'packageModels',
		'concepts',
		'motherRoot',
		'rootModels'
	],
	#category : #DMModels
}

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
DMConceptualModel >> initialize [ 
	super initialize.
	rootModels := Set new
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

{ #category : #'as yet unclassified' }
DMConceptualModel >> packageModels [
	^packageModels
]

{ #category : #'as yet unclassified' }
DMConceptualModel >> packageModels: aCollectionOfPackageModels [
	packageModels := aCollectionOfPackageModels 
]

{ #category : #accessing }
DMConceptualModel >> rootModels [
	^rootModels
]

{ #category : #accessing }
DMConceptualModel >> rootModels: aCollectionOfRootmodels [
	rootModels := aCollectionOfRootmodels 
]
