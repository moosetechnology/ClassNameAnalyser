Extension { #name : #MooseModel }

{ #category : #'*DMModels' }
MooseModel >> ClassNamesBlueprint [ 

	<navigation: 'ClassNamesBlueprint'>
	<script: 'self ClassNamesBlueprint open'>
	<tlFilter: #visuTemplate>
	^ self defaultClassNamesBlueprint show
]

{ #category : #'*DMModels' }
MooseModel >> ClassNamesBlueprintViewModel [

	<navigation: 'ClassNamesBlueprint ViewModel'>
	<script: 'self ClassNamesBlueprintViewModel open'>
	<tlFilter: #visuTemplate>
	^ self defaultClassNamesBlueprint viewModel 
]

{ #category : #'*DMModels' }
MooseModel >> classNamesBlueprintAccordingTo: aClass [

	^ DMClassNamesblueprint new 
	model: self;
	motherRoot: aClass;
	orderBySize;
	orderByColor;
	startBuilding.
	
	


	
	
]

{ #category : #'*DMModels' }
MooseModel >> defaultClassNamesBlueprint [

	^ DMClassNamesblueprint new 
	model: self;
	motherRoot: Object;
	orderBySize;
	orderByColor;
	startBuilding.
	
	


	
	
]

{ #category : #'*DMModels' }
MooseModel >> defaultCnbViewModelAccordingTo: aMotherClass [
	^self defaultClassNamesBlueprint viewModel
]

{ #category : #'*DMModels' }
MooseModel >> packages [ 
	^	((self allModelPackages) ifNil: (self allModelNamespaces))
	ifEmpty: self allModelNamespaces
]
