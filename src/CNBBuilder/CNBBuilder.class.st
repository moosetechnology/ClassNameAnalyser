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
CNBBuilder class >> doRootsOf: aCollectionOfClassModels Accordingto: aMotherClass [
	^self new
		doRootsOf: aCollectionOfClassModels Accordingto: aMotherClass  
]

{ #category : #doing }
CNBBuilder class >> doTokenDictionaryFrom: aCollectionOfClassModels [
	^self new 
	doTokenDictionaryFrom: aCollectionOfClassModels

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

{ #category : #sorting }
CNBBuilder class >> sort: aCollection [ 

	^self new
		sortAccordingToPalette: aCollection 
]

{ #category : #assignments }
CNBBuilder >> assignColorByType: aType [

	(aType = CNBClassType trait)
	ifTrue: [ ^ palette traitColor ].
	
	(aType = CNBClassType monoClass)
	ifTrue: [ ^ palette monoClassColor ].
	
	(aType = CNBClassType monoToken)
	ifTrue: [  ^ palette monoSuffixColor ].
	
	(aType = CNBClassType multiToken)
	ifTrue: [ ^ palette aColorForMultiSuffix ].
]

{ #category : #accessing }
CNBBuilder >> color: rootModels [
	| sortedRootModels coloredRootModels |
	sortedRootModels := self sortRootModels: rootModels.
	coloredRootModels := (sortedRootModels 
		collect: 
			[ :eachRootModel | eachRootModel color: (self assignColorByType: eachRootModel type) ]).
	^coloredRootModels 
	
]

{ #category : #counting }
CNBBuilder >> countIntrudersIn: aCnbDescription [

	| conceptVModels intruders conceptIntruders |
	
	intruders := 0.
	conceptVModels := aCnbDescription packageViewModels flatCollect: #tokenViewModels.
	
	conceptVModels do: [ :eachCVM |
		conceptIntruders := eachCVM classViewModels select: [ :cvm |
			cvm root isMonoClass not and: [ 
				cvm root name ~= eachCVM root name ] ].
		
		intruders := intruders + conceptIntruders size ].	
		
	^intruders
	
]

{ #category : #enumerating }
CNBBuilder >> do: anObject [
	^ anObject startBuilding 
]

{ #category : #accessing }
CNBBuilder >> doClassViewModelsOf: classmodels using: rootModels [

	^ classmodels collect: [ :eachClassModel | 
				| itsRoot |
				itsRoot := rootModels 
					detect: [ :eachRootModel | eachClassModel root name = eachRootModel name ].
				
			CNBClassViewModel new 
				create: eachClassModel;
				root: itsRoot;
				originalColor: itsRoot color copy;
				color: itsRoot color
				 ]
]

{ #category : #doing }
CNBBuilder >> doPackageModelsOf: aViewModel [

	^ aViewModel model packages 
			collect: [ :eachPackage | 
				CNBPackageModel 
					of: eachPackage 
					withSettings: aViewModel settings  ]
]

{ #category : #doing }
CNBBuilder >> doPackageViewModelsOf: aViewModel [ 

	^(aViewModel packageModels collect: [ :eachPackageModel | 
			
				CNBPackageViewModel 
				of: eachPackageModel 
				with: (self
							doTokenViewModelsOf: eachPackageModel 
							using: aViewModel rootModels) ]). 
					
]

{ #category : #doing }
CNBBuilder >> doRootsOf: classModels Accordingto: aSetting [
	| initialeRootModels coloredRootModels rootModels |
	
	initialeRootModels := (classModels collect: #root) asSet
		collect: [ :aRootClass | | subclasses |
				subclasses := classModels select: [ :aClass | aClass root = aRootClass ].
			CNBRootModel model: aRootClass with: subclasses.
			 ].
								
	coloredRootModels := self color: initialeRootModels.
	
	rootModels := self startFightOverTokensBetween: coloredRootModels.
	
	^ rootModels asSet
]

{ #category : #doing }
CNBBuilder >> doTokenDictionaryFrom: aCollectionOfClassModels [
	| tokensDictionary tokens |
	tokensDictionary := Dictionary new.
	
	tokens := (aCollectionOfClassModels collect: #token).
	tokens do: [ :aToken | tokensDictionary at: aToken put: (tokens occurrencesOf: aToken) ].
	^ tokensDictionary 
]

{ #category : #accessing }
CNBBuilder >> doTokenViewModelsOf: aPackageModel using: rootModels [
	"On enveloppe chaque class du package dans son concept box "

	| tokens |
	
	tokens := (aPackageModel classModels collect: #token) asSet.
	^ tokens
		collect: [ :aToken | 
			| classmodels itsRoot |
			itsRoot := self
				selectBiggestHierarchyOf: aToken
				using: rootModels.
			classmodels := aPackageModel classModels
				select: [ :eachClassmodel | eachClassmodel token = aToken ].
			CNBTokenViewModel new
				package: aPackageModel name;
				name: aToken;
				classViewModels: (self doClassViewModelsOf: classmodels using: rootModels);
				root: itsRoot;
				originalColor: itsRoot color copy;
				color: itsRoot color ]
]

{ #category : #extracting }
CNBBuilder >> extractTokensFrom: aPackageModel [

	^aPackageModel classModels collect: [ :aClassModel | aClassModel token ]
]

{ #category : #initialize }
CNBBuilder >> initialize [
	super initialize.
	palette := CNBPalette
		with:
			{#red . #yellow . #blue .#purple . #brown . #magenta . #orange . #green.
			#pink . #tan . #cyan . #lightRed . #lightGreen . #lightMagenta.
			#lightOrange . #lightYellow . #paleGreen . #paleMagenta . #paleOrange.
			#palePeach . #paleRed . #lightBrown . #paleTan . #paleMagenta}
]

{ #category : #sorting }
CNBBuilder >> sortRootModels: aSetOfRootModels [
	^(aSetOfRootModels sorted: #size descending)
]

{ #category : #internal }
CNBBuilder >> startFightOverTokensBetween: rootModels [
	| multiTokenRoots allTokens |
	
	multiTokenRoots := rootModels select: [ :each | each isMultiToken or: [each isMonoToken ]].
	allTokens := (multiTokenRoots
		flatCollect: [ :each | each tokensDictionary keys ]) asSet.

	allTokens
		do: [ :aToken | 
			| fighters winner |
			fighters := (multiTokenRoots
				select: [ :aRoot | aRoot tokensDictionary includesKey: aToken ]) copy asOrderedCollection.
		
			winner := fighters
				detectMax: [ :aRM | (aRM tokensDictionary at: aToken) value ].
	
			winner dominantTokens: (winner tokensDictionary associationAt: aToken) ].
	^ rootModels
]
