Class {
	#name : #CNBBothTokensStrategy,
	#superclass : #Object,
	#instVars : [
		'packageOrganizer',
		'builder'
	],
	#category : #CNBModels
}

{ #category : #building }
CNBBothTokensStrategy class >> build: aViewModel [

	^ self new
			build: aViewModel 
]

{ #category : #building }
CNBBothTokensStrategy class >> doTokenDictionaryFrom: aCollectionOfClassModels [

	^ self new 
			doTokenDictionaryFrom: aCollectionOfClassModels

]

{ #category : #building }
CNBBothTokensStrategy >> build: aCND [

		| thePackageModels |
	thePackageModels := builder doPackageModelsOf: aCND.
	
	aCND viewModel
		name: aCND model name;
		packageModels: thePackageModels;
		rootModels: (self buildRootsFrom: (thePackageModels flatCollect: #classModels)).
		
		aCND viewModel packageViewModels: (self doPackageViewModelsOf: aCND).
	
		aCND viewModel attributeTokenModelsToRoots.
		
		aCND viewModel refactorTokenModels.
		
		aCND viewModel attributePatterns.
		^ aCND 
	
]

{ #category : #'as yet unclassified' }
CNBBothTokensStrategy >> buildRoot: aRootModel [

	| subclasses |
	subclasses := aRootModel subclasses.
	^ aRootModel 
		name: (CNBFilterer removeAllDigitsAndSpecialCharsFrom: aRootModel model name);  
		type: (CNBClassType with: subclasses) type;
		token: { (CNBFeatureSelector new 
					extract: #suffix
					from: aRootModel model name) . 
					(CNBFeatureSelector new 
					extract: #prefix
					from: aRootModel model name) };
		size: subclasses size; 
		tokenPosition: #both;
		tokensDictionary: (self doTokenDictionaryFrom: subclasses).
		
		
]

{ #category : #building }
CNBBothTokensStrategy >> buildRootsFrom: classModels [

	| initializedRoots coloredRootModels rootModels |
	initializedRoots := (classModels collect: #root) 
			asSet
				collect: [ :aRootClass |
									self buildRoot: (self newRootModel
										model: aRootClass 
										with: (classModels select: [ :aClass | aClass root = aRootClass ])).
			 				].
						
	coloredRootModels := builder color: initializedRoots.
	rootModels := builder 
			startFightOverTokensBetween: coloredRootModels.
	
	^ rootModels asSet
]

{ #category : #building }
CNBBothTokensStrategy >> doPackageViewModelsOf: aCND [ 

		(aCND viewModel 
			packageModels 
				collect: [ :eachPackageModel |
						eachPackageModel packageViewModel:  
									(CNBPackageViewModel 
										of: eachPackageModel 
										with: (self 
													doTokenViewModelsOf: eachPackageModel 
													using: aCND viewModel rootModels)
									) cluster ]).
		^ aCND viewModel packageModels collect: #packageViewModel
]

{ #category : #building }
CNBBothTokensStrategy >> doTokenDictionaryFrom: classModels [

	| tokensDictionary tokens |
	tokensDictionary := Dictionary new.
	
	tokens := (classModels flatCollect: #tokens).
	(classModels flatCollect: #tokens) 
		do: [ :aToken | 
			tokensDictionary 
				at: aToken 
				put: (tokens occurrencesOf: aToken) ].
			
	^ tokensDictionary 
]

{ #category : #building }
CNBBothTokensStrategy >> doTokenViewModelsOf: aPackageModel using: rootModels [
	"On enveloppe chaque class du package dans son concept box "

	^ (self extractTokensFrom: aPackageModel) asSet 
		collect: [ :aToken | 
			CNBTokenViewModel 
				of: aToken
				root: (builder 
							selectBiggestHierarchyOf: aToken
							using: rootModels) 
				with: (builder 
								doClassViewModelsOf: (self extractClassModelsOf: aPackageModel WithToken: aToken)
								using: rootModels)
				in: aPackageModel ]
]

{ #category : #'as yet unclassified' }
CNBBothTokensStrategy >> extractClassModelsOf: aPackageModel WithToken: aToken [

	^ aPackageModel classModels select: [ :eachClassmodel | eachClassmodel tokens includes: aToken ]
]

{ #category : #extracting }
CNBBothTokensStrategy >> extractTokensFrom: aPackageModel [

	^ aPackageModel 
			classModels 
				flatCollect: [ :aClassModel | aClassModel tokens ]
]

{ #category : #initialization }
CNBBothTokensStrategy >> initialize [ 
	super initialize.
	
	builder := CNBBuilder new.
	packageOrganizer := CNBPackageViewModelOragnizer new
]

{ #category : #'instance creation' }
CNBBothTokensStrategy >> newRootModel [ 

	^ CNBRootModel 
]

{ #category : #'as yet unclassified' }
CNBBothTokensStrategy >> organize: aCollectionOfPackages [

	aCollectionOfPackages do: [ :each | packageOrganizer do: each ]
]

{ #category : #'as yet unclassified' }
CNBBothTokensStrategy >> organize: aSuffixDistribution accordingTo: aPrefixDistribution [
	| scatteredSuffixPackages siblingPackages scatteredPackagesNames |
	
	scatteredSuffixPackages := aSuffixDistribution viewModel scatteredPackages.
	scatteredPackagesNames := (scatteredSuffixPackages collect: #name).
	
	siblingPackages 
		:= aPrefixDistribution viewModel 
				packageViewModels 
					select: [ :each | (scatteredPackagesNames includes: each name) ].
		
	scatteredSuffixPackages 
		do: [ :aPackage | | itsSibling |
					itsSibling 
						:= siblingPackages detect: [ :each | each name = aPackage name].
					
		packageOrganizer organize: aPackage accordingTo: itsSibling
		 ].
	^ aSuffixDistribution 

	
]
