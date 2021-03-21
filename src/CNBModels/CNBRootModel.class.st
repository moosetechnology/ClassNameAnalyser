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
		'tokenPosition',
		'number'
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

	^ tokensDictionary associations detectMax: [ :each | each ]
]

{ #category : #accessing }
CNBRootModel >> biggestTokenName [

	^ biggestTokenAssociation key
]

{ #category : #'as yet unclassified' }
CNBRootModel >> changeColorTo: aColor [

	self color: aColor.
	self tokenModels do: [ :each | each changeColorTo: aColor ]
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

	 dominantTokens removeKey: aTokenName.
	 tokensDictionary removeKey: aTokenName.
	self tokenModels removeAllSuchThat: [ :each | each name = aTokenName ].
]

{ #category : #removing }
CNBRootModel >> removeUnnecessaryTokens [

	tokensDictionary 
		:= (tokensDictionary associations reject: [ :each | each value isZero ]) asDictionary 
	
]

{ #category : #'as yet unclassified' }
CNBRootModel >> scatteredSubclassesInside: aPackageModel [ 

	
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
