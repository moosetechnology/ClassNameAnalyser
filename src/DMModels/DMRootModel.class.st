Class {
	#name : #DMRootModel,
	#superclass : #DMModel,
	#instVars : [
		'subclasses',
		'color',
		'type',
		'concepts'
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

{ #category : #initialization }
DMRootModel >> initialize [ 
	concepts := Set new

]

{ #category : #accessing }
DMRootModel >> subclasses [ 
	^subclasses
]

{ #category : #accessing }
DMRootModel >> subclasses: classVMGroup [

	subclasses := classVMGroup.
	concepts addAll: (classVMGroup collect: #concept)
]

{ #category : #accessing }
DMRootModel >> type [ 
	^type
]

{ #category : #'as yet unclassified' }
DMRootModel >> type: aType [
	type := aType.
]
