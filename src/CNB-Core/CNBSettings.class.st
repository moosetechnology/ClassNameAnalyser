Class {
	#name : #CNBSettings,
	#superclass : #Object,
	#instVars : [
		'token',
		'rootClass'
	],
	#category : #'CNB-Core'
}

{ #category : #'as yet unclassified' }
CNBSettings >> defaultRootClass [ 
	^ 'Object'
]

{ #category : #'as yet unclassified' }
CNBSettings >> defaultToken [ 
	^ #suffix
]

{ #category : #accessing }
CNBSettings >> rootClass [
	^ rootClass ifNil: [ self defaultRootClass ]
]

{ #category : #accessing }
CNBSettings >> rootClass: aClassName [
	rootClass := aClassName 
]

{ #category : #accessing }
CNBSettings >> token [
	^ token ifNil: [ self defaultToken  ]
]

{ #category : #accessing }
CNBSettings >> token: aSymbol [
	token := aSymbol
]
