Class {
	#name : #DMClassModel,
	#superclass : #Object,
	#instVars : [
		'class',
		'className',
		'concept',
		'rootClass'
	],
	#category : #DMFeatureSelector
}

{ #category : #accessing }
DMClassModel >> class [
	^ class
]

{ #category : #setter }
DMClassModel >> class: aClass [
	class := aClass
]

{ #category : #accessing }
DMClassModel >> className [
	^className 
]

{ #category : #setter }
DMClassModel >> className: aClassName [
	className := aClassName 
]

{ #category : #accessing }
DMClassModel >> concept [
	^ concept 
]

{ #category : #setter }
DMClassModel >> concept: aConcept [
	concept := aConcept
]

{ #category : #actions }
DMClassModel >> createFrom: aClass with: aFeatureSelector [
	"The root class should also be extracted here"
	
	self class:	aClass.
	self className: (aClass instanceSide name) asString.
	self concept: (self extractConceptFrom: className with: aFeatureSelector).
	^ self
	
]

{ #category : #actions }
DMClassModel >> extractConceptFrom: aClassName with: aFeatureSelector [

	| aConcept featureSelector |
	featureSelector := aFeatureSelector.
	aConcept := featureSelector extractConceptFrom: aClassName.
	^ aConcept 
]

{ #category : #actions }
DMClassModel >> extractRootClassFrom: aClass [

	(aClass == Object)
		ifTrue: [ ^ aClass  ] 
		ifFalse: [ (aClass superclass == Object)
							ifTrue: [ ^ aClass  ]
							ifFalse: [  ^ self extractRootClassFrom: (aClass superclass)  ]		]
]

{ #category : #accessing }
DMClassModel >> rootClass [ 

	 rootClass := self extractRootClassFrom: self class.
	^ rootClass 
	
]

{ #category : #setter }
DMClassModel >> rootClass: aClass [
	rootClass := self extractRootClassFrom: aClass.
	^ rootClass 
]
