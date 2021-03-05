"
I am a simple model of a Package
"
Class {
	#name : #CNBPackageModel,
	#superclass : #CNBAbstractModel,
	#instVars : [
		'classModels'
	],
	#category : #CNBModels
}

{ #category : #'as yet unclassified' }
CNBPackageModel class >> of: aPackage root: aClass [ 
	^self new
		name: aPackage name;
		classModels: (aPackage classes collect: [ :each | each classModelAccordingTo: aClass ])
]

{ #category : #accessing }
CNBPackageModel >> classModels [
	^classModels
]

{ #category : #accessing }
CNBPackageModel >> classModels: aCollectionOfClassModels [

	classModels := aCollectionOfClassModels
]

{ #category : #testing }
CNBPackageModel >> includesSuffix: aSuffix [


	| suffixes |
	suffixes := self classModels collect: #suffix.
	^ (suffixes includes: aSuffix)
]

{ #category : #accessing }
CNBPackageModel >> originalColor [
	^ self defaultColor 
]

{ #category : #printing }
CNBPackageModel >> printOn: aStream [
	super printOn: aStream. 
	aStream nextPutAll: ' ('.
	self name asString printOn: aStream.
	aStream nextPutAll: ')'
]

{ #category : #accessing }
CNBPackageModel >> suffixes [ 
	^ classModels collect: [ :each | each suffix ]
]
