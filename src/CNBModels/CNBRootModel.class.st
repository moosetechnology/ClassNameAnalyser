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
		'tokens',
		'scatteredSuffixes',
		'biggestTokenAssociation'
	],
	#category : #CNBModels
}

{ #category : #'as yet unclassified' }
CNBRootModel class >> reference: aClass with: aCollectionOfSubClassModels [ 
	| rootType |
	rootType := (CNBClassType with: aCollectionOfSubClassModels) type.
	^self new 
		model: aClass;
		name: aClass name;
		subclasses: aCollectionOfSubClassModels;
		size: aCollectionOfSubClassModels size;
		tokens: (CNBBuilder doTokenDictionaryFrom: aCollectionOfSubClassModels); 
		type: rootType.
	
	
	
	
	
]

{ #category : #accessing }
CNBRootModel >> biggestTokenAssociation [
	^ biggestTokenAssociation
]

{ #category : #'as yet unclassified' }
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
	electedSuffixes := tokens 
								select: [ :each | each package = aPackageString 
										and: [ each size >= CNBPatternSelector svMinClassSize ] ].

	^ (electedSuffixes size >= CNBPatternSelector svMinSuffixSize)
	
]

{ #category : #testing }
CNBRootModel >> hasVeryScatteredVocabularyInside: aPackageModel [

	| suffixesInPackage selfClassModels |
	selfClassModels := aPackageModel classModels select: [ :each | each root = self ].
	suffixesInPackage := (selfClassModels collect: #token) asSet.
	^ (suffixesInPackage size >= CNBPatternSelector scatteredThreshold)
	
]

{ #category : #initialization }
CNBRootModel >> initialize [ 	
	super initialize.
	tokens := Dictionary new.
	dominantTokens := Dictionary new.
]

{ #category : #testing }
CNBRootModel >> isMonoClass [
	 ^ type = 'monoClass'
]

{ #category : #testing }
CNBRootModel >> isMonoSuffix [
	^ type = 'monoSuffix'
]

{ #category : #testing }
CNBRootModel >> isMultiSuffix [
	^ type = 'multiSuffix'
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
	^ tokens collect: #package
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
	^subclasses
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
CNBRootModel >> tokens [ 
	^ tokens
	
]

{ #category : #accessing }
CNBRootModel >> tokens: suffixesDictionary [
	tokens := suffixesDictionary.
	biggestTokenAssociation := (suffixesDictionary associations detectMax: [ :each | each ]) .
	
	
]

{ #category : #accessing }
CNBRootModel >> type [ 
	^ type
]

{ #category : #accessing }
CNBRootModel >> type: aType [
	type := aType.
]
