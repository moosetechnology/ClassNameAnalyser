Class {
	#name : #CNBRoassalView,
	#superclass : #Object,
	#instVars : [
		'canvas',
		'model'
	],
	#category : #CNBModels
}

{ #category : #building }
CNBRoassalView >> build [
	self contain: model buildRoassal3View
]

{ #category : #accessing }
CNBRoassalView >> canvas [
	^canvas
]

{ #category : #'as yet unclassified' }
CNBRoassalView >> contain: aBuiltModel [
	canvas := aBuiltModel
]

{ #category : #accessing }
CNBRoassalView >> model: aModel [
	model := aModel
]
