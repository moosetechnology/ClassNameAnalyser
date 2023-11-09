Class {
	#name : #PackageViewModelTests,
	#superclass : #TestCase,
	#instVars : [
		'scatteredPackage',
		'classNamesDistribution'
	],
	#category : #'CNBBuilder-Tests'
}

{ #category : #running }
PackageViewModelTests >> setUp [

	super setUp.

	classNamesDistribution := (ClassNamesBlueprint projectNameMatches:
		                           'Moose-TestResources-LAN') withSuffix
		                          startBuilding.

	scatteredPackage := classNamesDistribution viewModel
		                    packageViewModels anyOne
]

{ #category : #tests }
PackageViewModelTests >> testHasScatteredVocabularyInside [

	self assert:
		classNamesDistribution viewModel packageViewModels anyOne
			hasScatteredVocabularyInside
]

{ #category : #tests }
PackageViewModelTests >> testScatteredPackages [

	self
		assert: classNamesDistribution viewModel scatteredPackages size
		equals: 1
]

{ #category : #tests }
PackageViewModelTests >> testScatteredRoots [

	self
		assert: classNamesDistribution viewModel packageViewModels anyOne
				scatteredRoots size
		equals: 1
]
