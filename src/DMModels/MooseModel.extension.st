Extension { #name : #MooseModel }

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
	| viewModel |
	viewModel := DMViewModel new from: self conceptualModel.
	^viewModel
]
