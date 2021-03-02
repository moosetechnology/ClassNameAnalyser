Class {
	#name : #CNBPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'projectCNB',
		'projectSelector',
		'pathSelector',
		'patternsDropList',
		'packageSearch',
		'cnbSpecView',
		'hierarchies',
		'loadProjectButton',
		'prefix',
		'suffix',
		'rootSelector',
		'goDarker',
		'n',
		'nodesToBeDarker',
		'nodesToBeHighlighted',
		'reset'
	],
	#category : #CNBSpec
}

{ #category : #accessing }
CNBPresenter class >> defaultExtent [
	^ 1000@600
]

{ #category : #specs }
CNBPresenter class >> defaultSpec [ 
	^ SpBoxLayout newHorizontal
		spacing: 7;
		add: (SpBoxLayout newVertical
			spacing: 4;
			add: (SpBoxLayout newVertical
				add: 'Package name' height: self labelHeight;
				add: #projectSelector height: self buttonHeight;
				yourself) height: self labelHeight + self buttonHeight;
			add: (SpBoxLayout newVertical 
				add: 'Project path' height: self labelHeight;
				add: #pathSelector height: self buttonHeight;
				yourself) height: self labelHeight + self buttonHeight;
			add: (SpBoxLayout newVertical 
				add: 'Root class' height: self labelHeight;
				add: #rootSelector height: self buttonHeight;
				yourself) height: self labelHeight + self buttonHeight;
			add: (SpBoxLayout newVertical
				add: #suffix height: self buttonHeight;
				add: #prefix height: self buttonHeight;
				yourself) height: self buttonHeight + self buttonHeight;
			add: (SpBoxLayout newVertical 
				add: #loadProjectButton width: self buttonWidth;
				yourself) height: self buttonHeight + self buttonHeight;
			add: (SpBoxLayout newVertical 
				add: 'Pattern' height: self labelHeight;
				add: #patternsDropList height: self buttonHeight;
				yourself) height: self labelHeight + self buttonHeight;
			add: #reset height: self buttonHeight;
			add: '';
			yourself) width: 180;
		add: (SpBoxLayout newVertical
			add: (SpBoxLayout newHorizontal
				add: '';
				add: #packageSearch width: 200;
				yourself) height: self buttonHeight;
			add: #cnbSpecView;
			yourself);
		yourself.
]

{ #category : #accessing }
CNBPresenter class >> defaultTitle [
	^ 'ClassNames Blueprint'
]

{ #category : #'world menu' }
CNBPresenter class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: #ClassNamesBlueprint)
		parent: #Tools;
		action: [ self open ];
		order: 15;
		help: 'A class names blueprint presenter';
		icon: (self iconNamed: #smallPaint).
]

{ #category : #specs }
CNBPresenter class >> open [
	<example>
	self new openWithSpec.
]

{ #category : #accessing }
CNBPresenter >> allNodes [
	^ cnbSpecView canvas deepNodes
]

{ #category : #accessing }
CNBPresenter >> cnbSpecView [
	^ cnbSpecView
]

{ #category : #initialization }
CNBPresenter >> connectPresenters [
	super connectPresenters.
	loadProjectButton action: [ self onLoadProjectClicked  ]. 
	patternsDropList whenSelectedItemChangedDo: [ :aPattern | self show: aPattern ].
	reset action: [ self reset ] 	
	
]

{ #category : #highlighting }
CNBPresenter >> goDarkerFor: aPattern [
	
	| nodesWithHighlightedBorders |
	 nodesToBeDarker isNotEmpty
	ifTrue: [ self reset ]. 
	
	nodesToBeHighlighted := self nodesToHighlightFor: aPattern.
	nodesToBeHighlighted ifEmpty: [ ^ self ].
	nodesWithHighlightedBorders := nodesToBeHighlighted select: [ :each | 
		                               each hasChildren ].
	nodesToBeDarker := self allNodes difference: nodesToBeHighlighted.
		
	nodesToBeDarker do: [ :each |
		each color: each color muchDarker duller ].
	nodesWithHighlightedBorders do: [ :each |
				each border color: Color white; width: 3 ].
	cnbSpecView canvas 
		color: Color black whiter.
	
]

{ #category : #initialization }
CNBPresenter >> initialize [
	super initialize.
	nodesToBeDarker := OrderedCollection new.
]

{ #category : #initialization }
CNBPresenter >> initializePresenters [
	super initializePresenters.
	
	projectSelector := self newTextInput.
	pathSelector := self newTextInput.
	rootSelector := self newTextInput. 
	reset := self newButton label: 'Reset'. 
	prefix := self newRadioButton.
	suffix := self newRadioButton.	
	suffix associatedRadioButtons:  { prefix }.
	prefix label: 'Prefix'.
	suffix label: 'Suffix'.
	
	loadProjectButton := self newButton label: 'Load project'.
	patternsDropList := CNBSpecElementDropList new.
	
	packageSearch := self newSearchInput
		placeholder: 'Search...';
		yourself.	
	cnbSpecView := SpRoassalPresenter new.
	"hierarchies := CNBSpecHierarchies new."
]

{ #category : #initialization }
CNBPresenter >> initializeWindow: aWindowPresenter [
	super initializeWindow: aWindowPresenter.
	
	aWindowPresenter
		title: self class defaultTitle;
		initialExtent: self class defaultExtent
]

{ #category : #queries }
CNBPresenter >> lookFor: aPattern [
	" returns suffix models to be highlighted"

	^ (CNBPatternSelector of: projectCNB) 
				selectPatternOf: aPattern
	
]

{ #category : #highlighting }
CNBPresenter >> nodesToBeDarker [

	^ nodesToBeDarker
]

{ #category : #accessing }
CNBPresenter >> nodesToBeHighlighted [ 

	^ nodesToBeHighlighted 
]

{ #category : #highlighting }
CNBPresenter >> nodesToHighlightFor: aPattern [

	| suffixModelsToBeHighlighted classModelsToBeHighlighted highlightedModels |

	suffixModelsToBeHighlighted := self lookFor: aPattern.	
		
	classModelsToBeHighlighted := suffixModelsToBeHighlighted 
		                              flatCollect: [ :each | each classViewModels ].
	
	highlightedModels := (suffixModelsToBeHighlighted
			union: classModelsToBeHighlighted).
	
	^ self allNodes select: [ :each | highlightedModels includes: each model ]
	
]

{ #category : #actions }
CNBPresenter >> onLoadProjectClicked [

	projectCNB := projectSelector text ~= ''
		              ifTrue: [ 
		              CNBRoassal3Builder projectNameMatches:
			              projectSelector text ]
		              ifFalse: [ 
		              CNBRoassal3Builder importProject: pathSelector text ].
	cnbSpecView script: [ :canvas | projectCNB on: canvas ]
]

{ #category : #'as yet unclassified' }
CNBPresenter >> onPatternMouseHover [
	"| description |
	description := (nodesToBeHighlighted first) model pattern description."
	"self printOn: description"
]

{ #category : #initialization }
CNBPresenter >> patternsDropList [
	^ patternsDropList
]

{ #category : #accessing }
CNBPresenter >> projectSelector [ 
	^ projectSelector 
]

{ #category : #initialization }
CNBPresenter >> reset [

	cnbSpecView canvas color: Color white darker.
	
	self resetHighlightedNodes.
	self resetDarkerNodes.

	
	
]

{ #category : #initialization }
CNBPresenter >> resetDarkerNodes [
	| nodesToReset |
	
	nodesToReset := nodesToBeDarker copy.
	
	nodesToReset do: [ :each | 
		each model isNotNil
			ifTrue: [ each color: each model originalColor ]
			ifFalse: [ each color: each class new color darker ] 
							].
						
	nodesToBeHighlighted reset.
	
]

{ #category : #initialization }
CNBPresenter >> resetHighlightedNodes [

	| nodesWithHighlightedBorders |
		nodesWithHighlightedBorders := nodesToBeHighlighted select: [ :each | 
		                               each hasChildren ].
	nodesWithHighlightedBorders do: [ :each | 
		each border 
			color: each model class new defaultBorderColor; 
			width: each model class new defaultBorderWidth ].
	
	nodesToBeHighlighted reset
]

{ #category : #showing }
CNBPresenter >> show: aPattern [

	self goDarkerFor: aPattern.
	self onPatternMouseHover.
]
