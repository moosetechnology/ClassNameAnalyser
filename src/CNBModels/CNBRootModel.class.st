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
		'tokenModels'
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
	^ biggestTokenAssociation
]

{ #category : #accessing }
CNBRootModel >> biggestTokenName [
	^ biggestTokenAssociation key
]

{ #category : #accessing }
CNBRootModel >> color [ 
	^color
]

{ #category : #accessing }
CNBRootModel >> color: aColor [
	color := aColor
]

{ #category : #creation }
CNBRootModel >> create [

	| aType |
	aType := (CNBClassType with: self subclasses) type.

	self 
		name: model name;
		type: aType;
		size: subclasses size;
		tokensDictionary: (CNBBuilder doTokenDictionaryFrom: subclasses).
		
		
]

{ #category : #accessing }
CNBRootModel >> dominantTokens [
	^ dominantTokens
]

{ #category : #accessing }
CNBRootModel >> dominantTokens: aConceptAssociation [
	dominantTokens add: aConceptAssociation
]

{ #category : #testing }
CNBRootModel >> hasScatteredVocabularyInside: aPackageString [

	 | electedSuffixes |
	electedSuffixes := tokenModels 
								select: [ :each | each package = aPackageString 
										and: [ each size >= CNBScatteredVocabularyPattern new  minClassSize ] ].

	^ (electedSuffixes size >= CNBScatteredVocabularyPattern new  minTokenSize)
	
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
CNBRootModel >> subclasses: aCollectionOfSubClassModels [
	subclasses := aCollectionOfSubClassModels.
	
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
CNBRootModel >> tokensDictionary [ 
	^ tokensDictionary
	
]

{ #category : #accessing }
CNBRootModel >> tokensDictionary: tokenDictionary [
	tokensDictionary := tokenDictionary.
	biggestTokenAssociation := (tokenDictionary associations detectMax: [ :each | each ]) .
	
	
]

{ #category : #accessing }
CNBRootModel >> type [ 
	^ type
]

{ #category : #accessing }
CNBRootModel >> type: aType [
	type := aType.
]
