Class {
	#name : #CNBTokenStrategyTest,
	#superclass : #TestCase,
	#instVars : [
		'mooseModel',
		'cnb'
	],
	#category : #'CNBBuilder-Tests'
}

{ #category : #running }
CNBTokenStrategyTest >> setUp [

	super setUp.
	mooseModel := CNBModelGenerator projectNameMatches: 'Moose-*'.

	cnb := ClassNamesBlueprint new
		       model: mooseModel;
		       withSuffix;
		       withRoot: Object;
		       yourself
]

{ #category : #tests }
CNBTokenStrategyTest >> testBuildViewModelClasses [

	self
		assert: (CNBTokenStrategy build: cnb) viewModel classViewModels size
		equals:
		(mooseModel packages flatCollect: [ :each | each classes ]) size
]

{ #category : #tests }
CNBTokenStrategyTest >> testBuildViewModelPAckages [

	self
		assert:
		(CNBTokenStrategy build: cnb) viewModel packageViewModels size
		equals: mooseModel packages size
]

{ #category : #tests }
CNBTokenStrategyTest >> testBuildViewModelToken [

	self
		assert:
			((CNBTokenStrategy build: cnb) viewModel classViewModels collect: [
				 :each | each root tokenPosition ]) asSet
		equals: { #suffix } asSet
]
