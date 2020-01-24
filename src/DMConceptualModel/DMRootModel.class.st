Class {
	#name : #DMRootModel,
	#superclass : #Object,
	#instVars : [
		'name',
		'subclasses',
		'color',
		'type',
		'concept'
	],
	#classVars : [
		'all'
	],
	#category : #DMConceptualModel
}

{ #category : #accessing }
DMRootModel >> color [ 
	^color
]

{ #category : #accessing }
DMRootModel >> color: aColor [
	color := aColor
]

{ #category : #accessing }
DMRootModel >> concept [ 

	^concept
]

{ #category : #accessing }
DMRootModel >> concept: aClassName [

	concept := DMFeatureSelector new extractConceptFrom: aClassName
]

{ #category : #accessing }
DMRootModel >> name [ 
	^name
]

{ #category : #accessing }
DMRootModel >> name: aName [
	name := aName
]

{ #category : #accessing }
DMRootModel >> subclasses [ 
	^subclasses
]

{ #category : #accessing }
DMRootModel >> subclasses: classVMGroup [

	subclasses := classVMGroup 
]

{ #category : #accessing }
DMRootModel >> type [ 
	^type
]

{ #category : #'as yet unclassified' }
DMRootModel >> type: aType [
	type := aType.
]
