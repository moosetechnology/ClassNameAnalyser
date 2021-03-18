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
		'setting'
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

{ #category : #initialization }
CNBClassModel >> create [
	| aToken aRoot |
	
	aToken := CNBFeatureSelector new extract: setting token from: self model name.
	aRoot 
		:= (Smalltalk image classNamed: model name) 
				ifNil: [ self model rootAccordingTo: setting rootClass ] 
				ifNotNil: [ (Smalltalk image classNamed: model name) rootAccordingTo: setting rootClass ].
	
		self 
			name: model name;
			root: aRoot;
			superclass: self superclass;
			token: aToken.
			
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

	root := aRoot
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
	
	^ {  prefix . suffix }
]
