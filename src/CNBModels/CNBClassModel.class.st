"
I am the simple model representation of a class, without visualization informations.
"
Class {
	#name : #CNBClassModel,
	#superclass : #CNBAbstractModel,
	#instVars : [
		'root',
		'superclass',
		'model',
		'token',
		'setting',
		'depth'
	],
	#category : #CNBModels
}

{ #category : #'as yet unclassified' }
CNBClassModel class >> of: aClass accordingTo: setting [

	^ (self new
			model: aClass;
			accordingTo: setting) create.
]

{ #category : #setting }
CNBClassModel >> accordingTo: aSetting [ 

	setting := aSetting
]

{ #category : #accessing }
CNBClassModel >> classDepth [

	^ (Smalltalk image classNamed: model name)
		 ifNotNil: [ (Smalltalk image classNamed: model name) classDepthAccordingTo: self root ]
	 	ifNil: [ model classDepthAccordingTo: self root ]
]

{ #category : #initialization }
CNBClassModel >> create [
	| aToken aRoot |
		
	aRoot 
		:= (Smalltalk image classNamed: model name) 
			ifNil: [ self model rootAccordingTo: setting rootClass ] 
			ifNotNil: [ (Smalltalk image classNamed: model name) rootAccordingTo: setting rootClass ].
	aToken := CNBFeatureSelector new extract: setting token from: self model name.
		self 
			name: (CNBFilterer removeAllDigitsAndSpecialCharsFrom: model name);
			root: aRoot;
			superclass: self superclass;
			token: aToken;
			depth: self classDepth.
			
]

{ #category : #accessing }
CNBClassModel >> depth [

	^ depth
]

{ #category : #accessing }
CNBClassModel >> depth: aDepth [

	depth := aDepth
]

{ #category : #testing }
CNBClassModel >> hasRootToken [
	| rootToken |
	
	rootToken := CNBFeatureSelector new extract: setting token from: self rootName.
	^ token = rootToken 
]

{ #category : #accessing }
CNBClassModel >> model [

	^ model
]

{ #category : #accessing }
CNBClassModel >> model: aModel [

	model := aModel
]

{ #category : #accessing }
CNBClassModel >> name: aName [

	| class |
	super name: aName.
	class := (Smalltalk image classNamed: name).
	(setting token = #both and: class notNil) 
		ifFalse: [ ^ self ].

	name := (CNBBuilder removePackageNameFromClass: class).
	self token: (CNBFeatureSelector new extract: setting token from: name)
]

{ #category : #'as yet unclassified' }
CNBClassModel >> otherToken [

	^ CNBFeatureSelector new extract: setting otherToken from: name
]

{ #category : #printing }
CNBClassModel >> printOn: aStream [

	super printOn: aStream. 
	aStream nextPutAll: ' ('.
	self name asString printOn: aStream.
	aStream nextPutAll: ')'
]

{ #category : #accessing }
CNBClassModel >> root [

	^ root
	
]

{ #category : #accessing }
CNBClassModel >> root: aRoot [

	root := aRoot.
	
]

{ #category : #accessing }
CNBClassModel >> rootAccordingTo: aRootClass [

	^ self root: (model rootAccordingTo: aRootClass)
]

{ #category : #'as yet unclassified' }
CNBClassModel >> rootName [
	^ CNBFilterer removeAllDigitsAndSpecialCharsFrom: root name.
]

{ #category : #accessing }
CNBClassModel >> setting [

	^ setting
]

{ #category : #accessing }
CNBClassModel >> superclass [

	^ superclass
]

{ #category : #accessing }
CNBClassModel >> superclass: aClass [

	superclass := aClass 
]

{ #category : #accessing }
CNBClassModel >> token [

	^ token
]

{ #category : #accessing }
CNBClassModel >> token: aToken [

	token := aToken
]

{ #category : #accessing }
CNBClassModel >> tokens [ 
	
	| featureSelector prefix suffix |
	featureSelector := CNBFeatureSelector new.
	prefix := featureSelector extractPrefixFrom: name.
	suffix := featureSelector extractSuffixFrom: name.
	
	^ { prefix . suffix }
]
