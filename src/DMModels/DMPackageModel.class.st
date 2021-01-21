Class {
	#name : #DMPackageModel,
	#superclass : #DMModel,
	#instVars : [
		'classModels'
	],
	#category : #DMModels
}

{ #category : #accessing }
DMPackageModel >> classModels [
	^classModels
]

{ #category : #accessing }
DMPackageModel >> classModels: aCollectionOfClassModels [

	classModels := aCollectionOfClassModels
]

{ #category : #initialization }
DMPackageModel >> initialize [
	super initialize.
]

{ #category : #'as yet unclassified' }
DMPackageModel >> printOn: aStream [
	super printOn: aStream. 
	aStream nextPutAll: ' ('.
	self name asString printOn: aStream.
	aStream nextPutAll: ')'
]
