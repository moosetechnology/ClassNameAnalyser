Extension { #name : #TLDemos }

{ #category : #'*DMBuilder-Tests' }
TLDemos class >> exampleClassNamesBlueprint [
  <script: 'self exampleClassNamesBlueprint open'>
	<tlFilter: #visuTemplate>
	| mooseSample mooseModel conceptualModel viewmodel builder |
	mooseSample := MooseSampleData new.
	builder := DMBuilder new.
	mooseModel := MooseModel new
		importFromMSEStream: mooseSample modelVersion3 readStream.
	conceptualModel := builder buildConceptualModelFrom: mooseModel.
	builder buildRootModelsFrom: conceptualModel.
	viewmodel := DMBuilder new buildViewModelFrom: conceptualModel.
	^ (TLClassNamesBlueprint
		packageBoxes: viewmodel packageModels
		innerEntities: #packageModels
		property: #rootname)
		innerEntitiesPopupBlock:
				[ :anEntity | 'Class ' , anEntity name , ' belongs to ' , anEntity rootname ];
			yourself
]
