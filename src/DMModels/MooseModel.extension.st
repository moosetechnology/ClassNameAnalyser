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
MooseModel >> ClassNamesBlueprintViewModel [

	<navigation: 'ClassNamesBlueprint ViewModel'>
	<script: 'self ClassNamesBlueprintViewModel open'>
	<tlFilter: #visuTemplate>
	| cnb |
	cnb := DMClassNamesblueprint new 
	model: self;
	motherRoot: Object;
	orderBySize;
	orderByColor;
	startBuilding.
	^cnb viewModel 
]

{ #category : #'*DMModels' }
MooseModel >> packages [ 
	^	(self allModelPackages ifNil: self allModelNamespaces) asMooseGroup.
]

{ #category : #'*DMModels' }
MooseModel >> showClassNamesBlueprintAccordingto: aMotherClass [
	^DMClassNamesblueprint new 
	model: self;
	motherRoot: aMotherClass;
	orderBySize;
	orderByColor;
	startBuilding;
	show
]
