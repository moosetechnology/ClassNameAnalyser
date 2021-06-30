"
I represent all the data of the ClassNames Distribution from the class models, root models to the view models and nodes.
"
Class {
	#name : #ClassNamesBlueprint,
	#superclass : #Object,
	#instVars : [
		'viewModel',
		'visualizer',
		'shapes',
		'modeledShapes',
		'canvas',
		'analysisDescription'
	],
	#classInstVars : [
		'modelGenerator'
	],
	#category : #'CNB-Core'
}

{ #category : #accessing }
ClassNamesBlueprint class >> modelGenerator [ 
	^ CNBClassNamesBlueprintGenerator  
]

{ #category : #'as yet unclassified' }
ClassNamesBlueprint class >> packagesNamed: aCollection [

	^ self modelGenerator packagesNamed: aCollection
]

{ #category : #'as yet unclassified' }
ClassNamesBlueprint class >> projectNameMatches: aString [

	^ self modelGenerator projectNameMatches: aString 
]

{ #category : #accessing }
ClassNamesBlueprint >> analysisDescription [

	^ analysisDescription 
]

{ #category : #accessing }
ClassNamesBlueprint >> analysisDescription: aDescription [

	analysisDescription := aDescription 
]

{ #category : #'as yet unclassified' }
ClassNamesBlueprint >> attributeRoots [ 

	self viewModel 
		tokenModels do: [ :each | 		
				each root: 
					(CNBBuilder new 
						selectBiggestHierarchyOf: each name 
						using: self rootModels).
				each create ].
	self viewModel classViewModels do: [ :each | each create ].
	self viewModel tokenModels do: [ :each | each addPosition ]. 
	self viewModel attributeTokenModelsToRoots.
]

{ #category : #'as yet unclassified' }
ClassNamesBlueprint >> buildShapes [ 

	shapes := (visualizer buildShapesOf: self).
]

{ #category : #'as yet unclassified' }
ClassNamesBlueprint >> buildViewWith: aVisualizerClass [

	^ aVisualizerClass new 	
				model: self
]

{ #category : #accessing }
ClassNamesBlueprint >> canvas [ 
	^ canvas
]

{ #category : #accessing }
ClassNamesBlueprint >> deleteInterfaces [ 
	self setting deleteInterfaces 
]

{ #category : #initialization }
ClassNamesBlueprint >> initialize [
	super initialize.
	
	viewModel := CNBViewModel new.
	visualizer := CNBRoassal3Builder new.
	modeledShapes := OrderedCollection new. 
	canvas := RSCanvas new.


	
]

{ #category : #accessing }
ClassNamesBlueprint >> model [

	^ viewModel model
]

{ #category : #accessing }
ClassNamesBlueprint >> model: aModel [

	self viewModel model: aModel 
]

{ #category : #'as yet unclassified' }
ClassNamesBlueprint >> modeledShapes [

	modeledShapes := shapes ifNotNil: [ shapes select: [ :each | each hasModel ] ]
]

{ #category : #'instance creation' }
ClassNamesBlueprint >> on: aCanvas [

	shapes ifNil: [ self buildShapes ].
	canvas := self putElementsOn: aCanvas.
	^ canvas.
	
	
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

{ #category : #'public tree building' }
ClassNamesBlueprint >> setting: aSetting [
	viewModel setting: aSetting 
]

{ #category : #accessing }
ClassNamesBlueprint >> shapes [

	^ shapes
]

{ #category : #accessing }
ClassNamesBlueprint >> show [

	^ CNBRoassal3Builder new model: self  
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
ClassNamesBlueprint >> withRoot: aRoot [

	self setting rootClass: aRoot
]

{ #category : #'as yet unclassified' }
ClassNamesBlueprint >> withSuffix [ 
	viewModel withSuffix 
]

{ #category : #'adding/removing' }
ClassNamesBlueprint >> withoutClasses [ 

	viewModel classViewModels do:  [ :each | each border color: Color transparent ]
	
]
