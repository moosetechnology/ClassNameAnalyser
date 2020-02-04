Class {
	#name : #DMPackageModel,
	#superclass : #DMModel,
	#instVars : [
		'name',
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
	classmodels := DMClassModelGroup new.
]
