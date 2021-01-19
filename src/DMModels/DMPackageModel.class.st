Class {
	#name : #DMPackageModel,
	#superclass : #DMModel,
	#instVars : [
		'classmodels'
	],
	#category : #DMModels
}

{ #category : #accessing }
DMPackageModel >> classModels [
	^classmodels
]

{ #category : #accessing }
DMPackageModel >> classModels: classModels [

	classmodels := classModels
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
