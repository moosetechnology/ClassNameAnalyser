Class {
	#name : #DMModelGroup,
	#superclass : #Collection,
	#instVars : [
		'elements'
	],
	#category : #DMModels
}

{ #category : #adding }
DMModelGroup >> add: aModel [
 	elements add: aModel
]

{ #category : #adding }
DMModelGroup >> addAll: models [
	elements addAll: models
]

{ #category : #enumerating }
DMModelGroup >> do: aBlock [
	self elements do: aBlock
]

{ #category : #accessing }
DMModelGroup >> elements [
	^elements
]

{ #category : #initialization }
DMModelGroup >> initialize [
	super initialize.
	elements := OrderedCollection new.
]
