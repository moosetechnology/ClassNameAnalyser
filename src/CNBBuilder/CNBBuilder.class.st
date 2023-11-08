"
I am responsible for building the ClassNames Distribution and extracting the data.
"
Class {
	#name : #CNBBuilder,
	#superclass : #Object,
	#traits : 'CNBTColorAttributor + CNBTDataExtractor',
	#classTraits : 'CNBTColorAttributor classTrait + CNBTDataExtractor classTrait',
	#instVars : [
		'visualization'
	],
	#classInstVars : [
		'rootmodels',
		'conceptualmodel'
	],
	#category : #'CNBBuilder-Build'
}

{ #category : #counting }
CNBBuilder class >> countIntrudersIn: aViewModel [
	^self new
		countIntrudersIn: aViewModel
]

{ #category : #enumerating }
CNBBuilder class >> do: anObject [
	^self new 
		do: anObject
]

{ #category : #doing }
CNBBuilder class >> doPackageModelsOf: aModel [

	^self new 
		doPackageModelsOf: aModel 
]

{ #category : #doing }
CNBBuilder class >> doPackageViewModelsOf: packageModels [
	^self new
	doPackageViewModelsOf: packageModels 
]

{ #category : #doing }
CNBBuilder class >> doPrefixesDictionaryFrom: aCollectionOfClassModels [
	^self new 
	doPrefixesDictionaryFrom: aCollectionOfClassModels

]

{ #category : #doing }
CNBBuilder class >> doRootsOf: aCollectionOfClassModels [ 
	^self new
		doRootsOf: aCollectionOfClassModels  
]

{ #category : #extraction }
CNBBuilder class >> extractBiggestClassDepthFrom: aConceptualModel [ 
	| classModels |
	classModels := self new 
		extractClassModelsFrom: aConceptualModel.
	^self new 
		extractBiggestClassDepthFrom: classModels.
]

{ #category : #extraction }
CNBBuilder class >> extractClassModelsFrom: packageModels [ 	
	^self new
		extractClassModelsFrom: packageModels 
]

{ #category : #extraction }
CNBBuilder class >> extractSmallestClassDepthFrom: aConceptualModel [
	| classModels |
	classModels := self new 
		extractClassModelsFrom: aConceptualModel.
	^self new 
		extractSmallestClassDepthFrom: classModels.

	
]

{ #category : #removing }
CNBBuilder class >> removePackageNameFromClass: aClass [
	
	^ self new
		removePackageNameFromClass: aClass
]

{ #category : #sorting }
CNBBuilder class >> sort: aCollection [ 

	^self new
		sortAccordingToPalette: aCollection 
]

{ #category : #adding }
CNBBuilder >> addPatternsOccurencesIn: aCnb to: analysisDescription [

	analysisDescription 
		confetti: (self confettiCasesIn: aCnb);
		fatBlob: (self fatBlobCasesIn: aCnb);
		nearlyHomogeneous: (self nearlyHomogeneousCasesIn: aCnb);
		homogeneous: (self homogeneousCasesIn: aCnb);
		intruder: (self intruderCasesIn: aCnb);
		snowFlakes: (self snowFlakesCasesIn: aCnb);
		scatteredVocabulary: (self scatteredVocabularyCasesIn: aCnb).
]

{ #category : #adding }
CNBBuilder >> addProjectInfoIn: aCnb to: analysisDescription [

	| tokensPerMultiHierarchy roots classes monoTokenMaxChildren multiTokenMaxChildren |
	tokensPerMultiHierarchy	
		:= ((aCnb viewModel rootModels 
			select: [ :each | each isMultiToken ]) collect: [ :each | each hierarchyTokens size]).
	roots := aCnb viewModel rootModels.
	classes := aCnb viewModel classViewModels.
	multiTokenMaxChildren := ((roots select: #isMultiToken) detectMax: #children) ifNil: [ nil ].
	monoTokenMaxChildren := ((roots select: #isMonoToken) detectMax: #children) ifNil: [ nil ].
	analysisDescription 
		project: aCnb viewModel model name;
		tokens: aCnb viewModel tokenModels size;
		classes: aCnb viewModel classViewModels size;
		packages: aCnb viewModel packageViewModels size;
		hierarchies: (roots select: [ :each | each isMonoToken or: [ each isMultiToken  ] ]) size;	
		maxDepthRoot: (roots detectMax: [ :aRoot | aRoot maxDepth ]) name; 
		maxDepth: (roots detectMax: [ :aRoot | aRoot maxDepth ]) maxDepth;
		maxChildrenRoot: (roots detectMax: [ :root | root children ]) name;
		maxChildren: (roots detectMax: [ :root | root children ]) children;
		averageDepth: (roots collect: [ :each | each maxDepth ]) average asInteger;
		averageChildren: (roots collect: [ :each | each children ]) average asInteger;
		monoClasses: (roots select: [ :each | each isMonoClass ])size;
		monoTokenClasses: (classes select: [ :each | each root isMonoToken ]) size;
		multiTokenClasses: (classes select: [ :each | each root isMultiToken ]) size;	
		multiTokenHierarchies: (roots select: [ :each | each isMultiToken ]) size;
		suspisciousTokens: ((aCnb viewModel rootModels collect: [ :each | each suspisciousTokens ]) sum) ;	
		averageTokensPerMultiHierarchy: (tokensPerMultiHierarchy ifEmpty: [ 0 ] ifNotEmpty: [ tokensPerMultiHierarchy average asFloat ]);
		monoTokenMaxChildren: (monoTokenMaxChildren ifNil: [ 0 ] ifNotNil: [ monoTokenMaxChildren children  ]);  
		multiTokenMaxChildren: (multiTokenMaxChildren ifNil: [ 0 ] ifNotNil: [ multiTokenMaxChildren children  ]).
	aCnb analysisDescription: analysisDescription
		
]

{ #category : #assignments }
CNBBuilder >> assignColorByType: aType [

	(aType = CNBClassType trait)
	ifTrue: [ ^ palette traitColor ].
	
	(aType = CNBClassType monoClass)
	ifTrue: [ ^ palette monoClassColor ].
	
	(aType = CNBClassType monoToken)
	ifTrue: [  ^ palette monoTokenColor ].
	
	(aType = CNBClassType multiToken)
	ifTrue: [ ^ palette aColorForMultiToken ].
]

{ #category : #building }
CNBBuilder >> buildAnalysisDescriptionOf: aCnb [

	| analysisDescription  |
	analysisDescription := CNBAnalysisDescription new.
	
	aCnb viewModel packageViewModels 
	ifEmpty: [ aCnb analysisDescription: nil  ]
	ifNotEmpty: [  
	self addPatternsOccurencesIn: aCnb to: analysisDescription.
	self addProjectInfoIn: aCnb to: analysisDescription ] 
]

{ #category : #coloring }
CNBBuilder >> color: rootModels [

	|  coloredRootModels |
	
	coloredRootModels := ((self sortRootModels: rootModels))
		collect: 
			[ :each | 	
			each color: (self assignColorByType: each type) ].			
	^ coloredRootModels 
	
]

{ #category : #building }
CNBBuilder >> do: anObject [

	^ anObject startBuilding 
]

{ #category : #building }
CNBBuilder >> doClassViewModelsOf: classmodels using: rootModels [
   
	^ classmodels 
			collect: [ :eachClassModel | | itsRoot | 
				itsRoot := rootModels 
					detect: [ :eachRootModel | eachClassModel root = eachRootModel model ].
				
			CNBClassViewModel of: eachClassModel with: itsRoot. 
				 ].
]

{ #category : #'as yet unclassified' }
CNBBuilder >> doPackageModels [ 

	^ visualization model packages 
		collect: [ :eachPackage | CNBPackageModel of: eachPackage withSettings: visualization setting  ]
]

{ #category : #building }
CNBBuilder >> doPackageViewModelsOf: aCND [ 

		(aCND viewModel 
			packageModels 
				collect: [ :eachPackageModel |
						eachPackageModel packageViewModel:  
									(CNBPackageViewModel 
										of: eachPackageModel 
										with: (self 
													doTokenViewModelsOf: eachPackageModel 
													using: aCND viewModel rootModels)) ]).
		^ aCND viewModel packageModels collect: #packageViewModel
]

{ #category : #building }
CNBBuilder >> doTokenViewModelsOf: aPackageModel using: rootModels [
	"On enveloppe chaque class du package dans son concept box "

	^ (self extractTokensFrom: aPackageModel) asSet 
		collect: [ :aToken | 
			CNBTokenViewModel 
				of: aToken
				root: (self 
							selectBiggestHierarchyOf: aToken
							using: rootModels) 
				with: (self 
								doClassViewModelsOf: (aPackageModel extractClassModelsWithToken: aToken)
								using: rootModels)
				in: aPackageModel ]
]

{ #category : #initialization }
CNBBuilder >> initialize [
	
	super initialize.
	palette := CNBPalette
		with:
			{Color red . 
			Color yellow . 
			Color blue lighter .
			Color purple . 
			Color brown . 
			Color magenta darker. 
			Color orange . 
			Color blue muchDarker .
			Color green muchDarker .
			Color pink . 
			Color green darker . 
			Color cyan . 
			Color pink muchDarker . 
			Color lightGreen . 
			Color yellow darker darker darker.
			Color lightOrange . 
			Color lightYellow . 
			Color paleBlue .
			Color paleMagenta . 
			Color paleOrange .
			Color palePeach darker darker. 
			Color purple lighter lighter lighter lighter lighter lighter lighter lighter. 
			Color brown lighter lighter lighter . 
			Color paleTan  }.
	
]

{ #category : #'instance creation' }
CNBBuilder >> newPalette [
	
	| newPalette |
	newPalette := palette multiTokenColors asOrderedCollection.
	newPalette
		addAll:
			{palette monoTokenColor.
			palette monoClassColor.
			palette defaultColor}.
		
	^ newPalette  
]

{ #category : #accessing }
CNBBuilder >> palette [ 
	^ palette
]

{ #category : #removing }
CNBBuilder >> removePackageNameFromClass: aClass [

	| packageName featureSelector packageTokens packageTokensFiltered classTokens classTokensFiltered |
	packageName := (RPackageOrganizer default packageOf:
		                (self class environment at: aClass name))
		               packageName.

	featureSelector := CNBFeatureSelector new.
	packageTokens := featureSelector tokenize: packageName.
	packageTokensFiltered := featureSelector filterAll: packageTokens.

	classTokens := featureSelector tokenize: aClass name.
	classTokensFiltered := featureSelector filterAll: classTokens.

	^ (classTokensFiltered reject: [ :each | 
		   packageTokensFiltered includes: each ]) concatenatesStrings 
		  ifEmpty: [ classTokensFiltered last ]
]

{ #category : #sorting }
CNBBuilder >> sortAccordingToPalette: aCollection [
	| modelsOrderedByColor newPalette |
	modelsOrderedByColor := OrderedCollection new.	
	newPalette := self newPalette.
		
		 newPalette do: [ :aColor |
			modelsOrderedByColor 
				addIfNotPresent: (aCollection select: [ :aToken | aColor = aToken color ]).
							  ]. 
		
	^ modelsOrderedByColor flattened.
		
]

{ #category : #sorting }
CNBBuilder >> sortRootModels: aSetOfRootModels [

	^ (aSetOfRootModels sorted: #name ascending) sorted: #size descending
]

{ #category : #internal }
CNBBuilder >> startFightOverTokensBetween: rootModels [
	| tokens |
	
	tokens := (rootModels flatCollect: [ :each | each tokensDictionary keys ]) asSet.
	tokens
		do: [ :aToken | 
			| fighters winner |
			fighters := (rootModels
								select: [ :aRoot | aRoot tokensDictionary includesKey: aToken ]) copy asOrderedCollection.
								
			(fighters anySatisfy: [ :aRootModel | aRootModel isMultiToken ])
				ifTrue: [ fighters removeAllSuchThat: [ :aRootM | aRootM isMonoClass or: [ aRootM isTrait ] ] ].
				
			winner := fighters
				detectMax: [ :aRM | (aRM tokensDictionary at: aToken) value ].
			winner dominantTokens: (winner tokensDictionary associationAt: aToken) ].
	^ rootModels
]

{ #category : #accessing }
CNBBuilder >> visualization [ 
	^ visualization
]

{ #category : #accessing }
CNBBuilder >> visualization: aCND [
	visualization := aCND
]
