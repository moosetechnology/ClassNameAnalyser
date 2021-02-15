Class {
	#name : #CNBSettings,
	#superclass : #Object,
	#instVars : [
		'conceptLocation',
		'rootClass'
	],
	#category : #CNBModels
}

{ #category : #accessing }
CNBSettings >> conceptLocation [
	^conceptLocation
]

{ #category : #accessing }
CNBSettings >> conceptLocation: aSymbol [
	conceptLocation := aSymbol
]

{ #category : #'as yet unclassified' }
CNBSettings >> defaultRootClass [ 
	^ 'Object'
]

{ #category : #accessing }
CNBSettings >> rootClass [
	^ rootClass ifNil: [ self defaultRootClass ]
]

{ #category : #accessing }
CNBSettings >> rootClass: aClassName [
	rootClass := aClassName 
]
