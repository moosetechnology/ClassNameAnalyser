Class {
	#name : #CNBTokenStrategy,
	#superclass : #Object,
	#instVars : [
		'builder'
	],
	#category : #CNBModels
}

{ #category : #building }
CNBTokenStrategy class >> build: aViewModel [
	^ self new
			build: aViewModel 
]

{ #category : #building }
CNBTokenStrategy class >> doTokenDictionaryFrom: aCollectionOfClassModels [

	^ self new 
			doTokenDictionaryFrom: aCollectionOfClassModels

]

{ #category : #building }
CNBTokenStrategy >> build: aCND [

	| thePackageModels |
	builder visualization: aCND.
	thePackageModels := builder doPackageModels.
	aCND viewModel
		name: aCND model name;
		packageModels: thePackageModels;
		rootModels: (self buildRootsFrom: (thePackageModels flatCollect: #classModels)).
		
		aCND viewModel packageViewModels: (builder doPackageViewModelsOf: aCND).
		aCND viewModel attributeTokenModelsToRoots.
		aCND viewModel attributePatterns.
		builder buildAnalysisDescriptionOf: aCND.
		^ aCND 

]

{ #category : #'as yet unclassified' }
CNBTokenStrategy >> buildRoot: aRootModel [

	| subclasses |
	subclasses := aRootModel subclasses.
	^ aRootModel 
		name: (CNBFilterer removeAllDigitsAndSpecialCharsFrom: aRootModel model name); 
		type: (CNBClassType with: subclasses) type;
		token: (CNBFeatureSelector new 
					extract: subclasses atRandom setting 
					from: aRootModel model name);
		size: subclasses size; 
		tokenPosition: subclasses atRandom setting token;
		tokensDictionary: (self doTokenDictionaryFrom: subclasses).
		
		
]

{ #category : #building }
CNBTokenStrategy >> buildRootsFrom: classModels [

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
CNBTokenStrategy >> doTokenDictionaryFrom: classModels [

	| tokensDictionary tokens |
	tokensDictionary := Dictionary new.
	
	tokens := (classModels collect: #token).
	(classModels collect: #token) 
		do: [ :aToken | 
			tokensDictionary 
				at: aToken 
				put: (tokens occurrencesOf: aToken) ].
			
	^ tokensDictionary 
]

{ #category : #initialization }
CNBTokenStrategy >> initialize [ 
	super initialize.
	
	builder := CNBBuilder new
]

{ #category : #'instance creation' }
CNBTokenStrategy >> newRootModel [ 

	^ CNBRootModel 
]
