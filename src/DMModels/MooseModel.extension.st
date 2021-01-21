Extension { #name : #MooseModel }

{ #category : #'*DMModels' }
MooseModel >> ClassNamesBlueprint [

	<navigation: 'ClassNamesBlueprint'>
	<script: 'self ClassNamesBlueprint open'>
	<tlFilter: #visuTemplate>
	^DMClassNamesblueprint new 
	model: self;
	motherRoot: Object;
	orderBySize;
	orderByColor;
	startBuilding;
	show
	
	


	
	
]

{ #category : #'*DMModels' }
MooseModel >> TLView [
	"<navigation: 'TLView'>
	<script: 'self TLView open'>
	<tlFilter: #visuTemplate>
	| conceptualModel viewModel |
	conceptualModel := DMBuilder new buildConceptualModelFrom: self.
	DMBuilder new buildRootModelsFrom: conceptualModel.
	viewModel := DMBuilder new buildViewModelFrom: conceptualModel. 
	^ (TLClassNamesBlueprint
		packageBoxes: viewModel conceptViewModels
		innerEntities: #conceptViewModels
		property: #rootname)
			innerEntitiesPopupBlock:
				[ :anEntity | 'Class ' , anEntity name , ' belongs to ' , anEntity rootname ];
			yourself"
]

{ #category : #'*DMModels' }
MooseModel >> packages [ 
	^	(self allModelPackages ifNil: self allModelNamespaces) asMooseGroup.
]

{ #category : #'*DMModels' }
MooseModel >> showClassNamesBlueprint [ 
	^DMClassNamesblueprint new 
	model: self;
	motherRoot: Object;
	orderBySize;
	orderByColor;
	startBuilding;
	show
]
