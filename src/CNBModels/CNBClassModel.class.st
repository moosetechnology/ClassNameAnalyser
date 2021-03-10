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

{ #category : #'as yet unclassified' }
CNBClassModel >> accordingTo: aSetting [ 
	setting := aSetting
]

{ #category : #operations }
CNBClassModel >> create [
	| aToken aRoot |
	aToken := CNBFeatureSelector new extract: setting token from: self model name.
	aRoot := (Smalltalk image classNamed: model name) rootAccordingTo: setting rootClass.
	
		self 
			name: model name;
			root: aRoot;
			superclass: self superclass;
			token: aToken.
			
]

{ #category : #testing }
CNBClassModel >> hasRootToken [
	| rootToken |
	rootToken := CNBFeatureSelector new extract: setting token from: root name.
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
	self root: (model rootAccordingTo: aRootClass).
	^ self root
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
