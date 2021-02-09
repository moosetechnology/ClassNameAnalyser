"
I am the model representation of a class and its visualization.
"
Class {
	#name : #CNBClassViewModel,
	#superclass : #CNBAbstractViewModel,
	#instVars : [
		'root',
		'concept',
		'reference',
		'height',
		'width'
	],
	#category : #CNBModels
}

{ #category : #accessing }
CNBClassViewModel >> border [ 
	| borderWidth |
	super border.
	borderWidth := (self isRoot 
		ifTrue: [ 4 ] 
		ifFalse: [ self defaultBorderWidth ] ).
	border width: borderWidth.
	^border
]

{ #category : #accessing }
CNBClassViewModel >> concept [
	^concept
]

{ #category : #accessing }
CNBClassViewModel >> concept: aClassName [
	concept := DMFeatureSelector new extractConceptFrom: aClassName
]

{ #category : #initialization }
CNBClassViewModel >> createBox [ 
	^super createBox
						width: self width;
						height: self height.


]

{ #category : #accessing }
CNBClassViewModel >> height [
	^35
]

{ #category : #testing }
CNBClassViewModel >> isRoot [ 
	^self name = self root name 
]

{ #category : #accessing }
CNBClassViewModel >> models [ 
	^ reference methods
]

{ #category : #accessing }
CNBClassViewModel >> reference [ 
	^reference
]

{ #category : #accessing }
CNBClassViewModel >> reference: aReference [

	reference := aReference
]

{ #category : #accessing }
CNBClassViewModel >> root [
	^root
]

{ #category : #accessing }
CNBClassViewModel >> root: aRoot [

	root := aRoot
		
]

{ #category : #accessing }
CNBClassViewModel >> width [ 
	^35
]
