Class {
	#name : #DMPackageModel,
	#superclass : #Object,
	#instVars : [
		'packageName',
		'classes',
		'classModels'
	],
	#category : #DMFeatureSelector
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

{ #category : #actions }
DMPackageModel >> extractClassNamesFrom: aPackageName [
	^ ((RPackageOrganizer default packageNamed: aPackageName)  definedClasses collect: [ :each | each instanceSide name ]).
]

{ #category : #actions }
DMPackageModel >> extractClassesFrom: aPackageName [

	^ ((RPackageOrganizer default packageNamed: aPackageName)  
			definedClasses collect: [ :each | each  ]) asOrderedCollection
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
