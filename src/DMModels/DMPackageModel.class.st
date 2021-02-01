Class {
	#name : #DMPackageModel,
	#superclass : #DMModel,
	#instVars : [
		'classModels'
	],
	#category : #DMModels
}

{ #category : #'instance creation' }
DMPackageModel class >> of: aPackage root: aClass [ 
	^self new
		name: aPackage name;
		classModels: (aPackage classes collect: [ :each | each classModelAccordingTo: aClass ])
]

{ #category : #accessing }
DMPackageModel >> classModels [
	^classModels
]

{ #category : #accessing }
DMPackageModel >> classModels: aCollectionOfClassModels [

	classModels := aCollectionOfClassModels
]

{ #category : #printing }
DMPackageModel >> printOn: aStream [
	super printOn: aStream. 
	aStream nextPutAll: ' ('.
	self name asString printOn: aStream.
	aStream nextPutAll: ')'
]
