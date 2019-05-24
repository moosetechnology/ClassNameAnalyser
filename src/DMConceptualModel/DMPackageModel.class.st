Class {
	#name : #DMPackageModel,
	#superclass : #Object,
	#instVars : [
		'packageRef',
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
DMPackageModel >> packageRef [
	^ packageRef
]

{ #category : #setter }
DMPackageModel >> packageRef: aPackageName [
	packageRef := aPackageName
]
