"
I am the model representation of a class and its visualization.
"
Class {
	#name : #CNBClassViewModel,
	#superclass : #CNBAbstractViewModel,
	#instVars : [
		'root',
		'height',
		'width',
		'token',
		'rootBorderWidth',
		'model'
	],
	#category : #CNBModels
}

{ #category : #accessing }
CNBClassViewModel >> border [ 
	| borderWidth |
	super border.
	borderWidth := (self isRoot 
		ifTrue: [ self rootBorderWidth ]  
		ifFalse: [ self defaultBorderWidth ] ).
	border width: borderWidth.
	^border
]

{ #category : #creation }
CNBClassViewModel >> create: aClassModel [

	self 
		name: aClassModel name;
		model: aClassModel model;
		token: aClassModel token
	
]

{ #category : #initialization }
CNBClassViewModel >> createBox [ 
	^ super createBox
						width: self width;
						height: self height.


]

{ #category : #accessing }
CNBClassViewModel >> height [
	^ height
]

{ #category : #interaction }
CNBClassViewModel >> hideBoxName [ 
	self box removeInteractionIfPresent: RSPopup 
]

{ #category : #initialization }
CNBClassViewModel >> initialize [ 
	super initialize.
	box := RSBox new.
	rootBorderWidth := 4.
	height := 35.
	width := 35.
	box when: RSMouseLeftClick do: [ :evt | self processEvent: evt ].
	
]

{ #category : #testing }
CNBClassViewModel >> isRoot [ 
	^ self name = self root name 
]

{ #category : #accessing }
CNBClassViewModel >> model [ 
	^ model
]

{ #category : #accessing }
CNBClassViewModel >> model: aModel [

	model := aModel
]

{ #category : #'events-processing' }
CNBClassViewModel >> processEvent: evt [

	| class |
	class := (Smalltalk image classNamed: name).
	^ class ifNil: [ self inspect ] ifNotNil:  [ class browse ]
]

{ #category : #accessing }
CNBClassViewModel >> root [
	^ root
]

{ #category : #accessing }
CNBClassViewModel >> root: aRoot [

	root := aRoot
		
]

{ #category : #accessing }
CNBClassViewModel >> rootBorderWidth [
	^ rootBorderWidth
]

{ #category : #interaction }
CNBClassViewModel >> showBoxName [
	self box popupText: name
]

{ #category : #accessing }
CNBClassViewModel >> token [
	^ token
]

{ #category : #accessing }
CNBClassViewModel >> token: aToken [
	token := aToken
]

{ #category : #accessing }
CNBClassViewModel >> width [ 
	^ width
]
