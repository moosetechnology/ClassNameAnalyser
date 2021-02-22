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
		'boxesToBeDarker',
		'boxesToHighlight',
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
CNBPresenter >> boxesToBeDarkerFor: aPattern [


	boxesToHighlight := self boxesToHighlightFor: aPattern.
	boxesToHighlight isNotEmpty ifFalse: [ ^ self ].
	
	^ self allNodes reject: [ :each | 
		  (boxesToHighlight) 
			  includes: each model ].
	
]

{ #category : #'as yet unclassified' }
CNBPresenter >> boxesToHighlightFor: aPattern [

	| suffixModelsToBeHighlighted classModelsToBeHighlighted |
	
	suffixModelsToBeHighlighted := self lookFor: aPattern.	
		
	classModelsToBeHighlighted := suffixModelsToBeHighlighted 
		                              flatCollect: [ :each | 
		                              each classViewModels ].
	
	^ (suffixModelsToBeHighlighted
			union: classModelsToBeHighlighted).
]

{ #category : #accessing }
CNBPresenter >> cnbSpecView [
	^ cnbSpecView
]

{ #category : #initialization }
CNBPresenter >> connectPresenters [
	super connectPresenters.
	loadProjectButton action: [ self onLoadProjectClicked  ]. 
	patternsDropList whenSelectedItemChangedDo: [ :aPattern | self goDarkerFor: aPattern ].
	reset action: [ self onResetClicked ] 
	
]

{ #category : #accessing }
CNBPresenter >> goDarker [ 

	cnbSpecView canvas 
		color: Color black whiter.
		
	boxesToBeDarker do: [ :each |
		each color: each color muchDarker ].
]

{ #category : #util }
CNBPresenter >> goDarkerFor: aPattern [
	self onResetClicked.
	
	boxesToBeDarker := (self boxesToBeDarkerFor: aPattern).
	(boxesToBeDarker isCollection not or: [ boxesToBeDarker isEmpty ])
		ifTrue: [ ^ self ].
	
	self goDarker.
	
]

{ #category : #initialization }
CNBPresenter >> initialize [
	super initialize.
	boxesToBeDarker := OrderedCollection new.
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

{ #category : #'as yet unclassified' }
CNBPresenter >> lookFor: aPattern [
	" returns suffix models to be highlighted"

	^ ((CNBPatternSelector of: projectCNB) selectPatternOf: aPattern)
	
]

{ #category : #accessing }
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
CNBPresenter >> onResetClicked [
	self reset
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

	| holderComposites boxesToReset labels |
	(boxesToBeDarker isCollection not or: [ boxesToBeDarker isEmpty ]) 
		ifTrue: [ ^ self ].
	holderComposites := boxesToBeDarker select: [ :each | each class = RSComposite and:  
		                    [ each children size = 2] ].
	labels := boxesToBeDarker select: [ :each | each model isNil ].
	labels do: [ :each | each color: RSLabel new color ].
	holderComposites do: [ :each | each color: Color white darker ].
	cnbSpecView canvas color: Color white darker.
	boxesToReset := boxesToBeDarker difference: holderComposites.
	boxesToReset := boxesToReset difference: labels.
	boxesToReset do: [ :each | each color: each model originalColor ]
]
