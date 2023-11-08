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

	^ model classDepthAccordingTo: setting rootClass 
]

{ #category : #initialization }
CNBClassModel >> create [

	| aToken aRoot |
	aRoot := model rootAccordingTo: setting rootClass.
	aToken := CNBFeatureSelector new
		          extract: setting token
		          from: self model name.

	self
		name: (CNBFilterer removeAllDigitsAndSpecialCharsFrom: model name);
		root: aRoot;
		superclass: self superclass;
		token: aToken;
		depth: self classDepth
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

	^ (setting token = #both ) 
	ifTrue: [  (CNBFeatureSelector new tokensOf: root name) includes: self token ]
	ifFalse: [ (CNBFeatureSelector new extract: setting token from: root name) = self token ]
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

	super name: aName.
	model exists ifFalse: [ ^ self ].
	
	setting noPackagesNames 
	ifTrue: [ name := (CNBBuilder removePackageNameFromClass: model).
	self token: (CNBFeatureSelector new extract: setting token from: name) ]

	ifFalse: [ self token: (CNBFeatureSelector new extract: setting token from: aName) ]
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
CNBClassModel >> suffix [

	^ CNBFeatureSelector new extractSuffixFrom: name
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

	| featureSelector |
	featureSelector := CNBFeatureSelector new.

	^ {
		  (featureSelector extractPrefixFrom: name).
		  (featureSelector extractSuffixFrom: name) }
]
