Class {
	#name : #DMOrderAttributorTest,
	#superclass : #TestCase,
	#instVars : [
		'orderAttributor'
	],
	#category : #'DMClassNameBlueprint-Tests'
}

{ #category : #running }
DMOrderAttributorTest >> setUp [ 
	orderAttributor := DMOrderAttributor new.
]
