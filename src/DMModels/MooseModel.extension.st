Extension { #name : #MooseModel }

{ #category : #'*DMModels' }
MooseModel >> ClassNamesBlueprint [

	^ DMClassNamesblueprint new 
	model: self;
	motherRoot: Object;
	orderBySize;
	orderByColor;
	startBuilding.
	
	


	
	
]

{ #category : #'*DMModels' }
MooseModel >> ClassNamesBlueprintAccordingTo: aClass [

	^ DMClassNamesblueprint new 
	model: self;
	motherRoot: aClass;
	orderBySize;
	orderByColor;
	startBuilding.
	
	


	
	
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
	^	(self allModelPackages) ifNil: (self allModelNamespaces) asMooseGroup.
	"^ (self allModelNamespaces) ifEmpty: self allModelPackages"
]

{ #category : #'*DMModels' }
MooseModel >> showCNBViewModelAccordingTo: aMotherClass [
	| cnb |
	cnb := DMClassNamesblueprint new 
	model: self;
	motherRoot: aMotherClass;
	orderBySize;
	orderByColor;
	startBuilding.
	^cnb viewModel 
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
