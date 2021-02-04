Class {
	#name : #DMSuffixViewModel,
	#superclass : #DMModel,
	#instVars : [
		'color',
		'root',
		'suffixViewModels',
		'size'
	],
	#category : #DMModels
}

{ #category : #'brick-properties' }
DMSuffixViewModel >> borderColor [ 
	^ Color black
]

{ #category : #accessing }
DMSuffixViewModel >> classViewModels [
	^ suffixViewModels 
]

{ #category : #accessing }
DMSuffixViewModel >> classViewModels: aCollectionOfClassViewModels [
	suffixViewModels := aCollectionOfClassViewModels.
	size := aCollectionOfClassViewModels size
]

{ #category : #accessing }
DMSuffixViewModel >> color [ 
	^ color
]

{ #category : #accessing }
DMSuffixViewModel >> color: aColor [
	color := aColor 
]

{ #category : #accessing }
DMSuffixViewModel >> label [
	^name
]

{ #category : #printing }
DMSuffixViewModel >> printOn: aStream [
	super printOn: aStream. 
	aStream nextPutAll: ' ('.
	self name asString printOn: aStream.
	aStream nextPutAll: self root name.
	aStream nextPutAll: ')'
]

{ #category : #accessing }
DMSuffixViewModel >> root [
	^root
]

{ #category : #accessing }
DMSuffixViewModel >> root: biggestHierarchy [
	root := biggestHierarchy
]

{ #category : #accessing }
DMSuffixViewModel >> size [
	^suffixViewModels size 
]
