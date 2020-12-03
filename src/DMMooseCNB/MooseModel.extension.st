Extension { #name : #MooseModel }

{ #category : #'*DMMooseCNB' }
MooseModel >> AllClassNamesBlueprint [

	<navigation: 'AllClassNamesBlueprint'>
	| conceptualModel viewModel mooseView |
	conceptualModel := (DMBuilder new buildConceptualModelFrom: self).
	viewModel := DMViewModel new from: conceptualModel.
	mooseView := DMRoassalClassNamesBlueprint new visualize: viewModel.
	^mooseView

	
	


	
	
]

{ #category : #'*DMMooseCNB' }
MooseModel >> AllConceptualModel [

	<navigation: 'Conceptual Model'>
	^(DMBuilder new buildConceptualModelFrom: self)
	
	


	
	
]
