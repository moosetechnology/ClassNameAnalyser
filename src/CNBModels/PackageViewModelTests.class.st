Class {
	#name : #PackageViewModelTests,
	#superclass : #TestCase,
	#instVars : [
		'viewModel',
		'mooseModel',
		'scatteredPackage',
		'classNamesDistribution'
	],
	#category : #CNBModels
}

{ #category : #tests }
PackageViewModelTests >> setUp [ 

	viewModel := CNBViewModel new withSuffix.
	classNamesDistribution := ((ClassNamesBlueprint new model: mooseModel) withSuffix) startBuilding.
	mooseModel := CNBMooseModelGenerator projectNameMatches: 'moose-*'. 
	scatteredPackage := classNamesDistribution viewModel packageViewModels detect: [ :each | each name = 'Moose-SmalltalkImporter' ].
	
]

{ #category : #tests }
PackageViewModelTests >> testHasScatteredVocabularyInside [

	
	self 
		assert: scatteredPackage hasScatteredVocabularyInside
		equals: true
	

		
]

{ #category : #tests }
PackageViewModelTests >> testScatteredPackages [

		
	self
		assert: viewModel scatteredPackages size 
		equals: 1
]

{ #category : #tests }
PackageViewModelTests >> testScatteredRoots [

	self 
		assert: scatteredPackage scatteredRoots size 
		equals: 1
]
