"
I am the model of the suffix of a class name (suffix is the last word in a class name written in the camel case form)
"
Class {
	#name : #DMSuffixViewModel,
	#superclass : #DMModel,
	#instVars : [
		'color',
		'root',
		'classViewModels',
		'size',
		'border'
	],
	#category : #CNBModels
}

{ #category : #'brick-properties' }
DMSuffixViewModel >> border [
	^border color: Color black;yourself
]

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
	| suffixBox labeled |
	labeled := RSLabeled text: self name.
	labeled fontSize: 20.
	labeled location top; center.
	suffixBox := RSComposite new 
						model: self;
						popupText: name; 
						withBorder;
						color: self color;
						border: self border.
	^suffixBox @ labeled

]

{ #category : #initialization }
DMSuffixViewModel >> initialize [ 
	super initialize.
	border := RSBorder new
]

{ #category : #testing }
DMSuffixViewModel >> isSuffixViewModel [
	^true
]

{ #category : #accessing }
DMSuffixViewModel >> label [
	^name
]

{ #category : #accessing }
DMSuffixViewModel >> models [
	^classViewModels 
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
