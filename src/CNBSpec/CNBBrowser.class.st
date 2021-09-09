"
I am the presenter of the ClassNames Distribution tool.
"
Class {
	#name : #CNBBrowser,
	#superclass : #MiAbstractBrowser,
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
		'bothSetting',
		'instructions',
		'fullInstructionsButton',
		'parametersLabel',
		'exportButton',
		'fullInstructionsPresenter'
	],
	#category : #CNBSpec
}

{ #category : #specs }
CNBBrowser class >> defaultExtent [ 

	^ 1000@600
]

{ #category : #specs }
CNBBrowser class >> defaultSpec [

	| spacing parametersLayout buttonsLayout patternsLayout viewLayout defaultWidth visualizeSpacing borderWidth optionsLayout |
	 spacing := 7.
    visualizeSpacing := 30.
    defaultWidth := 180.
    borderWidth := 5.
    
    parametersLayout := SpBoxLayout newVertical
        spacing: spacing;
        borderWidth: borderWidth;
        add: #parametersLabel expand: false;
        add: #suffix expand: false;
        add: #prefix expand: false;
        add: #both expand: false;
        add: #rootSelector expand: false;
        add: #withoutInterfaces expand: false;
        yourself.

    buttonsLayout := SpBoxLayout newVertical
        add: #visualizeButton expand: false;
        yourself.
    
    patternsLayout := SpBoxLayout newVertical
        spacing: spacing;
        add: #visualizeButton;
        add: (SpBoxLayout newHorizontal
                add: #patternsDropList;
                add: #patternsHelpButton expand: false;
                yourself)
            expand: false;
        yourself.

    viewLayout := SpBoxLayout newVertical
        spacing: spacing;
         add: #projectView;
        yourself.
        
    optionsLayout := SpBoxLayout newVertical
        spacing: spacing;
        add: #fullInstructionsButton;
        add: (SpBoxLayout newHorizontal
            add: #exportButton width: (defaultWidth / 2) asInteger;
            add: #inspect width: (defaultWidth / 2) asInteger;
            yourself);
        yourself.
        
    ^ super defaultSpec
			spacing: spacing;
          add: (SpBoxLayout newHorizontal
                spacing: spacing;
                add: (SpBoxLayout newVertical
                    spacing: spacing;
                    add: optionsLayout expand: false;
                    add: parametersLayout expand: false;
                    add: patternsLayout expand: false;
                    yourself)
                   width: defaultWidth;
            add: viewLayout;
            yourself);
        yourself
]

{ #category : #accessing }
CNBBrowser class >> defaultTitle [
	^ 'ClassNames Distribution'
]

{ #category : #'world menu' }
CNBBrowser class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: #ClassNamesDistribution)
		parent: #Tools;
		action: [ self open ];
		order: 15;
		help: 'A class names distribution presenter';
		icon: (self iconNamed: #smallPaint).
]

{ #category : #specs }
CNBBrowser class >> open [

	<example>
	super open
]

{ #category : #visiting }
CNBBrowser >> accept: anObject [

	^ anObject isMooseModel
]

{ #category : #accessing }
CNBBrowser >> allNodes [

	^ projectView canvas deepNodes
]

{ #category : #accessing }
CNBBrowser >> bothCnb [

	^ bothCnb 
]

{ #category : #actions }
CNBBrowser >> changePackageBorderWidth: aPackageName [

	(
		(self 
			allNodes 
				select: [ :each | each hasModel ]
			)
				 	detect: [ :each | each model name = aPackageName  ]) border width: 5
]

{ #category : #initialization }
CNBBrowser >> connectPresenters [
	super connectPresenters.
	
	visualizeButton action: [ self onVisualizeClicked  ]. 
	withoutInterfaces whenActivatedDo: [ self deleteInterfaces ].
	withoutInterfaces whenDeactivatedDo: [ self leaveInterfaces ].
	withoutPackageName whenActivatedDo: [ self deletePackagesNames ].
	withoutPackageName whenDeactivatedDo: [ self leavePackagesNames ].
	inspect action: [ self selectedCnB inspect ].
	packageSearch whenSubmitDo: [ :aRub | self changePackageBorderWidth: aRub text asString ].
	packageSearch whenResetDo: [ self resetPackageBoder ].
	suffix whenActivatedDo: [ self onSuffixActivated  ].
	prefix whenActivatedDo: [ self onPrefixActivated  ].
	both whenActivatedDo: [ self onBothActivated  ].
]

{ #category : #accessing }
CNBBrowser >> deleteInterfaces [ 
	settings do: [ :each | each deleteInterfaces ] .
]

{ #category : #'as yet unclassified' }
CNBBrowser >> deletePackagesNames [
	settings do: [ :each | each deletePackagesNames] .
]

{ #category : #accessing }
CNBBrowser >> exportButton [
	^ exportButton
]

{ #category : #'import-export' }
CNBBrowser >> exportTo: aFile [ 
	
	(CSVGenerator of: (self selectedCnB analysisDescription)) generateTo: aFile fullName 
]

{ #category : #actions }
CNBBrowser >> fixColors [

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

{ #category : #actions }
CNBBrowser >> followAction [

	| root |
	toSelect ifNil: [ ^ self ].
	model := toSelect.
	rootSelector text ifNotEmpty: [ root := rootSelector text ].

	"model name: model rootFolder basenameWithoutExtension."

	self projectModel: toSelect with: root.

	projectView script: [ :canvas | self selectedCnB on: canvas ]
]

{ #category : #accessing }
CNBBrowser >> fullInstructionsButton [
	^ fullInstructionsButton
]

{ #category : #accessing }
CNBBrowser >> help [ 
	^ ' The instructions of the tool'
]

{ #category : #accessing }
CNBBrowser >> helpButton [ 
	^ helpButton
]

{ #category : #initialization }
CNBBrowser >> initializeCnbs [ 

	suffixCnb := ClassNamesBlueprint new withSuffix.
	prefixCnb := ClassNamesBlueprint new withPrefix.
	bothCnb := ClassNamesBlueprint new withBoth.
]

{ #category : #initialization }
CNBBrowser >> initializeExportButton [

	exportButton 
		:= (CNBExportCSVCommand forSpecContext: self)
				iconName: #smallExport; 
				asButtonPresenter 
]

{ #category : #initialization }
CNBBrowser >> initializeFullInstructions [

	fullInstructionsButton 
		:= self newButton 
				label: 'Full Instructions';
				action: [ self showFullInstructions ];
				yourself

]

{ #category : #initialization }
CNBBrowser >> initializeFullInstructionsPresenter [ 

	fullInstructionsPresenter := CNBFullInstructionsPresenter new owner: self. 
]

{ #category : #initialization }
CNBBrowser >> initializeInspectButton [ 

	inspect 
		:= self newButton
				iconName: #glamorousInspect;
				label: 'View'; yourself. 
]

{ #category : #initialization }
CNBBrowser >> initializeInstructionsButton [ 
	
	instructionsButton 
		:= self newButton 
				label: 'Full Instructions';
				help: 'Instructions of the tool';
				action: [ self showInstructions ]
			
]

{ #category : #initialization }
CNBBrowser >> initializeLocalHelpButton [

	helpButton := self newButton 
		iconName: #help;
		help: 'About the tool';
		action: [ self showHelp ];
		yourself
	
]

{ #category : #initialization }
CNBBrowser >> initializeParametersLabel [

	| text ranges theRange textAsString |
	text := Text fromString: 'Parameters:'.
	textAsString := text asString.
	ranges := textAsString allRangesOfSubstring: textAsString.
	theRange := ranges first.
	
    text
       addAttribute: (TextEmphasis bold)
       from: theRange first
       to: theRange last.
	parametersLabel := self newLabel label: text
]

{ #category : #initialization }
CNBBrowser >> initializePatternsHelpButton [

	patternsHelpButton := self newButton 
		iconName: #help;
		help: 'About the patterns';
		action: [ self showPatternsHelp ];
		addStyle: 'small';
		yourself
	
]

{ #category : #initialization }
CNBBrowser >> initializePresenters [

	super initializePresenters.
	
	self initializeCnbs. 
	self initializeLocalHelpButton.
	self initializeInstructionsButton.
	self initializePatternsHelpButton.
	self initializeSettings.
	self initializeFullInstructions.
	self initializeParametersLabel.
	self initializeExportButton.
	self initializeInspectButton.
	self initializeFullInstructionsPresenter.
	suffixSetting := CNBSettings new token: #suffix.
	prefixSetting :=  CNBSettings new token: #prefix.
	bothSetting := CNBSettings new token: #both.
	settings := { suffixSetting . prefixSetting . bothSetting }.
	withoutInterfaces := self newCheckBox.
	withoutInterfaces label: 'Delete Interfaces'.
	withoutPackageName := self newCheckBox.
	withoutPackageName label: 'Delete package reference'.
	packages := OrderedCollection new.
	highlighter := CNBSingletonHighlighter instance.
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
			
	rootSelector := self instantiate: SpTextInputFieldPresenter.
	rootSelector 
		placeholder: 'Define your root class'.
	
	suffix associatedRadioButtons: { prefix . both }.
	
	visualizeButton := self newButton label: 'Visualize'.
	patternsDropList := CNBSpecElementDropList new.
	
	packageSearch := self newSearchInput
		placeholder: 'Search...';
		yourself.	
	projectView := SpRoassalPresenter new.
	

]

{ #category : #initialization }
CNBBrowser >> initializeSettings [ 
	suffixSetting := CNBSettings new.
	prefixSetting := CNBSettings new.
	bothSetting := CNBSettings new.
	settings := { suffixSetting . prefixSetting . bothSetting }.
]

{ #category : #initialization }
CNBBrowser >> initializeWindow: aWindowPresenter [
	super initializeWindow: aWindowPresenter.
	
	aWindowPresenter
		title: self class defaultTitle;
		initialExtent: self class defaultExtent.
		"toolbar: self buildToolbar"
]

{ #category : #accessing }
CNBBrowser >> inspect [ 
	^ inspect
]

{ #category : #accessing }
CNBBrowser >> instructions [ 
	^ instructions
]

{ #category : #'as yet unclassified' }
CNBBrowser >> leaveInterfaces [ 
	settings do: [:each | each leaveInterfaces ]
]

{ #category : #'as yet unclassified' }
CNBBrowser >> leavePackagesNames [
	settings do: [ :each | each  leavePackagesNames] .
]

{ #category : #accessing }
CNBBrowser >> model [ 
	^ model
]

{ #category : #accessing }
CNBBrowser >> model: aModel [

	model := aModel 
]

{ #category : #accessing }
CNBBrowser >> noInterfaces [ 
	^ true
]

{ #category : #actions }
CNBBrowser >> onAddClicked [

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
CNBBrowser >> onBothActivated [

	self onResetClicked.
	^ bothCnb 
		 model 
			ifNotNil: [ 
			projectView script: [ :canvas | canvas @ RSDraggableCanvas .bothCnb on: canvas ] ]
 	
]

{ #category : #actions }
CNBBrowser >> onDeleteAllClicked [

	packages removeAll.
	packagesListPresenter packagesList items: #().
	packagesListPresenter packagesList listPresenter refresh.

	packagesList items: allListItems. 
	packagesList selectItems: #().

	packagesList listPresenter refresh.	

	
	
]

{ #category : #actions }
CNBBrowser >> onPrefixActivated [

	self onResetClicked.
	^ prefixCnb
		 model 
			ifNotNil: [ 
			projectView script: [ :canvas | canvas @ RSDraggableCanvas .prefixCnb on: canvas ] ]
 	
]

{ #category : #actions }
CNBBrowser >> onResetClicked [

	highlighter property: nil.
	highlighter reset.
	projectView canvas color: Color white darker.	
	

	
	
]

{ #category : #actions }
CNBBrowser >> onShowClicked [ 

	^ (packagesListPresenter items: packages) openWithSpec
]

{ #category : #actions }
CNBBrowser >> onSuffixActivated [

	self onResetClicked.
	^ suffixCnb 
		 model 
			ifNotNil: [ 
			projectView script: [ :canvas | canvas @ RSDraggableCanvas . suffixCnb on: canvas ] ]
 	
]

{ #category : #actions }
CNBBrowser >> onUpdateClicked [ 

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
CNBBrowser >> onVisualizeClicked [

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
CNBBrowser >> packages [ 

	^ packages
]

{ #category : #accessing }
CNBBrowser >> packagesList [ 

	^ packagesList 
]

{ #category : #'as yet unclassified' }
CNBBrowser >> parametersLabel [

	^ parametersLabel 
]

{ #category : #initialization }
CNBBrowser >> patternsDropList [

	^ patternsDropList
]

{ #category : #'as yet unclassified' }
CNBBrowser >> practicalInstructions [

	^ 'Practical Instructions: 
Right Click to highlight the hierarchy,
Left Click to show class definition, 
Click on any box to de-highlight'
]

{ #category : #accessing }
CNBBrowser >> prefixCnb [ 

	^ prefixCnb
]

{ #category : #accessing }
CNBBrowser >> projectAtRadioButton: aRadioButtion [

	^ radioButtionsActions asDictionary at: aRadioButtion.
	
]

{ #category : #building }
CNBBrowser >> projectModel: aMooseModel with: aRootClass [

	settings do: [ :each | each rootClass: aRootClass ].
	(suffixCnb setting: suffixSetting; model: aMooseModel) startBuilding; buildShapes.
	(prefixCnb setting: prefixSetting; model: aMooseModel) startBuilding; buildShapes.
	(bothCnb setting: bothSetting; model: aMooseModel) startBuilding; buildShapes.
	
	"self fixColors."
	
	
	
]

{ #category : #accessing }
CNBBrowser >> projectView [

	^ projectView
]

{ #category : #actions }
CNBBrowser >> radioButtionActions [

	^ radioButtionsActions asDictionary 
]

{ #category : #'accessing - morph' }
CNBBrowser >> radioButtons [ 

	^ (suffix associatedRadioButtons union: { suffix }) 
]

{ #category : #initialization }
CNBBrowser >> resetPackageBoder [

	self halt.
	selectedPackageBox border width: selectedPackageBox model class new defaultBorderWidth 
]

{ #category : #selection }
CNBBrowser >> selectAll [

	packagesList listPresenter items selectAll
]

{ #category : #accessing }
CNBBrowser >> selectedCnB [ 

	| activatedRadioButton |
	activatedRadioButton := self radioButtons detect: [ :each | each state ].

	^ (self projectAtRadioButton: activatedRadioButton).
]

{ #category : #'as yet unclassified' }
CNBBrowser >> showFullInstructions [

		^ CNBFullInstructionsPresenter new openWithSpec 
]

{ #category : #actions }
CNBBrowser >> showHelp [
	| help |
	(help := self newPopover)
		relativeTo: helpButton;
		presenter: (CNBHelpPopupPresenter owner: help on: self);
		popup
]

{ #category : #actions }
CNBBrowser >> showInstructions [

	| instructions |
	(instructions := self newPopover) 
			relativeTo: instructionsButton;
			presenter: (CNBInstructionsPopupPresenter owner: instructions on: self);
			popup
]

{ #category : #actions }
CNBBrowser >> showNodesAttributedTo: anObject [

	highlighter highlight: self allNodes accordingTo: anObject.
	highlighter nodesToBeHighlighted ifEmpty: [ ^ self onResetClicked ].

	projectView canvas color: Color black whiter.
]

{ #category : #actions }
CNBBrowser >> showPatternsHelp [

	| patterns |
	(patterns := self newPopover) 
			relativeTo: patternsHelpButton;
			presenter: (CNBPatternsPopupPresenter owner: patterns on: self);
			popup
]

{ #category : #accessing }
CNBBrowser >> suffixCnb [ 

	^ suffixCnb 
]

{ #category : #actions }
CNBBrowser >> updateForNewModel: aModel [

	self model: aModel
]

{ #category : #accessing }
CNBBrowser >> withoutInterfaces [
	^ withoutInterfaces
]

{ #category : #accessing }
CNBBrowser >> withoutPackageName [
	^ withoutPackageName
]
