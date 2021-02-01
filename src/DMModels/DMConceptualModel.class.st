"
I'm a composite model containing all the other models (classModel, package)
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
	#category : #DMModels
}

{ #category : #accessing }
DMConceptualModel >> allClassModels [ 
	^packageModels flatCollect: [:each | each classModels]
	
]

{ #category : #initialization }
DMConceptualModel >> initialize [ 
	super initialize.
	rootModels := Set new.
	motherRoot := Object
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
