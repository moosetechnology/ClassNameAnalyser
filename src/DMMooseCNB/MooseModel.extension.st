Extension { #name : #MooseModel }

{ #category : #'*DMMooseCNB' }
MooseModel >> AllClassNamesBlueprint [

	<navigation: 'AllClassNamesBlueprint'>
	| conceptualModel viewModel mooseView |
	conceptualModel := self buildConceptualModel.
	viewModel := DMViewModel new from: conceptualModel.
	mooseView := DMRoassalClassNamesBlueprint new visualize: viewModel.
	^mooseView

	
	
]
