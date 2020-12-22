Class {
	#name : #DMPackageModel,
	#superclass : #DMModel,
	#instVars : [
		'classmodels'
	],
	#category : #DMModels
}

{ #category : #accessing }
DMPackageModel >> classmodels [
	^classmodels
]

{ #category : #accessing }
DMPackageModel >> classmodels: classModels [

	classmodels := classModels
]

{ #category : #initialization }
DMPackageModel >> initialize [
	super initialize.
]
