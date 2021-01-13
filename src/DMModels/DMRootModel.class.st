Class {
	#name : #DMRootModel,
	#superclass : #DMModel,
	#instVars : [
		'subclasses',
		'color',
		'type',
		'concepts',
		'size',
		'dominantConcept'
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
DMRootModel >> concepts: aCollectionOfSubclasses [
	| suffixes |
	suffixes := aCollectionOfSubclasses collect: #concept.
	suffixes do: [ :aSuffix | concepts at: aSuffix put: (suffixes occurrencesOf: aSuffix) ].
	self dominantConcept: (concepts associations reverseSortedAs: [ :each | each value ]) first 
	
]

{ #category : #'as yet unclassified' }
DMRootModel >> dominantConcept [
	^dominantConcept 
]

{ #category : #accessing }
DMRootModel >> dominantConcept: aConcept [ 
	dominantConcept := aConcept 
]

{ #category : #initialization }
DMRootModel >> initialize [ 
	super initialize.
	concepts := Dictionary new
]

{ #category : #printing }
DMRootModel >> printOn: aStream [
	super printOn: aStream. 
	aStream nextPutAll: ' ('.
	self name asString printOn: aStream.
	aStream nextPutAll: ')'
]

{ #category : #accessing }
DMRootModel >> size [
	^subclasses size
	
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
	
]

{ #category : #accessing }
DMRootModel >> type [ 
	^type
]

{ #category : #'as yet unclassified' }
DMRootModel >> type: aType [
	type := aType.
]
