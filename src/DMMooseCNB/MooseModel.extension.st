Extension { #name : #MooseModel }

{ #category : #'*DMMooseCNB' }
MooseModel >> AllClassNamesBlueprint [

	<navigation: 'AllClassNamesBlueprint'>
	| conceptualModel viewModel mooseView |
	conceptualModel := (DMBuilder buildConceptualModelFrom: self).
	viewModel := DMViewModel new from: conceptualModel.
	mooseView := DMRoassalClassNamesBlueprint new visualize: viewModel.
	^mooseView

	
	


	
	
]
