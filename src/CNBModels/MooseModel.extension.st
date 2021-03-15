Extension { #name : #MooseModel }

{ #category : #'*CNBModels' }
MooseModel >> ClassNamesBlueprint [ 

	<navigation: 'ClassNamesBlueprint'>
	<script: 'self ClassNamesBlueprint open'>
	<tlFilter: #visuTemplate>
	^ self defaultClassNamesBlueprint show
]

{ #category : #'*CNBModels' }
MooseModel >> classNamesBlueprintAccordingTo: setting [

	| cnb |
	cnb := ClassNamesBlueprint new model: self.
	cnb viewModel setting: setting;
	startBuilding.
	
	


	
	
]

{ #category : #'*CNBModels' }
MooseModel >> defaultClassNamesBlueprint [

	^ ClassNamesBlueprint new 
	model: self;
	startBuilding.
	
	


	
	
]

{ #category : #'*CNBModels' }
MooseModel >> packages [ 

	^	((self allModelPackages) ifNil: (self allModelNamespaces))
	ifEmpty: self allModelNamespaces
]
