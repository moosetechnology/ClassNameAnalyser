Extension { #name : #MooseModel }

{ #category : #'*DMModels' }
MooseModel >> AllClassNamesBlueprint [

	<navigation: 'AllClassNamesBlueprint'>
	| conceptualModel viewModel mooseView builder rootmodels |
	builder := DMBuilder new.
	conceptualModel := builder buildConceptualModelFrom: self.
	rootmodels := builder buildRootModelsFrom: conceptualModel.
	viewModel := builder buildViewModelFrom: conceptualModel.
	mooseView := DMRoassalClassNamesBlueprint new visualize: viewModel.
	^mooseView

	
	


	
	
]

{ #category : #'*DMModels' }
MooseModel >> AllConceptualModel [

	<navigation: 'Conceptual Model'>
	^(DMBuilder new buildConceptualModelFrom: self)
	
	


	
	
]

{ #category : #'*DMModels' }
MooseModel >> AllProjectHierarchies [
	
	<navigation: 'All Project Hierarchies'>
	| conceptualModel builder |
	builder := DMBuilder new.
	conceptualModel := builder buildConceptualModelFrom: self.
	^(builder buildRootModelsFrom: conceptualModel).
]

{ #category : #'*DMModels' }
MooseModel >> allViewModel [ 

	<navigation: 'ClassNames Blueprint ViewModel'>
	| conceptualModel viewModel builder |
	builder := DMBuilder new.
	conceptualModel := builder buildConceptualModelFrom: self.
	builder buildRootModelsFrom: conceptualModel.
	viewModel := builder buildViewModelFrom: conceptualModel.
	^viewModel 
]
