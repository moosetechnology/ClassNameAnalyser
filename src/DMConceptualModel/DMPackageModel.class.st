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
DMPackageModel >> classModels: aCollectionOfClassModels [
	classModels := aCollectionOfClassModels 
]

{ #category : #accessing }
DMPackageModel >> classes [ 
	^ classes
]

{ #category : #setter }
DMPackageModel >> classes: 	aCollectionOfClasses [
	classes := aCollectionOfClasses 
]

{ #category : #accessing }
DMPackageModel >> packageName [
	^ packageName 
]

{ #category : #setter }
DMPackageModel >> packageName: aPackageName [
	packageName := aPackageName
]
