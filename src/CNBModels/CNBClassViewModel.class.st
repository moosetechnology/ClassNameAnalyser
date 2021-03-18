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

{ #category : #accessing }
CNBClassViewModel >> changeTokenTo: aToken [

	self token: aToken.
	self model token: aToken
]

{ #category : #operations }
CNBClassViewModel >> create [

	self
			name: model name;
			originalColor: root color copy;
			color: root color;
			token: model token
		
]

{ #category : #initialization }
CNBClassViewModel >> createBox [ 

	^ super 
			createBox
				width: self width;
				height: self height.


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

{ #category : #initialization }
CNBClassViewModel >> initialize [ 
	super initialize.
	
	box := RSBox new.
	rootBorderWidth := 4.
	height := 45.
	width := 45.
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

{ #category : #'as yet unclassified' }
CNBClassViewModel >> monoMultiSiblingsIn: aTokenViewModel [ 

	^ aTokenViewModel 
		classViewModels
	 		select: [ :each | each rootName = self rootName ] 
]

{ #category : #'as yet unclassified' }
CNBClassViewModel >> monoTraitSiblingsIn: aTokenViewModel [ 

	| monoTraitClasses |
	
	monoTraitClasses 
		:= aTokenViewModel classViewModels select: [ :each | each root isMonoClass or: [ each root isTrait ] ].
		
		^ monoTraitClasses 
				select: [ :aClass | (aClass tokens anySatisfy: [ :aToken | self tokens includes: aToken ] ) ].
						
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

{ #category : #'as yet unclassified' }
CNBClassViewModel >> rootName [
	^ CNBFilterer removeAllDigitsAndSpecialCharsFrom: root name.
]

{ #category : #interaction }
CNBClassViewModel >> showBoxName [

	self box popupText: name
]

{ #category : #'as yet unclassified' }
CNBClassViewModel >> siblingsIn: aTokenViewModel [ 
	
	^ (self root isTrait or: [ self root isMonoClass ])
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
