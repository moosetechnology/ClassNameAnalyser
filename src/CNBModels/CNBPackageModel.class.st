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
CNBPackageModel class >> of: aPackage withSettings: settings [ 
	^ self new
		name: aPackage name;
		classModels: (aPackage classes collect: [ :each | each classModelAccordingTo: settings ])
]

{ #category : #accessing }
CNBPackageModel >> classModels [
	^ classModels
]

{ #category : #accessing }
CNBPackageModel >> classModels: aCollectionOfClassModels [

	classModels := aCollectionOfClassModels
]

{ #category : #testing }
CNBPackageModel >> includesToken: aToken [


	| tokens |
	tokens := self classModels collect: #token.
	^ (tokens includes: aToken)
]

{ #category : #printing }
CNBPackageModel >> printOn: aStream [
	super printOn: aStream. 
	aStream nextPutAll: ' ('.
	self name asString printOn: aStream.
	aStream nextPutAll: ')'
]

{ #category : #accessing }
CNBPackageModel >> tokensDictionary [ 
	^ classModels collect: [ :each | each token ]
]
