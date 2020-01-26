Class {
	#name : #DMRootModel,
	#superclass : #Object,
	#instVars : [
		'name',
		'subclasses',
		'color',
		'type',
		'concepts'
	],
	#classVars : [
		'all'
	],
	#category : #DMModels
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
DMRootModel >> concepts [ 
	^concepts
]

{ #category : #accessing }
DMRootModel >> concepts: aCollection [

	concepts := aCollection
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
