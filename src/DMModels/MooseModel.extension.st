Extension { #name : #MooseModel }

{ #category : #'*DMModels' }
MooseModel >> AllClassNamesBlueprint [

	<navigation: 'AllClassNamesBlueprint'>
	| conceptualModel viewModel mooseView |
	conceptualModel := self buildConceptualModel.
	viewModel := DMViewModel new from: conceptualModel.
	mooseView := DMRoassalClassNamesBlueprint new visualize: viewModel.
	^mooseView

	
	
]

{ #category : #'*DMModels' }
MooseModel >> buildConceptualModel [
	^ DMBuilder buildConceptualModelFrom: self

]

{ #category : #'*DMModels' }
MooseModel >> conceptualModel [

	<navigation: 'CNB Conceptual Model'>
	^self buildConceptualModel.
	
]

{ #category : #'*DMModels' }
MooseModel >> viewModel [ 

	<navigation: 'CNB View Model'>
	| conceptualModel viewModel |
	conceptualModel := self buildConceptualModel.
	viewModel := DMViewModel new from: conceptualModel.
	^viewModel
]
