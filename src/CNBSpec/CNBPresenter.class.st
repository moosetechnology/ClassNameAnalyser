Class {
	#name : #CNBPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'patternsDropList',
		'packageSearch',
		'projectView',
		'analyseButton',
		'prefix',
		'suffix',
		'both',
		'rootSelector',
		'reset',
		'selectedPackageBox',
		'prefixCnb',
		'suffixCnb',
		'bothCnb',
		'radioButtionsActions',
		'packagesList',
		'addButton',
		'showPackagesButton',
		'packages',
		'packagesListPresenter',
		'allListItems',
		'highlighter',
		'mooseImporterForm',
		'model',
		'helpButton',
		'instructionsButton',
		'patternsHelpButton'
	],
	#category : #CNBSpec
}

{ #category : #accessing }
CNBPresenter class >> defaultExtent [
	^ 1000@600
]

{ #category : #specs }
CNBPresenter class >> defaultSpec [ 
	^
	
	SpBoxLayout newVertical 
			spacing: 1;
			add: (SpBoxLayout newHorizontal 
		add: '';
		add: #instructionsButton width: self buttonWidth;
		add: #helpButton width: self iconWidth;
		yourself) height: self iconWidth;
		add: (SpBoxLayout newHorizontal
					spacing: 7;
					add: (SpBoxLayout newVertical
						spacing: 2;
						add: (SpBoxLayout newVertical
							add: #packagesList;
							yourself) height: 250;
						add: (SpBoxLayout newHorizontal 
							add: #showPackagesButton height: self buttonHeight;
							add: #addButton height: self buttonHeight;
							yourself) height: self buttonHeight;
						add: (SpBoxLayout newVertical 
							add: 'Root class' height: self labelHeight;
							add: #rootSelector height: self buttonHeight;
							yourself) "height: self labelHeight + self buttonHeight";
						add: (SpBoxLayout newVertical
							add: #suffix height: self labelHeight;
							add: #prefix height: self labelHeight;
							add: #both height: self labelHeight;
							add: #analyseButton width: self buttonWidth;
							yourself) "height: self buttonHeight + self buttonHeight + self buttonHeight";
						add: (SpBoxLayout newVertical 
							add: 'Anti-Patterns' height: self labelHeight;
							add: (SpBoxLayout newHorizontal 
								add: #patternsDropList height: self buttonHeight;
								add: #patternsHelpButton width: self iconWidth;
								yourself);
							yourself) height: self labelHeight + self buttonHeight;
					add: #reset height: self buttonHeight;
					yourself) width: 180;
					add: (SpBoxLayout newVertical
							"add: (SpBoxLayout newHorizontal
							add: '';
							add: #packageSearch width: 200;
							yourself) height: self buttonHeight;"
							add: #projectView;
							yourself);
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

	^ projectView canvas deepNodes
]

{ #category : #accessing }
CNBPresenter >> bothCnb [

	^ bothCnb 
]

{ #category : #initialization }
CNBPresenter >> buildToolbar [ 

	^ self toolbarActions 
		asToolbarPresenterWith: [ :presenter | 
			presenter 
				displayMode: SpToolbarDisplayMode modeIconAndLabel;
				addStyle: 'stToolbar' ]
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

{ #category : #initialization }
CNBPresenter >> connectPresenters [
	super connectPresenters.
	
	analyseButton action: [ self onAnalyseClicked  ]. 
	addButton action: [ self onAddClicked ].
	patternsDropList whenSelectedItemChangedDo: [ :aPattern | self showNodesAttributedTo: aPattern ].
	reset action: [ self onResetClicked ].
	packageSearch whenSubmitDo: [ :aRub | self changePackageBorderWidth: aRub text asString ].
	packageSearch whenResetDo: [ self resetPackageBoder ].
	suffix whenActivatedDo: [ self onSuffixActivated  ].
	prefix whenActivatedDo: [ self onPrefixActivated  ].
	both whenActivatedDo: [ self onBothActivated  ].
	showPackagesButton action: [ self onShowClicked ].
	packagesListPresenter updateButton action: [ self onUpdateClicked  ].
	packagesListPresenter deleteAllButton action: [ self onDeleteAllClicked ].
]

{ #category : #actions }
CNBPresenter >> fixColors [

	| suffixRootModels prefixRootModels bothRootModels |
	
	suffixRootModels := suffixCnb rootModels select: [ :each | each isMultiToken ].
	prefixRootModels := prefixCnb rootModels select: [ :each | each isMultiToken ].
	bothRootModels := bothCnb rootModels select: [ :each | each isMultiToken ].
	suffixRootModels 
		do: [ :aRoot |
			prefixRootModels 
				detect: [ :each | each model = aRoot model ] 
				ifFound: [ :prefixRoot | prefixRoot changeColorTo: aRoot color ].			
			bothRootModels 
				detect: [ :each | each model = aRoot model ] 
				ifFound: [ :bothRootModel | bothRootModel changeColorTo: aRoot color. ]
			 ]
]

{ #category : #accessing }
CNBPresenter >> help [ 
	^ ' The instructions of the tool'
]

{ #category : #accessing }
CNBPresenter >> helpButton [ 
	^ helpButton
]

{ #category : #initialization }
CNBPresenter >> initializeCnbs [ 

	suffixCnb := ClassNamesBlueprint new withSuffix.
	prefixCnb := ClassNamesBlueprint new withPrefix.
	bothCnb := ClassNamesBlueprint new withBoth.
]

{ #category : #initialization }
CNBPresenter >> initializeHelpButton [

	helpButton := self newButton 
		iconName: #help;
		help: 'About the tool';
		action: [ self showHelp ];
		yourself
	
]

{ #category : #initialization }
CNBPresenter >> initializeInstructionsButton [ 
	
	instructionsButton 
		:= self newButton 
				label: 'Instructions';
				help: 'Instructions of the tool';
				action: [ self showInstructions ]
			
]

{ #category : #initialization }
CNBPresenter >> initializePatternsHelpButton [

	patternsHelpButton := self newButton 
		iconName: #help;
		help: 'About the patterns';
		action: [ self showPatternsHelp ];
		yourself
	
]

{ #category : #initialization }
CNBPresenter >> initializePresenters [
	super initializePresenters.
	
	self initializeCnbs. 
	self initializeHelpButton.
	self initializeInstructionsButton.
	self initializePatternsHelpButton.
	packages := OrderedCollection new.
	highlighter := CNBSingletonHighlighter instance.
	allListItems := RBBrowserEnvironment default packages asArray sorted: [ :a : b | a name < b name ].
	packagesListPresenter := CNBPackagesListPresenter new owner: self.
	packagesList  
		:= SpFilteringSelectableListPresenter new owner: self;
			items: allListItems;
			displayIcon: [ :e | self iconNamed: #package ];
			display: [ :package | package name ];
			filterInputPresenter;
			yourself.
		packagesList 
			listPresenter 
				bindKeyCombination: $a meta 
				toAction: [ packagesList selectItems: packagesList items ].
				
	addButton := self newButton label: 'Add'.
	showPackagesButton := self newButton label: 'Show Packages'.
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
			
	rootSelector := self newTextInput. 
	
	suffix associatedRadioButtons: { prefix . both }.
	
	analyseButton := self newButton label: 'Analyse'.
	patternsDropList := CNBSpecElementDropList new.
	
	packageSearch := self newSearchInput
		placeholder: 'Search...';
		yourself.	
	projectView := SpRoassalPresenter new.
	

]

{ #category : #initialization }
CNBPresenter >> initializeWindow: aWindowPresenter [
	super initializeWindow: aWindowPresenter.
	
	aWindowPresenter
		title: self class defaultTitle;
		initialExtent: self class defaultExtent;
		toolbar: self buildToolbar
]

{ #category : #accessing }
CNBPresenter >> model [ 
	^ model
]

{ #category : #accessing }
CNBPresenter >> model: aModel [

	model := aModel 
]

{ #category : #actions }
CNBPresenter >> onAddClicked [

	packagesList selectedItems
		ifEmpty: [ ^ self ];
		do: [ :arg1 | packages addIfNotPresent: arg1 ].
		
	packagesList items: (allListItems difference: packages).
	packagesList listPresenter refresh.

	packagesListPresenter items: packages.
	packagesListPresenter packagesList listPresenter refresh.
	
	model := packages isNotEmpty ifTrue: [ 
		              CNBMooseModelGenerator packagesNamed:
			              (packages collect: #name) ]
]

{ #category : #actions }
CNBPresenter >> onAnalyseClicked [

	| activatedRadioButton root selectedCnb | 
	packages ifNotEmpty: [ 
		              model := CNBMooseModelGenerator packagesNamed:
			              (packages collect: #name) ].
	model ifNil: [ ^ self ].			

	activatedRadioButton := self radioButtons detect: [ :each | each state ].
	
	rootSelector text ifNotEmpty: [ root := rootSelector text ]. 
	self projectModel: model with: root.
	
	selectedCnb := (self projectAtRadioButton: activatedRadioButton).
	
	projectView script: [ :canvas | selectedCnb on: canvas ].
]

{ #category : #actions }
CNBPresenter >> onBothActivated [

	self onResetClicked.
	^ bothCnb 
		 model 
			ifNotNil: [ 
			projectView script: [ :canvas | bothCnb on: canvas ] ]
 	
]

{ #category : #actions }
CNBPresenter >> onDeleteAllClicked [

	packages removeAll.
	packagesListPresenter packagesList items: #().
	packagesListPresenter packagesList listPresenter refresh.

	packagesList items: allListItems. 
	packagesList selectItems: #().

	packagesList listPresenter refresh.	

	
	
]

{ #category : #actions }
CNBPresenter >> onPrefixActivated [

	self onResetClicked.
	^ prefixCnb
		 model 
			ifNotNil: [ 
			projectView script: [ :canvas | prefixCnb on: canvas ] ]
 	
]

{ #category : #actions }
CNBPresenter >> onResetClicked [

	highlighter property: nil.
	highlighter reset.
	projectView canvas color: Color white darker.	
	

	
	
]

{ #category : #actions }
CNBPresenter >> onShowClicked [ 

	^ (packagesListPresenter items: packages) openWithSpec
]

{ #category : #actions }
CNBPresenter >> onSuffixActivated [

	self onResetClicked.
	^ suffixCnb 
		 model 
			ifNotNil: [ 
			projectView script: [ :canvas | suffixCnb on: canvas ] ]
 	
]

{ #category : #actions }
CNBPresenter >> onUpdateClicked [ 

	| listItems |	
	
	packages removeAll.
	packages addAll: (packagesListPresenter packagesList selectedItems).
	packagesListPresenter packagesList items: packages.
	packagesListPresenter packagesList listPresenter refresh.
	
	listItems := (allListItems difference: packages).

	packagesList items: listItems. 
	packagesList selectItems: #().

	packagesList listPresenter refresh.	

	
	
	
]

{ #category : #accessing }
CNBPresenter >> packages [ 

	^ packages
]

{ #category : #accessing }
CNBPresenter >> packagesList [ 

	^ packagesList 
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

{ #category : #building }
CNBPresenter >> projectModel: aMooseModel with: aRootClass [
	
	(suffixCnb model: aMooseModel; withRoot: aRootClass) startBuilding; buildShapes.
	(prefixCnb model: aMooseModel;withRoot: aRootClass) startBuilding; buildShapes.
	(bothCnb model: aMooseModel; withRoot: aRootClass) startBuilding; buildShapes.
	
	self fixColors.
	
	
	
]

{ #category : #accessing }
CNBPresenter >> projectView [

	^ projectView
]

{ #category : #actions }
CNBPresenter >> radioButtionActions [

	^ radioButtionsActions asDictionary 
]

{ #category : #'accessing - morph' }
CNBPresenter >> radioButtons [ 

	^ (suffix associatedRadioButtons union: { suffix }) 
]

{ #category : #initialization }
CNBPresenter >> resetPackageBoder [

	self halt.
	selectedPackageBox border width: selectedPackageBox model class new defaultBorderWidth 
]

{ #category : #selection }
CNBPresenter >> selectAll [

	packagesList listPresenter items selectAll
]

{ #category : #actions }
CNBPresenter >> showHelp [
	| help |
	(help := self newPopover)
		relativeTo: helpButton;
		presenter: (CNBHelpPopupPresenter owner: help on: self);
		popup
]

{ #category : #'as yet unclassified' }
CNBPresenter >> showInstructions [

	| instructions |
	(instructions := self newPopover) 
			relativeTo: instructionsButton;
			presenter: (CNBInstructionsPopupPresenter owner: instructions on: self);
			popup
]

{ #category : #actions }
CNBPresenter >> showNodesAttributedTo: anObject [

	highlighter highlight: self allNodes accordingTo: anObject.
	highlighter nodesToBeHighlighted ifEmpty: [ ^ self onResetClicked ].

	projectView canvas color: Color black whiter.
]

{ #category : #'as yet unclassified' }
CNBPresenter >> showPatternsHelp [

	| patterns |
	(patterns := self newPopover) 
			relativeTo: patternsHelpButton;
			presenter: (CNBPatternsPopupPresenter owner: patterns on: self);
			popup
]

{ #category : #accessing }
CNBPresenter >> suffixCnb [ 

	^ suffixCnb 
]

{ #category : #building }
CNBPresenter >> toolbarActions [ 

	^ CmCommandGroup forSpec
		register: (CmCommandGroup forSpec
			register: (MPImportMSECommand forSpecContext: self);
			"register: (CNBSaveCommand forSpecContext: self);"
			yourself);
		yourself

]

{ #category : #actions }
CNBPresenter >> updateForNewModel: aModel [

	self model: aModel
]
