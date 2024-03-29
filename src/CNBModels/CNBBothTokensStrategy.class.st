"
I am the strategy followed when selecting either the suffix or prefix; The principe is to group each class in her prefix AND suffix box. Calculate siblings in each box (siblings are the classes which belong to the same hierarchy), the class stays where it has more siblings and is deleted from the other boxes.
"
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
CNBBothTokensStrategy class >> build: aCND [

	^ self new
			build: aCND 
]

{ #category : #building }
CNBBothTokensStrategy class >> doTokenDictionaryFrom: aCollectionOfClassModels [

	^ self new 
			doTokenDictionaryFrom: aCollectionOfClassModels

]

{ #category : #building }
CNBBothTokensStrategy >> build: aCND [

		| thePackageModels |
	builder visualization: aCND. 
	thePackageModels := builder doPackageModels.

	aCND viewModel
		name: aCND model name;
		packageModels: thePackageModels;
		rootModels: (self buildRootsFrom: (thePackageModels flatCollect: #classModels));
		packageViewModels: (self doPackageViewModelsOf: aCND).
		
		self resetRoots: aCND rootModels.
		aCND attributeRoots.	
		aCND viewModel attributePatterns.
		builder buildAnalysisDescriptionOf: aCND.
		^ aCND 
	
]

{ #category : #'as yet unclassified' }
CNBBothTokensStrategy >> buildRoot: aRootModel [

	| subclasses name rootName |
	subclasses := aRootModel subclasses.
	name 
		:= aRootModel model exists  
					ifTrue: [ (CNBBuilder removePackageNameFromClass: aRootModel model) ] 
					ifFalse: [ aRootModel model name ].
	rootName := 	(CNBFilterer removeAllDigitsAndSpecialCharsFrom: name).			
	^ aRootModel 
		name: rootName; 
		tokenPosition: #both;
		tokensDictionary: (self doTokenDictionaryFrom: subclasses);
		initializeToken. 
]

{ #category : #building }
CNBBothTokensStrategy >> buildRootsFrom: classModels [

	| initializedRoots |
	initializedRoots := (classModels collect: #root) 
			asSet
				collect: [ :aRootClass |
									self 
										buildRoot: (self newRootModel
											model: aRootClass 
											with: (classModels select: [ :aClass | aClass root = aRootClass ])).
			 				].
	
	^ initializedRoots asSet 
]

{ #category : #building }
CNBBothTokensStrategy >> doPackageViewModelsOf: aCND [ 


		(aCND viewModel 
			packageModels 
				collect: [ :eachPackageModel | | tokens |
					tokens := Set new addAll: (self 
									doTokenViewModelsOf: eachPackageModel 
									using: aCND viewModel rootModels).
			
					eachPackageModel 
						packageViewModel:  
							(CNBPackageViewModel 
								of: eachPackageModel 
								with: tokens) cluster ]).
	
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
	| tokenNames tokens |
	
	tokenNames := self extractTokensFrom: aPackageModel.
	tokens := tokenNames asSet collect: [ :aToken | 
			CNBTokenViewModel 
				of: aToken
				root: nil
				with: (builder 
								doClassViewModelsOf: 
									(self extractClassModelsOf: aPackageModel WithToken: aToken)
								using: rootModels)
				in: aPackageModel ].

			^ tokens asSet

			
]

{ #category : #'as yet unclassified' }
CNBBothTokensStrategy >> extractClassModelsOf: aPackageModel WithToken: aToken [

	^ aPackageModel classModels select: [ :eachClassmodel | eachClassmodel tokens includes: aToken ]
]

{ #category : #extracting }
CNBBothTokensStrategy >> extractTokensFrom: aPackageModel [

	^ aPackageModel
			classModels 
				flatCollect: [ :aClassModel | aClassModel tokens ].
				 
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

{ #category : #initialization }
CNBBothTokensStrategy >> resetRoots: rootModels [

	| coloredRootModels |
	
	rootModels do: [ :each | 
		each type: (CNBClassType with: each subclasses) type.
		each removeUnnecessaryTokens ].
			
	coloredRootModels := builder color: rootModels.
	coloredRootModels := builder 
			startFightOverTokensBetween: coloredRootModels.
	
	
]
