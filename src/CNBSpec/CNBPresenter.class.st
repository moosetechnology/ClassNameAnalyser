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
		'selectedPackageBox',
		'prefixCnb',
		'suffixCnb',
		'bothCnb',
		'radioButtionsActions'
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
				"add: 'Root class' height: self labelHeight;
				add: #rootSelector height: self buttonHeight;"
				yourself) height: self labelHeight + self buttonHeight;
			add: (SpBoxLayout newVertical
				add: #suffix height: self buttonHeight;
				add: #prefix height: self buttonHeight;
				add: #both height: self buttonHeight;
				yourself) height: self buttonHeight + self buttonHeight + self buttonHeight;
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
			"add: (SpBoxLayout newHorizontal
				add: '';
				add: #packageSearch width: 200;
				yourself) height: self buttonHeight;"
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

{ #category : #accessing }
CNBPresenter >> bothCnb [

	^ bothCnb 
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
	suffix whenActivatedDo: [ self onSuffixActivated  ].
	prefix whenActivatedDo: [ self onPrefixActivated  ].
	both whenActivatedDo: [ self onBothActivated  ].
]

{ #category : #'as yet unclassified' }
CNBPresenter >> fixColors [

	| suffixRootModels prefixRootModels bothRootModels |
	
	suffixRootModels := suffixCnb rootModels select: [ :each | each isMultiToken ].
	prefixRootModels := prefixCnb rootModels select: [ :each | each isMultiToken ].
	bothRootModels := bothCnb rootModels select: [ :each | each isMultiToken ].
	suffixRootModels 
		do: [ :aRoot |
			prefixRootModels 
				detect: [ :each | each name = aRoot name ] 
				ifFound: [ :prefixRoot | prefixRoot changeColorTo: aRoot color ].			
			bothRootModels 
				detect: [ :each | each name = aRoot name ] 
				ifFound: [ :bothRootModel | bothRootModel changeColorTo: aRoot color. ]
			 ]
]

{ #category : #highlighting }
CNBPresenter >> goDarkerFor: aPattern [
	| nodesWithHighlightedBorders activatedRadioButton |
	
	nodesToBeDarker isNotNil ifTrue: [ self reset ]. 
	activatedRadioButton := self radioButtons detect: [ :each | each state ].	
	
	(radioButtionsActions asDictionary at: activatedRadioButton) isNotNil ifFalse: [ ^ self ].
	
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
CNBPresenter >> initializeCnbs [ 

	suffixCnb := ClassNamesBlueprint new withSuffix.
	prefixCnb := ClassNamesBlueprint new withPrefix.
	bothCnb := ClassNamesBlueprint new withBoth.
]

{ #category : #initialization }
CNBPresenter >> initializePresenters [
	super initializePresenters.
	
	self initializeCnbs. 

	projectSelector 
		:= self newTextInput placeholder: 'projectNameMatches:''....-*'''.
	reset 
		:= self newButton label: 'Reset'. 
	prefix 
		:= self newRadioButton label: 'Prefix'.
	suffix 
		:= self newRadioButton label: 'Suffix'.
	both 
		:= self newRadioButton label: 'Both'.
	radioButtionsActions := Dictionary new.
	radioButtionsActions 
		:= { prefix -> prefixCnb .
			  suffix -> suffixCnb .
			  both -> bothCnb 
			}.
	
	pathSelector := self newTextInput.
	rootSelector := self newTextInput. 
	
	suffix associatedRadioButtons: { prefix . both }.
	
	loadProjectButton := self newButton label: 'Load project'.
	patternsDropList := CNBSpecElementDropList new.
	
	packageSearch := self newSearchInput
		placeholder: 'Search...';
		yourself.	
	cnbSpecView := SpRoassalPresenter new.
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
	| activatedRadioButton |
	activatedRadioButton := self radioButtons detect: [ :each | each state ].
	^ (CNBPatternSelector 
			of: (radioButtionsActions asDictionary at: activatedRadioButton)) selectPatternOf: aPattern
	
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

	^ bothCnb 
		 model 
			ifNotNil: [ 
			cnbSpecView script: [ :canvas | bothCnb on: canvas ] ]
 	
]

{ #category : #actions }
CNBPresenter >> onLoadProjectClicked [

	| mooseModel activatedRadioButton |
	mooseModel 
		:= projectSelector 
				text isNotEmpty 
					ifTrue: [ CNBMooseModelGenerator projectNameMatches: projectSelector text asString  ]
					ifFalse: [ CNBMooseModelGenerator importProject: pathSelector text asString  ].
					
	self projectModel: mooseModel.

	activatedRadioButton := self radioButtons detect: [ :each | each state ].

	 cnbSpecView script: [ :canvas | (self projectAtRadioButton: activatedRadioButton) on: canvas ].
	
]

{ #category : #'as yet unclassified' }
CNBPresenter >> onPrefixActivated [

	^ prefixCnb
		 model 
			ifNotNil: [ 
			cnbSpecView script: [ :canvas | prefixCnb on: canvas ] ]
 	
]

{ #category : #'as yet unclassified' }
CNBPresenter >> onSuffixActivated [
	
	^ suffixCnb 
		 model 
			ifNotNil: [ 
			cnbSpecView script: [ :canvas | suffixCnb on: canvas ] ]
 	
]

{ #category : #initialization }
CNBPresenter >> patternsDropList [

	^ patternsDropList
]

{ #category : #accessing }
CNBPresenter >> prefixCnb [ 
	^ prefixCnb
]

{ #category : #accessing }
CNBPresenter >> projectAtRadioButton: aRadioButtion [

	^ radioButtionsActions asDictionary at: aRadioButtion.
	
]

{ #category : #'as yet unclassified' }
CNBPresenter >> projectModel: aMooseModel [
	
	(suffixCnb 
		model: aMooseModel) 
		startBuilding;
		buildShapes.
	(prefixCnb model: aMooseModel)
		 startBuilding;
		 buildShapes.
	(bothCnb 
		model: aMooseModel) 
		startBuilding;
		buildShapes.
	

	self fixColors.
	
	
	
]

{ #category : #accessing }
CNBPresenter >> projectSelector [ 

	^ projectSelector 
]

{ #category : #'as yet unclassified' }
CNBPresenter >> radioButtionActions [

	^ radioButtionsActions asDictionary 
]

{ #category : #'accessing - morph' }
CNBPresenter >> radioButtons [ 

	^ (suffix associatedRadioButtons union: { suffix }) 
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

{ #category : #accessing }
CNBPresenter >> suffixCnb [ 
	^ suffixCnb 
]
