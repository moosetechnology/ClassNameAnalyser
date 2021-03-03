"
I am the model representation of a class and its visualization.
"
Class {
	#name : #CNBClassViewModel,
	#superclass : #CNBAbstractViewModel,
	#instVars : [
		'root',
		'reference',
		'height',
		'width',
		'suffix',
		'prefix'
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

{ #category : #'as yet unclassified' }
CNBClassViewModel >> create: aClassModel [

	self 
		name: aClassModel name;
		reference: aClassModel reference;
		suffix: aClassModel suffix;
		prefix: aClassModel prefix
	
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

{ #category : #'as yet unclassified' }
CNBClassViewModel >> hideBoxName [ 
	self box removeInteractionIfPresent: RSPopup 
]

{ #category : #initialization }
CNBClassViewModel >> initialize [ 
	super initialize.
	box := RSBox new.
	box when: RSMouseLeftClick do: [ :evt | self processEvent: evt ].
	
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
CNBClassViewModel >> prefix [
	^prefix
]

{ #category : #accessing }
CNBClassViewModel >> prefix: aPrefix [
	prefix := aPrefix
]

{ #category : #'events-processing' }
CNBClassViewModel >> processEvent: evt [

	^ (Smalltalk image classNamed: name) browse
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

{ #category : #'as yet unclassified' }
CNBClassViewModel >> showBoxName [
	self box popupText: name
]

{ #category : #accessing }
CNBClassViewModel >> suffix [
	^suffix
]

{ #category : #accessing }
CNBClassViewModel >> suffix: aSuffix [
	suffix := aSuffix
]

{ #category : #accessing }
CNBClassViewModel >> width [ 
	^35
]
