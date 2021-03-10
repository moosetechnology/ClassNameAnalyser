Class {
	#name : #CNBSettings,
	#superclass : #Object,
	#instVars : [
		'token',
		'rootClass'
	],
	#category : #'CNB-Core'
}

{ #category : #accessing }
CNBSettings >> defaultRootClass [ 
	^ Object
]

{ #category : #accessing }
CNBSettings >> defaultToken [ 
	^ #suffix
]

{ #category : #accessing }
CNBSettings >> rootClass [
	^ rootClass ifNil: [ self defaultRootClass ]
]

{ #category : #accessing }
CNBSettings >> rootClass: aClass [
	rootClass := aClass
]

{ #category : #accessing }
CNBSettings >> token [
	^ token ifNil: [ self defaultToken  ]
]

{ #category : #accessing }
CNBSettings >> token: aSymbol [
	token := aSymbol
]
