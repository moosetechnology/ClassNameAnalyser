Class {
	#name : #DMSuffixViewModel,
	#superclass : #DMModel,
	#instVars : [
		'color',
		'root',
		'classViewModels',
		'size'
	],
	#category : #CNBModels
}

{ #category : #'brick-properties' }
DMSuffixViewModel >> borderColor [ 
	^ Color black
]

{ #category : #accessing }
DMSuffixViewModel >> classViewModels [
	^ classViewModels  
]

{ #category : #accessing }
DMSuffixViewModel >> classViewModels: aCollectionOfClassViewModels [
	classViewModels := aCollectionOfClassViewModels.
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

{ #category : #initialization }
DMSuffixViewModel >> createBox [
	| suffixBox |
	suffixBox := RSComposite new 
						model: self;
						popupText: name; 
						withBorder;
						borderColor: self borderColor;
						color: self color.
	^suffixBox
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
	^size 
]
