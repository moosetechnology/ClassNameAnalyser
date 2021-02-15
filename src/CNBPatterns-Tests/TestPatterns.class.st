Class {
	#name : #TestPatterns,
	#superclass : #TestCase,
	#category : #'CNBPatterns-Tests'
}

{ #category : #tests }
TestPatterns >> testHomogeneous [
	
	| cnb homogeneousPackage homogeneousModel notHomogeneousPackage notHomogeneousModel |
	cnb := DMClassNamesBlueprintSample projectNameMatches: 'moose-*'.
	homogeneousPackage := cnb viewModel models detect: [ :package | package name = 'Moose-MenuBar' ].
	notHomogeneousPackage := cnb viewModel models detect: [ :package | package name = 'Moose-Algos-Graph' ].
	homogeneousModel := homogeneousPackage models asOrderedCollection first.
	notHomogeneousModel := notHomogeneousPackage models asOrderedCollection first.
	self 
		assert: homogeneousModel isHomogeneous equals: true.
	
	self 
		assert: notHomogeneousModel isHomogeneous equals: false.
	
]
