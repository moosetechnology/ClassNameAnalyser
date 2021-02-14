Class {
	#name : #CNBSettings,
	#superclass : #Object,
	#instVars : [
		'conceptLocation',
		'rootClass'
	],
	#category : #CNBVisualization
}

{ #category : #accessing }
CNBSettings >> conceptLocation: aSymbol [
	conceptLocation := aSymbol
]

{ #category : #accessing }
CNBSettings >> rootClass: aClassName [
	rootClass := aClassName 
]
