"
I am the model representation of a class and its visualization.
"
Class {
	#name : #DMClassViewModel,
	#superclass : #DMModel,
	#instVars : [
		'color',
		'root',
		'concept',
		'reference',
		'height',
		'width',
		'border'
	],
	#category : #CNBModels
}

{ #category : #accessing }
DMClassViewModel >> border [ 
	border color: self borderColor.
	border width: self borderWidth.
	^border
]

{ #category : #accessing }
DMClassViewModel >> borderColor [ 
	border color isNotNil 
		ifFalse: [ ^Color black ].
	
	^border color 
	
]

{ #category : #accessing }
DMClassViewModel >> borderColor: aColor [ 	
	border color: aColor
]

{ #category : #accessing }
DMClassViewModel >> borderWidth [ 
	^self isRoot
	ifTrue: [ 4 ]
	ifFalse: [ 1 ]
]

{ #category : #accessing }
DMClassViewModel >> color [
	^ color
]

{ #category : #accessing }
DMClassViewModel >> color: aColor [
	color := aColor 
]

{ #category : #accessing }
DMClassViewModel >> concept [
	^concept
]

{ #category : #accessing }
DMClassViewModel >> concept: aClassName [
	concept := DMFeatureSelector new extractConceptFrom: aClassName
]

{ #category : #initialization }
DMClassViewModel >> createBox [ 
	| classBox |
	classBox := RSBox new 
						width: self width;
						height: self height.
					classBox 
						model: self;
						popupText: name; 
						color: self color; 
						withBorder.
					classBox border: self border.
	^ classBox
]

{ #category : #accessing }
DMClassViewModel >> height [
	^25
]

{ #category : #initialization }
DMClassViewModel >> initialize [ 
	super initialize.
	border := RSBorder new color: nil
]

{ #category : #testing }
DMClassViewModel >> isClassViewModel [
	^true
]

{ #category : #testing }
DMClassViewModel >> isRoot [ 
	^self name = self root name 
]

{ #category : #accessing }
DMClassViewModel >> label [
	^''
]

{ #category : #accessing }
DMClassViewModel >> models [ 
	^ reference methods
]

{ #category : #testing }
DMClassViewModel >> printOn: aStream [
	super printOn: aStream. 
	aStream nextPutAll: ' ('.
	self name asString printOn: aStream.
	aStream nextPutAll: ' Superclass: '.
	aStream nextPutAll: self reference superclass name.
	aStream nextPutAll: ' Root: '.
	aStream nextPutAll: self root name.
	aStream nextPutAll: ')'
]

{ #category : #accessing }
DMClassViewModel >> reference [ 
	^reference
]

{ #category : #accessing }
DMClassViewModel >> reference: aReference [

	reference := aReference
]

{ #category : #accessing }
DMClassViewModel >> root [
	^root
]

{ #category : #accessing }
DMClassViewModel >> root: aRoot [

	root := aRoot
		
]

{ #category : #accessing }
DMClassViewModel >> width [ 
	^25
]
