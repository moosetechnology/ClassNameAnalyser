Class {
	#name : #ClassNamesBlueprint,
	#superclass : #Object,
	#instVars : [
		'viewModel',
		'visualizer',
		'shapes'
	],
	#category : #'CNB-Core'
}

{ #category : #'as yet unclassified' }
ClassNamesBlueprint >> attributeRoots [ 


	self viewModel 
		tokenModels
			 do: [ :each | 
				each root: (CNBBuilder new selectBiggestHierarchyOf: each name using: self rootModels).
				each create ].
	self viewModel 
		classViewModels do: [ :each | each create  ].
	self viewModel attributeTokenModelsToRoots.
]

{ #category : #'as yet unclassified' }
ClassNamesBlueprint >> buildShapes [ 

	shapes := (visualizer buildShapesOf: self) 
]

{ #category : #'as yet unclassified' }
ClassNamesBlueprint >> buildViewWith: aVisualizerClass [

	^ aVisualizerClass new 	
				model: self
]

{ #category : #description }
ClassNamesBlueprint >> description [
| thePackageModels cnbDescription |
	cnbDescription := CNBDescriptionModel new.
	thePackageModels := (CNBBuilder doPackageModelsOf: self viewModel).
	cnbDescription 
		name: self model name;
		packageModels: thePackageModels;
		rootClass: self rootClass;
		model: self model;
		rootModels: (CNBBuilder doRootsOf: (thePackageModels flatCollect: #classModels)).
		cnbDescription create.
		^cnbDescription 
]

{ #category : #initialization }
ClassNamesBlueprint >> initialize [
	super initialize.
	
	viewModel := CNBViewModel new.
	visualizer := CNBRoassal3Builder new.

]

{ #category : #accessing }
ClassNamesBlueprint >> model [

	^ viewModel model
]

{ #category : #accessing }
ClassNamesBlueprint >> model: aModel [

	self viewModel model: aModel 
]

{ #category : #'instance creation' }
ClassNamesBlueprint >> on: aCanvas [

	shapes ifNil: [ self buildShapes ].
	
	^ self putElementsOn: aCanvas
	
]

{ #category : #'as yet unclassified' }
ClassNamesBlueprint >> putElementsOn: aCanvas [ 

	aCanvas addAll: (shapes).
	RSFlowLayout on: aCanvas nodes.
	aCanvas @ RSCanvasController.
	aCanvas color: aCanvas color darker.
	^ aCanvas
]

{ #category : #accessing }
ClassNamesBlueprint >> rootModels [ 

	^ viewModel rootModels
]

{ #category : #accessing }
ClassNamesBlueprint >> setting [

	^ viewModel setting
]

{ #category : #accessing }
ClassNamesBlueprint >> shapes [

	^ shapes
]

{ #category : #accessing }
ClassNamesBlueprint >> show [

	^ visualizer 
			roassal3VisualizerShow: (CNBRoassal3Builder new model: self ) 
]

{ #category : #operations }
ClassNamesBlueprint >> startBuilding [
	
	 ^ (self viewModel setting token = #both)
			ifTrue: [ CNBBothTokensStrategy build: self ]
			ifFalse: [ CNBTokenStrategy build: self ]. 
	
	
]

{ #category : #accessing }
ClassNamesBlueprint >> token: aSymbol [

	viewModel setting token: aSymbol
]

{ #category : #accessing }
ClassNamesBlueprint >> viewModel [

	^ viewModel 
]

{ #category : #accessing }
ClassNamesBlueprint >> viewModel: aViewModel [

	viewModel := aViewModel 
]

{ #category : #'as yet unclassified' }
ClassNamesBlueprint >> withBoth [
	self setting token: #both
]

{ #category : #'as yet unclassified' }
ClassNamesBlueprint >> withPrefix [ 
	viewModel withPrefix 
]

{ #category : #'as yet unclassified' }
ClassNamesBlueprint >> withSuffix [ 
	viewModel withSuffix 
]

{ #category : #'adding/removing' }
ClassNamesBlueprint >> withoutClasses [ 

	viewModel classViewModels do:  [ :each | each border color: Color transparent ]
	
]
