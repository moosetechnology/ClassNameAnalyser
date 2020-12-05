Class {
	#name : #DMRootModel,
	#superclass : #DMModel,
	#instVars : [
		'subclasses',
		'color',
		'type',
		'concepts',
		'size'
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
	concepts := Set new.
	subclasses := Set new.

]

{ #category : #accessing }
DMRootModel >> size [
	^size
	
]

{ #category : #accessing }
DMRootModel >> size: aSize [
	size := aSize 
]

{ #category : #accessing }
DMRootModel >> subclasses [ 
	^subclasses
]

{ #category : #accessing }
DMRootModel >> subclasses: classesCollection [
	classesCollection size = 1
		& ((classesCollection at: 1) name = self name)
		ifTrue: [ size := 0 ].
	subclasses := classesCollection
		collect: [ :eachClass | eachClass classmodel ].
	concepts addAll: (subclasses collect: #concept).
	size := subclasses size.
]

{ #category : #accessing }
DMRootModel >> type [ 
	^type
]

{ #category : #'as yet unclassified' }
DMRootModel >> type: aType [
	type := aType.
]
