Class {
	#name : #DMPackageModel,
	#superclass : #Object,
	#instVars : [
		'packageName',
		'classes',
		'classModels'
	],
	#category : #DMConceptualModel
}

{ #category : #accessing }
DMPackageModel >> classModels [
	^ classModels 
]

{ #category : #setter }
DMPackageModel >> classModels: aCollectionOfPackageModels [
	classModels := aCollectionOfPackageModels 
]

{ #category : #accessing }
DMPackageModel >> classes [ 
	^ classes
]

{ #category : #setter }
DMPackageModel >> classes: 	aCollectionOfClasses [
	classes := aCollectionOfClasses 
]

{ #category : #initialization }
DMPackageModel >> initialize [ 

	super initialize.
	classes := OrderedCollection new.

]

{ #category : #accessing }
DMPackageModel >> packageName [
	^ packageName 
]

{ #category : #setter }
DMPackageModel >> packageName: aPackageName [
	packageName := aPackageName
]
