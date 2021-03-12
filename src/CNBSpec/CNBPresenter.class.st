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
		'both',
		'rootSelector',
		'goDarker',
		'nodesToBeDarker',
		'nodesToBeHighlighted',
		'reset',
		'selectedPackageBox'
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
				"add: #prefix height: self buttonHeight;"
				add: #both height: self buttonHeight;
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
	^ 'ClassNames Distribution'
]

{ #category : #'world menu' }
CNBPresenter class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: #ClassNamesDistribution)
		parent: #Tools;
		action: [ self open ];
		order: 15;
		help: 'A class names distribution presenter';
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

{ #category : #actions }
CNBPresenter >> changePackageBorderWidth: aPackageName [

	(
		(self 
			allNodes 
				select: [ :each | each hasModel ]
		)
				 	detect: [ :each | each model name = aPackageName  ]) border width: 5
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
	reset action: [ self reset ].
	packageSearch whenSubmitDo: [ :aRub | self changePackageBorderWidth: aRub text asString ].
	packageSearch whenResetDo: [ self resetPackageBoder ].
	suffix whenActivatedDo: [ self onSuffixActivated ].
	prefix whenActivatedDo: [ self onPrefixActivated ].
	both whenActivatedDo: [ self onBothActivated ].
]

{ #category : #highlighting }
CNBPresenter >> goDarkerFor: aPattern [
	| nodesWithHighlightedBorders |
	
	nodesToBeDarker isNotEmpty ifTrue: [ self reset ]. 	
	projectCNB isNotNil ifFalse: [ ^ self ].
	
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
	projectCNB := ClassNamesBlueprint new
]

{ #category : #initialization }
CNBPresenter >> initializePresenters [
	super initializePresenters.
	
	projectSelector := self newTextInput
		placeholder: 'projectNameMatches:''....-*'''.
	pathSelector := self newTextInput.
	rootSelector := self newTextInput. 
	reset := self newButton label: 'Reset'. 
	prefix := self newRadioButton.
	suffix := self newRadioButton.	
	both := self newRadioButton.
	prefix label: 'Prefix'.
	suffix label: 'Suffix'.
	both label: 'Both'.
	suffix associatedRadioButtons: { prefix . both }.
	
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
	" returns token models to be highlighted"

	^ (CNBPatternSelector 
			of: projectCNB) selectPatternOf: aPattern
	
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
	| tokenModels classModels highlightedModels |

	tokenModels 
		:= (self lookFor: aPattern) do: [ :each | each showPatternDescription ]. 

	classModels 
		:= tokenModels flatCollect: [ :each | each classViewModels ].
	
	highlightedModels 
		:= (tokenModels union: classModels).
	
	^ self allNodes select: [ :each | highlightedModels includes: each model ]
	
]

{ #category : #'as yet unclassified' }
CNBPresenter >> onBothActivated [

	projectCNB viewModel setting token: #both.
]

{ #category : #actions }
CNBPresenter >> onLoadProjectClicked [

	| mooseModel |
	mooseModel 
		:= projectSelector 
				text isNotEmpty 
					ifTrue: [ CNBMooseModelGenerator projectNameMatches: projectSelector text asString  ]
					ifFalse: [ CNBMooseModelGenerator importProject: pathSelector text asString  ].
					
	(projectCNB model: mooseModel) startBuilding.  
					
	cnbSpecView script: [ :canvas | projectCNB on: canvas ]
]

{ #category : #actions }
CNBPresenter >> onPrefixActivated [

	projectCNB viewModel setting token: #prefix.

]

{ #category : #actions }
CNBPresenter >> onSuffixActivated [

	projectCNB viewModel setting token: #suffix.
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
	
	 nodesToBeDarker 
		 do: [ :each | each 
					hasModel
						ifTrue: [ each color: each model originalColor ]
						ifFalse: [ each color: each class new color darker ] 
				]
	
]

{ #category : #initialization }
CNBPresenter >> resetHighlightedNodes [

	nodesToBeHighlighted 
				select: [ :each | each hasChildren ] 
				thenDo: [ :each | each 
								border 
									color: each model class new defaultBorderColor; 
									width: each model class new defaultBorderWidth.
								each model hidePatternDescription ].
	
]

{ #category : #initialization }
CNBPresenter >> resetPackageBoder [

	self halt.
	selectedPackageBox border width: selectedPackageBox model class new defaultBorderWidth 
]

{ #category : #showing }
CNBPresenter >> show: aPattern [

	self goDarkerFor: aPattern.
]
