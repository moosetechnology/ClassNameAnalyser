Class {
	#name : #DMModel,
	#superclass : #Object,
	#instVars : [
		'name'
	],
	#category : #DMModels
}

{ #category : #'as yet unclassified' }
DMModel class >> name: aName with: something [
	^self new name: aName with: something 
]

{ #category : #'as yet unclassified' }
DMModel class >> name: aName with: something and: else [
	^self new name: aName with: something and: else
]

{ #category : #accessing }
DMModel >> name [ 
	^name
]

{ #category : #accessing }
DMModel >> name: aName [
	name := aName
]