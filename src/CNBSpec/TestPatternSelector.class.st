Class {
	#name : #TestPatternSelector,
	#superclass : #TestCase,
	#instVars : [
		'projectCNB',
		'roots'
	],
	#category : #CNBSpec
}

{ #category : #running }
TestPatternSelector >> setUp [
	super setUp.

	projectCNB := CNBRoassal3Builder projectNameMatches: 'moose-*'.
	roots := projectCNB viewModel rootModels collect: [ :each | each ].
]
