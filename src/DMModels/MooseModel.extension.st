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
MooseModel >> TLView [
	<navigation: 'TLView'>
	<script: 'self TLView open'>
	<tlFilter: #visuTemplate>
	| conceptualModel viewModel |
	conceptualModel := DMBuilder new buildConceptualModelFrom: self.
	DMBuilder new buildRootModelsFrom: conceptualModel.
	viewModel := DMBuilder new buildViewModelFrom: conceptualModel.
	^ (TLClassNamesBlueprint
		packageBoxes: viewModel models
		innerEntities: #models
		property: #rootname)
			innerEntitiesPopupBlock:
				[ :anEntity | 'Class ' , anEntity name , ' belongs to ' , anEntity rootname ];
			yourself
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

{ #category : #'*DMModels' }
MooseModel >> conceptualmodel [
	^ DMConceptualModel new
		name: self name;
		packagemodels:
			((self allModelNamespaces ifEmpty: self allModelPackages) asMooseGroup
				collect: [ :eachPackage | 
					DMPackageModel new
						name: eachPackage name;
						classmodels: (eachPackage classes collect: [ :each | each classmodel ]) ])
]
