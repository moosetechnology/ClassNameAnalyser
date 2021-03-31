Class {
	#name : #CNBBuilder,
	#superclass : #Object,
	#traits : 'CNBTColorAttributor + CNBTDataExtractor',
	#classTraits : 'CNBTColorAttributor classTrait + CNBTDataExtractor classTrait',
	#classInstVars : [
		'rootmodels',
		'conceptualmodel'
	],
	#category : #CNBBuilder
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
CNBBuilder >> addPatternsDescriptionsOf: aCnb to: analysisDescription [

	analysisDescription 
		confetti: (self confettiCasesIn: aCnb);
		fatBlob: (self fatBlobCasesIn: aCnb);
		homogeneityBreaker: (self homogeneityBreakerCasesIn: aCnb);
		homogeneous: (self homogeneousCasesIn: aCnb);
		intruder: (self intruderCasesIn: aCnb);
		snowFlakes: (self snowFlakesCasesIn: aCnb);
		scatteredVocabulary: (self scatteredVocabularyCasesIn: aCnb).
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

{ #category : #'as yet unclassified' }
CNBBuilder >> buildAnalysisDescriptionOf: aCnb [

	| analysisDescription |
	analysisDescription := CNBAnalysisDescription new.
	self addPatternsDescriptionsOf: aCnb to: analysisDescription.
	analysisDescription 
		
		tokens: aCnb viewModel tokenModels size;
		classes: aCnb viewModel classViewModels size;
		packages: aCnb viewModel packageViewModels size;
		maxDepthRoot: (aCnb viewModel rootModels detectMax: [ :aRoot | aRoot maxDepth ]); 
		maxDepth: (aCnb viewModel rootModels detectMax: [ :aRoot | aRoot maxDepth ]) maxDepth;
		maxChildrenRoot: (aCnb viewModel rootModels detectMax: [ :root | root children ]);
		maxChildren: (aCnb viewModel rootModels detectMax: [ :root | root children ]) children;
		averageDepth: (aCnb viewModel rootModels collect: [ :each | each maxDepth ]) average asInteger;
		averageChildren: (aCnb viewModel rootModels collect: [ :each | each children ]) average asInteger.
		
	aCnb analysisDescription: analysisDescription 
		
]

{ #category : #coloring }
CNBBuilder >> color: rootModels [

	|  coloredRootModels |
	
	coloredRootModels := (self sortRootModels: rootModels)
		collect: 
			[ :each | 
			
			each 
							color: (self 
											assignColorByType: each type) ].			
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

{ #category : #building }
CNBBuilder >> doPackageModelsOf: aCND [

	^ aCND 
			model packages collect: [ :eachPackage | 
												CNBPackageModel 
													of: eachPackage 
													withSettings: aCND setting  ]
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

{ #category : #initialize }
CNBBuilder >> initialize [
	
	super initialize.
	palette := CNBPalette
		with:
			{Color red . 
			Color yellow . 
			Color blue .
			Color purple . 
			Color brown . 
			Color magenta . 
			Color orange . 
			Color green muchDarker .
			Color pink . 
			Color green darker . 
			Color cyan . 
			Color pink muchDarker . 
			Color lightGreen . 
			Color magenta lighter .
			Color lightOrange . 
			Color lightYellow . 
			Color paleBlue .
			Color paleMagenta . 
			Color paleOrange .
			Color palePeach . 
			Color paleRed  . 
			Color lightBrown . 
			Color paleTan . 
			Color paleMagenta }.
	
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

	| packageName featureSelector 
		packageTokens packageTokensFiltered classTokens classTokensFiltered class |
	class := Smalltalk image classNamed: aClass name.	
	packageName := (RPackageOrganizer default packageOf: class) packageName.
	
	featureSelector := CNBFeatureSelector new.
	packageTokens := featureSelector tokenize: packageName.
	packageTokensFiltered := featureSelector filterAll: packageTokens.

	classTokens := featureSelector tokenize: class name.
	classTokensFiltered := featureSelector filterAll: classTokens.
	
	^ ((classTokensFiltered reject: [ :each | 
		               packageTokensFiltered includes: each ]) concatenatesStrings) ifEmpty: [ classTokensFiltered last ]


]

{ #category : #'as yet unclassified' }
CNBBuilder >> reselectBiggestHierarchy: aTokenName using: rootModels [

	| rootsUsingToken |
	rootModels select: [ :each | each tokensDictionary keys includes: aTokenName ].
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

	^ (aSetOfRootModels 
			sorted: #size descending)
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
