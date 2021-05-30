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
		'size',
		'dominantTokens',
		'tokensDictionary',
		'scatteredSuffixes',
		'biggestTokenAssociation',
		'tokenModels',
		'tokenPosition',
		'maxDepth',
		'highlighted',
		'mainToken',
		'hasScatteredVocabulary'
	],
	#category : #CNBModels
}

{ #category : #creation }
CNBRootModel class >> model: aClass with: aCollectionOfSubClassModels [ 
	
	^ (self new
			model: aClass;
			subclasses: aCollectionOfSubClassModels).
		
]

{ #category : #accessing }
CNBRootModel >> biggestTokenAssociation [

	^ tokensDictionary 
	hasMoreThanOneElement ifTrue: [ tokensDictionary  detectMaxAssociation  ] 
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

	^ tokenModels anySatisfy: [ :each | (each patterns collect: #name) includes: 'Scattered Vocabulary' ]
]

{ #category : #testing }
CNBRootModel >> hasScatteredVocabularyInside: aPackageModel [

	 | electedTokens mainScatteredToken thresholdPercentage |
	self isMultiToken ifFalse: [ ^false ].
	electedTokens := tokenModels select: [ :each | each package = aPackageModel ].
	mainScatteredToken 
		:= electedTokens detect: [ :each | 
				thresholdPercentage := (CNBScatteredVocabularyPattern new threshold * 100)/each size.
					"each size >= CNBScatteredVocabularyPattern new minClassSize" 
						
						each outsidersPercentage < CNBScatteredVocabularyPattern new threshold  ] 
				ifNone: [ nil ].
		^ (electedTokens size >= CNBScatteredVocabularyPattern new minTokenSize) 
		and: [ mainScatteredToken isNotNil ].
	
]

{ #category : #'as yet unclassified' }
CNBRootModel >> hierarchyTokens [

	^ subclasses collect: #token
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
	hasScatteredVocabulary := false.
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
CNBRootModel >> isTrait [ 

	^ type = 'Trait'
]

{ #category : #accessing }
CNBRootModel >> mainToken [ 

	| classWithSimilatToken theRoot subclassesWithoutRoot |
	theRoot := subclasses detect: [ :each | each model name = self model name ] ifNone: [  ].
	
	subclassesWithoutRoot 
		:= (subclasses includes: theRoot) 
				ifTrue: [ subclasses difference: { theRoot } ] 
				ifFalse: [ subclasses ].
				
	classWithSimilatToken :=
	(subclasses
		anySatisfy: [ :aClassM | aClassM hasRootToken ]) 
		ifFalse: [ ^ self biggestTokenName ].
	
	^ token
	
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
CNBRootModel >> size: aSize [
	size := aSize 
]

{ #category : #accessing }
CNBRootModel >> subclasses [ 

	^ subclasses
]

{ #category : #accessing }
CNBRootModel >> subclasses: collection [

	subclasses := collection "remove: [ :class | class model = self model ]."
	
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
	| featureSelector prefix suffix |
	featureSelector := CNBFeatureSelector new.
	prefix := featureSelector extractPrefixFrom: name.
	suffix := featureSelector extractSuffixFrom: name.
	
	^ {  prefix . suffix }
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
