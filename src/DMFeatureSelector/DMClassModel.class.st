Class {
	#name : #DMClassModel,
	#superclass : #Object,
	#instVars : [
		'class',
		'className',
		'concept',
		'rootClass',
		'packageName'
	],
	#category : #DMFeatureSelector
}

{ #category : #'class membership' }
DMClassModel >> class [
	^ class
]

{ #category : #accessing }
DMClassModel >> class: aClass [
	class := aClass
]

{ #category : #introspection }
DMClassModel >> className [ 
	^ className 
]

{ #category : #accessing }
DMClassModel >> className: aClassName [
	className := aClassName 
]

{ #category : #accessing }
DMClassModel >> concept [
	^ concept 
]

{ #category : #accessing }
DMClassModel >> concept: aConcept [
	concept := aConcept
]

{ #category : #'as yet unclassified' }
DMClassModel >> createFrom: aClass with: aFeatureSelector [
	"The root class should also be extracted here"
	
	self class:	aClass.
	self className: (aClass instanceSide name) asString.
	self concept: (self extractConceptFrom: className with: aFeatureSelector).
	^ self
	
]

{ #category : #'as yet unclassified' }
DMClassModel >> extractConceptFrom: aClassName with: aFeatureSelector [

	| aConcept featureSelector |
	featureSelector := aFeatureSelector.
	aConcept := featureSelector extractConceptFrom: aClassName.
	^ aConcept 
]

{ #category : #'as yet unclassified' }
DMClassModel >> extractRootClassFrom: aClass [

	(aClass == Object)
		ifTrue: [ ^ aClass  ] 
		ifFalse: [ (aClass superclass == Object)
							ifTrue: [ ^ aClass  ]
							ifFalse: [  ^ self extractRootClassFrom: (aClass superclass)  ]		]
]

{ #category : #accessing }
DMClassModel >> packageName [
	^ packageName
]

{ #category : #accessing }
DMClassModel >> rootClass [ 

	 rootClass := self extractRootClassFrom: self class.
	^ rootClass 
	
]
