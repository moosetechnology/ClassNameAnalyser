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

{ #category : #printing }
CNBPackageModel >> printOn: aStream [
	super printOn: aStream. 
	aStream nextPutAll: ' ('.
	self name asString printOn: aStream.
	aStream nextPutAll: ')'
]
