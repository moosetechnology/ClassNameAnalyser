"
I am the presenter of the ClassNames Distribution tool.
"
Class {
	#name : #CNBPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'patternsDropList',
		'packageSearch',
		'projectView',
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
		'patternsHelpButton',
		'visualizeButton',
		'withoutInterfaces',
		'settings',
		'inspect',
		'withoutPackageName',
		'suffixSetting',
		'prefixSetting',
		'bothSetting'
	],
	#category : #CNBSpec
}

{ #category : #accessing }
CNBPresenter class >> defaultExtent [
	^ 1000@700
]

{ #category : #specs }
CNBPresenter class >> defaultSpec [ 
	^	
	SpBoxLayout newVertical 
			spacing: 1;
			add: (SpBoxLayout newHorizontal 
		add: '';
		add: #inspect;
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
						add: (SpBoxLayout newVertical 
							spacing: 2; 
							add: #addButton height: self buttonHeight;
							add: #showPackagesButton height: self buttonHeight;
							yourself) height: self buttonHeight + self buttonHeight + 2;
						add: (SpBoxLayout newVertical
							spacing: 5;
							add: #suffix height: self labelHeight;
							add: #prefix height: self labelHeight;
							add: #both height: self labelHeight;
							add: 'Root class' height: self labelHeight;
							add: #rootSelector height: self labelHeight;
							add: #withoutInterfaces height: self labelHeight + self labelHeight;
							"add: #withoutPackageName height: self labelHeight + self labelHeight;"
							add: #visualizeButton width: self buttonWidth;
							yourself) "height: self buttonHeight + self buttonHeight + self buttonHeight";
						add: (SpBoxLayout newVertical 
							add: '(Anti-)Patterns' height: self labelHeight;
							add: (SpBoxLayout newHorizontal 
								spacing: 2;
								add: #patternsDropList width: self buttonWidth + self buttonWidth ;
								add: #patternsHelpButton width: self iconWidth;
								yourself);
							yourself) height: self labelHeight + self buttonHeight;
					"add: #reset width: self buttonWidth;"
					yourself) width: 180;
					add: (SpBoxLayout newVertical
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
	
	visualizeButton action: [ self onVisualizeClicked  ]. 
	withoutInterfaces whenActivatedDo: [ self deleteInterfaces ].
	withoutInterfaces whenDeactivatedDo: [ self leaveInterfaces ].
	withoutPackageName whenActivatedDo: [ self deletePackagesNames ].
	withoutPackageName whenDeactivatedDo: [ self leavePackagesNames ].
	inspect action: [ self selectedCnB inspect ].
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

{ #category : #accessing }
CNBPresenter >> deleteInterfaces [ 
	settings do: [ :each | each deleteInterfaces ] .
]

{ #category : #'as yet unclassified' }
CNBPresenter >> deletePackagesNames [
	settings do: [ :each | each deletePackagesNames] .
]

{ #category : #'import-export' }
CNBPresenter >> exportTo: aFile [ 
	
	(CSVGenerator of: (self selectedCnB analysisDescription)) generateTo: aFile fullName 
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
	self initializeSettings.
	suffixSetting := CNBSettings new token: #suffix.
	prefixSetting :=  CNBSettings new token: #prefix.
	bothSetting := CNBSettings new token: #both.
	settings := { suffixSetting . prefixSetting . bothSetting }.
	withoutInterfaces := self newCheckBox.
	withoutInterfaces label: 'Delete Interfaces'.
	withoutPackageName := self newCheckBox.
	withoutPackageName label: 'Delete package reference'.
	inspect := self newButton label: 'Current visualization inspect'.
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
				
	addButton := self newButton label: 'Add packages'.
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
	
	visualizeButton := self newButton label: 'Visualize'.
	patternsDropList := CNBSpecElementDropList new.
	
	packageSearch := self newSearchInput
		placeholder: 'Search...';
		yourself.	
	projectView := SpRoassalPresenter new.
	

]

{ #category : #initialization }
CNBPresenter >> initializeSettings [ 
	suffixSetting := CNBSettings new.
	prefixSetting := CNBSettings new.
	bothSetting := CNBSettings new.
	settings := { suffixSetting . prefixSetting . bothSetting }.
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
CNBPresenter >> inspect [ 
	^ inspect
]

{ #category : #'as yet unclassified' }
CNBPresenter >> leaveInterfaces [ 
	settings do: [:each | each leaveInterfaces ]
]

{ #category : #'as yet unclassified' }
CNBPresenter >> leavePackagesNames [
	settings do: [ :each | each  leavePackagesNames] .
]

{ #category : #accessing }
CNBPresenter >> model [ 
	^ model
]

{ #category : #accessing }
CNBPresenter >> model: aModel [

	model := aModel 
]

{ #category : #accessing }
CNBPresenter >> noInterfaces [ 
	^ true
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
		              CNBModelGenerator packagesNamed:
			              (packages collect: #name) ]
]

{ #category : #actions }
CNBPresenter >> onBothActivated [

	self onResetClicked.
	^ bothCnb 
		 model 
			ifNotNil: [ 
			projectView script: [ :canvas | canvas @ RSDraggableCanvas .bothCnb on: canvas ] ]
 	
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
			projectView script: [ :canvas | canvas @ RSDraggableCanvas .prefixCnb on: canvas ] ]
 	
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
			projectView script: [ :canvas | canvas @ RSDraggableCanvas . suffixCnb on: canvas ] ]
 	
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

{ #category : #actions }
CNBPresenter >> onVisualizeClicked [

	| root | 
	packages ifNotEmpty: [ 
		              model := CNBModelGenerator packagesNamed:
			              (packages collect: #name) ].
	model ifNil: [ ^ self ].			
	rootSelector text ifNotEmpty: [ root := rootSelector text ].
	
	packages 
		ifNotEmpty: [ model name: packagesList filterInputPresenter text ]
		ifEmpty: [ model name: model rootFolder basenameWithoutExtension ]. 
		
	self projectModel: model with: root.

	projectView script: [ :canvas | self selectedCnB on: canvas ].
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

	settings do: [ :each | each rootClass: aRootClass ].
	(suffixCnb setting: suffixSetting; model: aMooseModel) startBuilding; buildShapes.
	(prefixCnb setting: prefixSetting; model: aMooseModel) startBuilding; buildShapes.
	(bothCnb setting: bothSetting; model: aMooseModel) startBuilding; buildShapes.
	
	"self fixColors."
	
	
	
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

{ #category : #accessing }
CNBPresenter >> selectedCnB [ 

	| activatedRadioButton |
	activatedRadioButton := self radioButtons detect: [ :each | each state ].

	^ (self projectAtRadioButton: activatedRadioButton).
]

{ #category : #actions }
CNBPresenter >> showHelp [
	| help |
	(help := self newPopover)
		relativeTo: helpButton;
		presenter: (CNBHelpPopupPresenter owner: help on: self);
		popup
]

{ #category : #actions }
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

{ #category : #actions }
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
			register: ((MPImportMSECommand forSpecContext:  self) 
						iconName: #mooseImportMse; yourself);
			register: ((CNBExportCSVCommand forSpecContext: self)
							iconName: #smallExport; yourself);
			yourself);
		yourself

]

{ #category : #actions }
CNBPresenter >> updateForNewModel: aModel [

	self model: aModel
]

{ #category : #accessing }
CNBPresenter >> withoutInterfaces [
	^ withoutInterfaces
]

{ #category : #accessing }
CNBPresenter >> withoutPackageName [
	^ withoutPackageName
]
