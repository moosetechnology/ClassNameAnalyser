"
I am a representation of a Root Model which is the highest class in the hierarchy tree of the ClassNamesBlueprint.
"
Class {
	#name : #CNBRootModel,
	#superclass : #CNBAbstractModel,
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
		'tokenPosition'
	],
	#category : #CNBModels
}

{ #category : #creation }
CNBRootModel class >> model: aClass with: aCollectionOfSubClassModels [ 
	
	^ (self new
			model: aClass;
			subclasses: aCollectionOfSubClassModels) create.
		
]

{ #category : #accessing }
CNBRootModel >> biggestTokenAssociation [

	^ tokensDictionary associations detectMax: [ :each | each ]
]

{ #category : #accessing }
CNBRootModel >> biggestTokenName [

	^ biggestTokenAssociation key
]

{ #category : #'as yet unclassified' }
CNBRootModel >> changeTokenPosition: electedTokens [ 
	| newTokens newTokenPosition |
	
	newTokenPosition 
		:= (tokenPosition = #prefix) ifTrue: [ #suffix ] ifFalse: [ #prefix ].
		
	newTokens
			:= (electedTokens 
					flatCollect: #classViewModels) 
						collect: [ :each | CNBFeatureSelector new extract: newTokenPosition from: each name].
	^ newTokens asSet 
				collect: [ :aToken | 
					CNBTokenViewModel 
						of: aToken 
						root: self
						with: ((electedTokens flatCollect: #classViewModels)
								select: [ :aClass | 
									(CNBFeatureSelector new extract: newTokenPosition from: aClass name) = aToken ])
						in: (electedTokens first package).
			 ]
]

{ #category : #accessing }
CNBRootModel >> color [ 

	^ color
]

{ #category : #accessing }
CNBRootModel >> color: aColor [

	color := aColor
]

{ #category : #creation }
CNBRootModel >> create [

	self 
		name: model name;
		type: (CNBClassType 
					with: self subclasses) type;
		token: (CNBFeatureSelector new 
					extract: subclasses atRandom setting 
					from: model name);
		size: subclasses size;
		tokenPosition: subclasses atRandom setting token;
		tokensDictionary: (CNBBuilder doTokenDictionaryFrom: subclasses).
		
		
]

{ #category : #accessing }
CNBRootModel >> dominantTokens [

	^ dominantTokens
]

{ #category : #accessing }
CNBRootModel >> dominantTokens: association [

	dominantTokens add: association
]

{ #category : #testing }
CNBRootModel >> hasScatteredVocabularyInside: aPackageViewModel [

	 | electedTokens |
	
	electedTokens := tokenModels 
								select: [ :each | each package name = aPackageViewModel name
										and: [ each size >= CNBScatteredVocabularyPattern new  minClassSize ]].
	
	^ (electedTokens size >= CNBScatteredVocabularyPattern new minTokenSize)
	
]

{ #category : #testing }
CNBRootModel >> hasVeryScatteredVocabularyInside: aPackageModel [

	| tokenInPackage selfClassModels |
	selfClassModels := aPackageModel classModels select: [ :each | each root = self ].
	tokenInPackage := (selfClassModels collect: #token) asSet.

	^ (tokenInPackage size >= CNBScatteredVocabularyPattern new  scatteredThreshold)
	
]

{ #category : #initialization }
CNBRootModel >> initialize [ 	
	super initialize.
	
	tokensDictionary := Dictionary new.
	dominantTokens := Dictionary new.
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
CNBRootModel >> model [ 

	^ model
]

{ #category : #accessing }
CNBRootModel >> model: aClass [

	model := aClass
]

{ #category : #accessing }
CNBRootModel >> name: aName [
	super name: aName.
	
	token := CNBFeatureSelector new extractSuffixFrom: aName
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

{ #category : #removing }
CNBRootModel >> removeAllSuchThat: aBlock [

	tokenModels removeAllSuchThat: aBlock
]

{ #category : #'as yet unclassified' }
CNBRootModel >> scatteredSubclassesInside: aPackageModel [ 

	
]

{ #category : #accessing }
CNBRootModel >> size [

	^ size
	
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

	subclasses := collection.
	
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
