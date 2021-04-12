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

{ #category : #'as yet unclassified' }
CNBClassViewModel class >> of: aClassModel with: aRootModel [

	^ (self new
			model: aClassModel;
			root: aRootModel) create.
	
]

{ #category : #accessing }
CNBClassViewModel >> border [ 
	super border.
		
	^ border 
		width: (self isRoot 
							ifTrue: [ self rootBorderWidth ]  
							ifFalse: [ self defaultBorderWidth ] ).
		
]

{ #category : #'as yet unclassified' }
CNBClassViewModel >> changeColorTo: aColor [

	self
		color: aColor;
		originalColor: aColor
]

{ #category : #accessing }
CNBClassViewModel >> changeTokenTo: aToken [

	self token: aToken.
	self model token: aToken
]

{ #category : #operations }
CNBClassViewModel >> create [
	
	root 
		ifNotNil: [  
		self	
			originalColor: root color copy;
			color: root color ].
		
		self
			name: model name;
			token: model token
		
]

{ #category : #initialization }
CNBClassViewModel >> createBox [ 

	| popUpResult |

	popUpResult := self model model print. 
	^ super 
			createBox
				width: self width;
				height: self height;
				popupText: popUpResult.


]

{ #category : #testing }
CNBClassViewModel >> hasPrefix: aPrefix [

	^ ((CNBFeatureSelector extractPrefixFrom: name) = aPrefix ) 
]

{ #category : #accessing }
CNBClassViewModel >> height [

	^ height
]

{ #category : #interaction }
CNBClassViewModel >> hideBoxName [ 

	self box removeInteractionIfPresent: RSPopup 
]

{ #category : #interaction }
CNBClassViewModel >> hideClassDescription [ 

	self box removeInteractionIfPresent: RSPopup 
]

{ #category : #accessing }
CNBClassViewModel >> highlight [

	| canvas |
	canvas := self box topParent. 
	CNBSingletonHighlighter 
			instance property ifNotNil: [  
	CNBSingletonHighlighter 
			instance property highlighted: (CNBSingletonHighlighter instance property highlighted not) ].
	(CNBSingletonHighlighter instance property = self root)
		
	ifFalse:  [ self root highlighted: self root highlighted not.
		CNBSingletonHighlighter instance property: self root ].
	
	self root highlighted
		ifFalse: [ 
			CNBSingletonHighlighter instance reset. 
					canvas color: Color white darker ]
		ifTrue: [  	
	CNBSingletonHighlighter instance highlight: canvas deepNodes accordingTo: self root.
	canvas color: Color black whiter ]
]

{ #category : #initialization }
CNBClassViewModel >> initialize [ 
	super initialize.
	
	box := RSBox new.
	rootBorderWidth := 4.
	height := 45.
	width := 45.
	box when: RSMouseRightClick do: [ :evt | self processEvent: evt ].
	box when: RSMouseLeftClick do: [ :evt |  self highlight ]

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

{ #category : #'as yet unclassified' }
CNBClassViewModel >> monoMultiSiblingsIn: aTokenViewModel [ 

	| siblings |
	siblings := aTokenViewModel 
		classViewModels
	 		select: [ :each | each root model = self root model ].
		^siblings 
]

{ #category : #'as yet unclassified' }
CNBClassViewModel >> monoTraitSiblingsIn: aTokenViewModel [ 

	| monoTraitClasses |
	
	monoTraitClasses 
		:= aTokenViewModel classViewModels select: [ :each | each root subclasses hasOneElement ].
		
		^ monoTraitClasses 
				select: [ :aClass | (aClass tokens anySatisfy: [ :aToken | self tokens includes: aToken ] ) ].
						
]

{ #category : #printing }
CNBClassViewModel >> printOn: aStream [

	super printOn: aStream.
	aStream nextPutAll: '('.
	self model model name asString printOn: aStream.
	aStream nextPutAll: ')'.
]

{ #category : #'events-processing' }
CNBClassViewModel >> processEvent: evt [

	^ self inspect "self model model exists ifTrue: [ model model browse ] ifFalse: [ model model inspect ]"
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

{ #category : #'as yet unclassified' }
CNBClassViewModel >> rootName [
	^ CNBFilterer removeAllDigitsAndSpecialCharsFrom: root name.
]

{ #category : #interaction }
CNBClassViewModel >> showBoxName [

	self box popupText: name
]

{ #category : #'as yet unclassified' }
CNBClassViewModel >> showClassDescription [
		
	self box popupText: self model model print
		
]

{ #category : #'as yet unclassified' }
CNBClassViewModel >> siblingsIn: aTokenViewModel [ 
	
	^ (self root subclasses hasOneElement)
	ifTrue: [ self monoTraitSiblingsIn: aTokenViewModel ]
	ifFalse: [ self monoMultiSiblingsIn: aTokenViewModel  ]. 
	
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
CNBClassViewModel >> tokens [ 
	
	| featureSelector prefix suffix |
	featureSelector := CNBFeatureSelector new.
	prefix := featureSelector extractPrefixFrom: name.
	suffix := featureSelector extractSuffixFrom: name.
	
	^ {  prefix . suffix }
]

{ #category : #accessing }
CNBClassViewModel >> width [ 

	^ width
]
