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

{ #category : #tests }
TestPatternSelector >> testHierarchyPattern [

	| aRoot |
	aRoot := roots atRandom.
	self assert: aRoot pattern name equals: (CNBPatternSelector of: aRoot) name 
]

{ #category : #tests }
TestPatternSelector >> testHomogeneous [

	| cnb homogeneousPackage homogeneousModel |
	cnb := DMClassNamesBlueprintSample projectNameMatches: 'moose-*'.
	homogeneousPackage := cnb viewModel models detect: [ :package | 
		                      package name = 'Moose-MenuBar' ].

	homogeneousModel := homogeneousPackage models asOrderedCollection
		                    first.
	self assert: homogeneousModel isHomogeneous equals: true.

]

{ #category : #tests }
TestPatternSelector >> testNotHomogeneous [

	| cnb notHomogeneousPackage notHomogeneousModel |
	cnb := DMClassNamesBlueprintSample projectNameMatches: 'moose-*'.

	notHomogeneousPackage := cnb viewModel models detect: [ :package | 
		                         package name = 'Moose-Algos-Graph' ].

	notHomogeneousModel := notHomogeneousPackage models
		                       asOrderedCollection first. 
		self assert: notHomogeneousModel isHomogeneous equals: false
]
