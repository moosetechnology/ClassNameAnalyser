Class {
	#name : #PackageViewModelTests,
	#superclass : #TestCase,
	#instVars : [
		'viewModel',
		'mooseModel'
	],
	#category : #CNBModels
}

{ #category : #tests }
PackageViewModelTests >> setUp [ 

	viewModel := CNBViewModel new withSuffix.
	mooseModel := CNBMooseModelGenerator projectNameMatches: 'moose-*'.
	viewModel model: mooseModel.
	viewModel startBuilding
]

{ #category : #tests }
PackageViewModelTests >> testHasScatteredVocabularyInside [

	| aPackage |
	aPackage := viewModel packageViewModels detect: [ :each | each name = 'Moose-SmalltalkImporter' ].
	
	self 
		assert: aPackage hasScatteredVocabularyInside
		equals: true
	

		
]

{ #category : #tests }
PackageViewModelTests >> testScatteredPackages [

		
	self
		assert: viewModel scatteredPackages size 
		equals: 1
]
