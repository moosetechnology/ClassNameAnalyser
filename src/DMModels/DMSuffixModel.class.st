Class {
	#name : #DMSuffixModel,
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
DMSuffixModel >> borderColor [ 
	^ Color black
]

{ #category : #accessing }
DMSuffixModel >> classViewModels [
	^ classViewModels 
]

{ #category : #accessing }
DMSuffixModel >> classViewModels: aCollectionOfClassViewModels [
	classViewModels := aCollectionOfClassViewModels.
	size := aCollectionOfClassViewModels size
]

{ #category : #accessing }
DMSuffixModel >> color [ 
	^ color
]

{ #category : #accessing }
DMSuffixModel >> color: aColor [
	color := aColor 
]

{ #category : #accessing }
DMSuffixModel >> label [
	| label |
	label := (('Test*' match: name) or: [ '*Test' match: name ])
		ifTrue: [ (classViewModels allSatisfy: [ :each | 'Test*' match: each name ])
				ifTrue: [ name , '(P)' ].
			(classViewModels allSatisfy: [ :each | '*Test' match: each name ])
				ifTrue: [ name , '(S)' ]
				ifFalse: [ name , '(P+S)' ] ]
		ifFalse: [ name ].
	^ label
]

{ #category : #printing }
DMSuffixModel >> printOn: aStream [
	super printOn: aStream. 
	aStream nextPutAll: ' ('.
	self name asString printOn: aStream.
	aStream nextPutAll: self root name.
	aStream nextPutAll: ')'
]

{ #category : #accessing }
DMSuffixModel >> root [
	^root
]

{ #category : #accessing }
DMSuffixModel >> root: biggestHierarchy [
	root := biggestHierarchy
]

{ #category : #accessing }
DMSuffixModel >> size [
	^classViewModels size 
]
