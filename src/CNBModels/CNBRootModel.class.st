"
I am a representation of a Root Model which is the highest class in the hierarchy tree of the ClassNamesBlueprint.
"
Class {
	#name : #CNBRootModel,
	#superclass : #CNBAbstractModel,
	#instVars : [
		'reference',
		'subclasses',
		'color',
		'type',
		'suffixes',
		'size',
		'dominantSuffixes',
		'concepts',
		'prefixes',
		'scatteredSuffixes',
		'pattern'
	],
	#category : #CNBModels
}

{ #category : #'as yet unclassified' }
CNBRootModel class >> reference: aClass with: aCollectionOfSubClassModels [ 
	| rootType |
	rootType := (DMClassType with: aCollectionOfSubClassModels) type.
	^self new 
		reference: aClass;
		name: aClass name;
		subclasses: aCollectionOfSubClassModels;
		size: aCollectionOfSubClassModels size;
		suffixes: (DMBuilder doSuffixesDictionaryFrom: aCollectionOfSubClassModels);
		prefixes: (DMBuilder doPrefixesDictionaryFrom: aCollectionOfSubClassModels); 
		type: rootType.
	
	
	
	
	
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
CNBRootModel >> concepts [
	^concepts 
]

{ #category : #accessing }
CNBRootModel >> concepts: aDominantSuffix [
	concepts add: aDominantSuffix 
]

{ #category : #accessing }
CNBRootModel >> dominantSuffixes [
	^dominantSuffixes
]

{ #category : #accessing }
CNBRootModel >> dominantSuffixes: aConceptAssociation [
	dominantSuffixes add: aConceptAssociation
]

{ #category : #testing }
CNBRootModel >> hasScatteredVocabulary [

	| packageSuffixDictionary potentialCases potentialConcepts |
	packageSuffixDictionary := Dictionary new.
	" min 3 classes per suffix"
	potentialConcepts := concepts select: [ :each | 
		                     each size >= CNBPatternSelector svMinClassSize ].

	self packages do: [ :aPackageName | 
		packageSuffixDictionary
			at: aPackageName
			put:
			(potentialConcepts select: [ :each | each package = aPackageName ]) ].

	"min 3 suffixes per package"
	potentialCases := packageSuffixDictionary select: [ :each | 
		                  each value size
		                  >= CNBPatternSelector svMinSuffixSize ].
	potentialCases isNotEmpty ifTrue: [ 
		potentialCases valuesDo: [ :each | 
			each do: [ :suffix | suffix beScattered ] ] ].
	^ potentialCases isNotEmpty
]

{ #category : #initialization }
CNBRootModel >> initialize [ 	
	super initialize.
	suffixes := Dictionary new.
	dominantSuffixes := Dictionary new.
	concepts := Set new
]

{ #category : #initialization }
CNBRootModel >> initializeConcepts [
	concepts addAll: self dominantSuffixes keys
]

{ #category : #testing }
CNBRootModel >> isMonoClass [
	 type = 'monoClass'
	ifTrue: [ ^true ]
	ifFalse: [ ^false ]
]

{ #category : #testing }
CNBRootModel >> isMonoSuffix [
	type = 'monoSuffix'
	ifTrue: [ ^true ]
	ifFalse: [ ^false ]
]

{ #category : #testing }
CNBRootModel >> isMultiSuffix [
	type = 'multiSuffix'
	ifTrue: [ ^true ]
	ifFalse: [ ^false ]
]

{ #category : #accessing }
CNBRootModel >> packages [ 
	^ concepts collect: #package
]

{ #category : #accessing }
CNBRootModel >> pattern [
	^ pattern
]

{ #category : #accessing }
CNBRootModel >> pattern: aPattern [
	pattern := aPattern 
]

{ #category : #accessing }
CNBRootModel >> prefixes [
	^prefixes
	
]

{ #category : #accessing }
CNBRootModel >> prefixes: aDictionary [
	prefixes := aDictionary 
]

{ #category : #printing }
CNBRootModel >> printOn: aStream [
	super printOn: aStream. 
	aStream nextPutAll: ' ('.
	self name asString printOn: aStream.
	aStream nextPutAll: ')'
]

{ #category : #accessing }
CNBRootModel >> reference [ 
	^reference
]

{ #category : #accessing }
CNBRootModel >> reference: aClass [
	reference := aClass
]

{ #category : #initialization }
CNBRootModel >> resetConcepts [
	concepts asOrderedCollection removeAll.
	concepts := Set new
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
CNBRootModel >> suffixes [ 
	^suffixes
	
]

{ #category : #accessing }
CNBRootModel >> suffixes: suffixesDictionary [
	suffixes := suffixesDictionary
	
	
]

{ #category : #accessing }
CNBRootModel >> type [ 
	^type
]

{ #category : #accessing }
CNBRootModel >> type: aType [
	type := aType.
]
