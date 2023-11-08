"
I am a representation of a Root Model which is the highest class in the hierarchy tree of the ClassNamesBlueprint.
"
Class {
	#name : #CNBRootModel,
	#superclass : #CNBAbstractModel,
	#traits : 'CNBTRootOrganizer',
	#classTraits : 'CNBTRootOrganizer classTrait',
	#instVars : [
		'model',
		'subclasses',
		'token',
		'color',
		'type',
		'dominantTokens',
		'tokensDictionary',
		'scatteredSuffixes',
		'biggestTokenAssociation',
		'tokenModels',
		'tokenPosition',
		'maxDepth',
		'highlighted',
		'mainToken',
		'isScattered',
		'nearlyHomogeneous'
	],
	#category : #CNBModels
}

{ #category : #creation }
CNBRootModel class >> model: aClass with: aCollectionOfSubClassModels [ 
	
	^ (self new
			model: aClass;
			subclasses: aCollectionOfSubClassModels).
		
]

{ #category : #attribution }
CNBRootModel >> attributePatterns [ 
	self checkPatterns.
]

{ #category : #accessing }
CNBRootModel >> biggestTokenAssociation [

	^ tokensDictionary 
	hasMoreThanOneElement ifTrue: [ tokensDictionary detectMaxAssociation  ] 
	ifFalse: [ tokensDictionary associations first  ]
]

{ #category : #accessing }
CNBRootModel >> biggestTokenName [
	
	^ self biggestTokenAssociation key
]

{ #category : #'as yet unclassified' }
CNBRootModel >> changeColorTo: aColor [

	self color: aColor.
	self tokenModels do: [ :each | each changeColorTo: aColor ]
]

{ #category : #testing }
CNBRootModel >> checkHomogeneous [
	self isMonoToken ifTrue: [ tokenModels do: [ :each | each patterns add: CNBHomogeneousPattern new ]]
]

{ #category : #testing }
CNBRootModel >> checkNearlyHomogeneous [ 
	CNBNearlyHomogeneous new check: self
]

{ #category : #attribution }
CNBRootModel >> checkPatterns [ 
	self 
		checkHomogeneous;
		checkScatteredVocabulary;
		checkNearlyHomogeneous.
]

{ #category : #testing }
CNBRootModel >> checkScatteredVocabulary [
	CNBScatteredVocabularyPattern new check: self
]

{ #category : #accessing }
CNBRootModel >> children [ 

	^ ((subclasses collect: #model) includes: self model )
			ifTrue: [ subclasses size - 1 ]
			ifFalse: [ subclasses size ]

]

{ #category : #accessing }
CNBRootModel >> color [ 

	^ color
]

{ #category : #accessing }
CNBRootModel >> color: aColor [

	color := aColor
]

{ #category : #accessing }
CNBRootModel >> dominantTokens [

	^ dominantTokens
]

{ #category : #accessing }
CNBRootModel >> dominantTokens: association [

	dominantTokens add: association
]

{ #category : #accessing }
CNBRootModel >> hasScatteredVocabulary [ 
	isScattered := true.
	tokenModels do: [ :each | each patterns add: CNBScatteredVocabularyPattern new ]
	
	
]

{ #category : #testing }
CNBRootModel >> hasScatteredVocabularyInside: aPackageModel [

	 | electedTokens mainScatteredToken  |
	self isMultiToken ifFalse: [ ^false ].
	"tokens that belong to this root in the package"
	electedTokens := tokenModels select: [ :each | each package = aPackageModel ].
	""
	mainScatteredToken 
		:= electedTokens detect: [ :each | 
			| outsidersPercentage threshold |
			"Threshold of outsiders compared to belongers"
			threshold := (CNBScatteredVocabularyPattern new threshold: each belongers size).
			"Outsiders percentage compared to belongers"
			outsidersPercentage := ((each outsiders size * each belongers size)/100) asFloat.
						
			each belongers isNotEmpty 
				and: [ outsidersPercentage < threshold 
					and: [ each size >= CNBScatteredVocabularyPattern new minClassSize] ] ] ifNone: [nil].
	
		^(electedTokens size >= CNBScatteredVocabularyPattern new minTokenSize) 
		and: [ mainScatteredToken isNotNil ].	

]

{ #category : #'as yet unclassified' }
CNBRootModel >> hierarchyTokens [

	^ (subclasses collect: #token) asSet
]

{ #category : #accessing }
CNBRootModel >> highlighted [
	
	^ highlighted 
]

{ #category : #accessing }
CNBRootModel >> highlighted: aBoolean [
	
	highlighted := aBoolean 
]

{ #category : #initialization }
CNBRootModel >> initialize [ 	
	super initialize.
	
	tokensDictionary := Dictionary new.
	dominantTokens := Dictionary new.
	highlighted := false.
	isScattered := false.
	nearlyHomogeneous := false

]

{ #category : #accessing }
CNBRootModel >> initializeToken [ 
	| rootTokens subclassTokens |
	
	rootTokens := CNBFeatureSelector new tokensOf: name.
	subclassTokens := (self subclassesWithoutRoot collect: #token).
	self token: (self tokens detect: [ :each | subclassTokens includes: each ] ifNone:  [ self tokens last ]).
]

{ #category : #testing }
CNBRootModel >> isMonoClass [

	 ^ type = 'monoClass'
]

{ #category : #testing }
CNBRootModel >> isMonoToken [

	^ type = 'monoToken'
]

{ #category : #testing }
CNBRootModel >> isMultiToken [

	^ type = 'multiToken'
]

{ #category : #testing }
CNBRootModel >> isNearlyHomogeneous [ 
	nearlyHomogeneous := true.
	tokenModels do: [ :each | each patterns add: CNBNearlyHomogeneous new ] 
]

{ #category : #accessing }
CNBRootModel >> isScattered [ 
	^ isScattered 
]

{ #category : #testing }
CNBRootModel >> isTrait [ 

	^ type = 'Trait'
]

{ #category : #accessing }
CNBRootModel >> mainToken [ 
	| classWithSimilatToken |
	
	classWithSimilatToken :=
	(self subclassesWithoutRoot 
		anySatisfy: [ :aClassM | aClassM hasRootToken ]) ifTrue: [ ^ self token ].
	
	^ self biggestTokenName  
	
]

{ #category : #accessing }
CNBRootModel >> maxDepth [
	
	^ (subclasses detectMax: [ :each | each depth ]) depth
]

{ #category : #accessing }
CNBRootModel >> model [ 

	^ model
]

{ #category : #accessing }
CNBRootModel >> model: aClass [

	model := aClass
]

{ #category : #accessing }
CNBRootModel >> nearlyHomogeneous [
	^ nearlyHomogeneous
]

{ #category : #testing }
CNBRootModel >> occurrencesOf: aTokenName [
	^ tokensDictionary at: aTokenName 

	
]

{ #category : #accessing }
CNBRootModel >> packages [ 

	^ tokenModels collect: #package
]

{ #category : #printing }
CNBRootModel >> printOn: aStream [

	super printOn: aStream. 
	aStream nextPutAll: ' ('.
	self name asString printOn: aStream.
	aStream nextPutAll: ')'
]

{ #category : #'as yet unclassified' }
CNBRootModel >> reduceToken: aTokenName [
	

	tokensDictionary at: aTokenName update: [ :value | value - 1 ].

	

]

{ #category : #removing }
CNBRootModel >> removeAllSuchThat: aBlock [

	tokenModels removeAllSuchThat: aBlock
]

{ #category : #removing }
CNBRootModel >> removeToken: aTokenName [

	 dominantTokens removeKey: aTokenName ifAbsent: [  ].
	 tokensDictionary removeKey: aTokenName ifAbsent: [  ].
	self tokenModels removeAllSuchThat: [ :each | each name = aTokenName ].
]

{ #category : #removing }
CNBRootModel >> removeUnnecessaryTokens [

	tokensDictionary 
		:= (tokensDictionary associations reject: [ :each | each value isZero ]) asDictionary 
	
]

{ #category : #accessing }
CNBRootModel >> size [ 
	^ subclasses size
]

{ #category : #accessing }
CNBRootModel >> subclasses [ 

	^ subclasses
]

{ #category : #accessing }
CNBRootModel >> subclasses: collection [

	subclasses := collection
]

{ #category : #'as yet unclassified' }
CNBRootModel >> subclassesWithoutRoot [

	| theRoot |
	theRoot := subclasses detect: [ :each | each model name = self model name ] ifNone: [  ].
	^ (subclasses includes: theRoot) 
				ifTrue: [ subclasses difference: { theRoot } ] 
				ifFalse: [ subclasses ].
]

{ #category : #accessing }
CNBRootModel >> suspisciousTokens [ 
	
	^ (subclasses select: [ :each | each token ~= self mainToken ]) size
]

{ #category : #accessing }
CNBRootModel >> token [ 
	^ token
]

{ #category : #accessing }
CNBRootModel >> token: aToken [

  token := aToken
	
]

{ #category : #accessing }
CNBRootModel >> tokenModels [

	^ tokenModels
]

{ #category : #accessing }
CNBRootModel >> tokenModels: aCollection [

	tokenModels := aCollection 
]

{ #category : #accessing }
CNBRootModel >> tokenPosition [
	^ tokenPosition
]

{ #category : #accessing }
CNBRootModel >> tokenPosition: suffixOrPrefix [
	 tokenPosition := suffixOrPrefix
]

{ #category : #accessing }
CNBRootModel >> tokens [ 
	^ CNBFeatureSelector new tokensOf: self name
]

{ #category : #accessing }
CNBRootModel >> tokensDictionary [ 

	^ tokensDictionary
	
]

{ #category : #accessing }
CNBRootModel >> tokensDictionary: tokenDictionary [

	tokensDictionary := tokenDictionary.
	
	
]

{ #category : #'instance creation' }
CNBRootModel >> tokensIn: aPackageViewModel [
	
		^ tokenModels select: [ :each | each package packageViewModel = aPackageViewModel ]
	
]

{ #category : #accessing }
CNBRootModel >> type [ 

	^ type
]

{ #category : #accessing }
CNBRootModel >> type: aType [

	type := aType.
]
