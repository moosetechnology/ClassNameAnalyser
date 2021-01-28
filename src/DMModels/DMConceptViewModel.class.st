Class {
	#name : #DMConceptViewModel,
	#superclass : #DMModel,
	#instVars : [
		'color',
		'root',
		'classViewModels',
		'size'
	],
	#category : #DMModels
}

{ #category : #'brick-properties' }
DMConceptViewModel >> borderColor [ 
	^ Color black
]

{ #category : #accessing }
DMConceptViewModel >> classViewModels [
	^ classViewModels 
]

{ #category : #accessing }
DMConceptViewModel >> classViewModels: aCollectionOfClassViewModels [
	classViewModels := aCollectionOfClassViewModels.
	size := aCollectionOfClassViewModels size
]

{ #category : #accessing }
DMConceptViewModel >> color [ 
	^ color
]

{ #category : #accessing }
DMConceptViewModel >> color: aColor [
	color := aColor 
]

{ #category : #accessing }
DMConceptViewModel >> label [
	(name = 'Test')
		ifTrue: [ (classViewModels allSatisfy: [ :each | 'Test*' match: each name ])
				ifTrue: [ ^ name , ' (P)' ].
			(classViewModels allSatisfy: [ :each | '*Test' match: each name ])
				ifTrue: [ ^ name , ' (S)' ]
				ifFalse: [ ^ name , ' (P+S)' ] ]
		ifFalse: [ ^name ].
	
]

{ #category : #printing }
DMConceptViewModel >> printOn: aStream [
	super printOn: aStream. 
	aStream nextPutAll: ' ('.
	self name asString printOn: aStream.
	aStream nextPutAll: self root name.
	aStream nextPutAll: ')'
]

{ #category : #accessing }
DMConceptViewModel >> root [
	^root
]

{ #category : #accessing }
DMConceptViewModel >> root: biggestHierarchy [
	root := biggestHierarchy
]

{ #category : #accessing }
DMConceptViewModel >> size [
	^classViewModels size 
]
