Class {
	#name : #CNBTokenStrategyTest,
	#superclass : #TestCase,
	#category : #CNBModels
}

{ #category : #tests }
CNBTokenStrategyTest >> testBuildViewModelClasses [
	| mooseModel setting viewModel |
	
	mooseModel := CNBMooseModelGenerator projectNameMatches: 'moose-*'.
	setting := CNBSettings new rootClass: Object; token: #suffix.
	viewModel := CNBViewModel new model: mooseModel; setting: setting.
	
		self 
			assert: (CNBTokenStrategy build: viewModel) classViewModels size 
			equals: (mooseModel packages flatCollect: [ :each | each classes ]) size
	 
]

{ #category : #tests }
CNBTokenStrategyTest >> testBuildViewModelPAckages [
	| mooseModel setting viewModel |
	
	mooseModel := CNBMooseModelGenerator projectNameMatches: 'moose-*'.
	setting := CNBSettings new rootClass: Object; token: #suffix.
	viewModel := CNBViewModel new model: mooseModel; setting: setting.
	
		self 
			assert: (CNBTokenStrategy build: viewModel) packageViewModels size 
			equals: mooseModel packages size
	 
]

{ #category : #tests }
CNBTokenStrategyTest >> testBuildViewModelToken [
	| mooseModel setting viewModel |
	
	mooseModel := CNBMooseModelGenerator projectNameMatches: 'moose-*'.
	setting := CNBSettings new rootClass: Object; token: #suffix.
	viewModel := CNBViewModel new model: mooseModel; setting: setting.
	
		self 
			assert: ((CNBTokenStrategy build: viewModel) classViewModels collect: [ :each | each root tokenPosition ]) asSet
			equals: { #suffix } asSet
	 
]
