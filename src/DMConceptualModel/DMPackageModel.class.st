Class {
	#name : #DMPackageModel,
	#superclass : #DMModel,
	#instVars : [
		'name',
		'classmodels'
	],
	#category : #DMConceptualModel
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

{ #category : #accessing }
DMPackageModel >> name [
	^name
]

{ #category : #accessing }
DMPackageModel >> name: aName [
	name := aName
]

{ #category : #initialization }
DMPackageModel >> name: aName with: aClassModelGroup [

	self name: aName.
	self classmodels: aClassModelGroup
]
