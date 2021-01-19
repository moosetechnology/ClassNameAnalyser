Class {
	#name : #DMRootModel,
	#superclass : #DMModel,
	#instVars : [
		'subclasses',
		'color',
		'type',
		'suffixes',
		'size',
		'dominantSuffixes',
		'concepts'
	],
	#category : #DMModels
}

{ #category : #'as yet unclassified' }
DMRootModel class >> reference: aClass with: aCollectionOfSubClassModels [ 
	| rootType |
	rootType := (DMBuilder classTypeWithSubclasses: aCollectionOfSubClassModels).
	^self new 
	name: aClass name;
	subclasses: aCollectionOfSubClassModels;
	size: aCollectionOfSubClassModels size;
	suffixes: (DMBuilder createSuffixesDictionaryFrom: aCollectionOfSubClassModels);
	type: rootType.
	
	
	
	
	
]

{ #category : #accessing }
DMRootModel >> color [ 
	^color
]

{ #category : #accessing }
DMRootModel >> color: aColor [
	color := aColor
]

{ #category : #accessing }
DMRootModel >> concepts [
	^concepts flattened
]

{ #category : #accessing }
DMRootModel >> concepts: aDominantSuffix [
	concepts add: aDominantSuffix 
]

{ #category : #'as yet unclassified' }
DMRootModel >> dominantSuffixes [
	^dominantSuffixes
]

{ #category : #accessing }
DMRootModel >> dominantSuffixes: aConceptAssociation [
	dominantSuffixes add: aConceptAssociation
]

{ #category : #initialization }
DMRootModel >> initialize [ 	
	super initialize.
	suffixes := Dictionary new.
	dominantSuffixes := Dictionary new.
	concepts := Set new
]

{ #category : #'as yet unclassified' }
DMRootModel >> initializeConcepts [
	concepts addAll: self dominantSuffixes keys
]

{ #category : #testing }
DMRootModel >> isMonoClass [
	 type = 'monoClass'
	ifTrue: [ ^true ]
	ifFalse: [ ^false ]
]

{ #category : #testing }
DMRootModel >> isMonoSuffix [
	type = 'monoSuffix'
	ifTrue: [ ^true ]
	ifFalse: [ ^false ]
]

{ #category : #'as yet unclassified' }
DMRootModel >> isMultiSuffix [
	type = 'multiSuffix'
	ifTrue: [ ^true ]
	ifFalse: [ ^false ]
]

{ #category : #printing }
DMRootModel >> printOn: aStream [
	super printOn: aStream. 
	aStream nextPutAll: ' ('.
	self name asString printOn: aStream.
	aStream nextPutAll: ')'
]

{ #category : #accessing }
DMRootModel >> size [
	^size
	
]

{ #category : #accessing }
DMRootModel >> size: aSize [
	size := aSize 
]

{ #category : #accessing }
DMRootModel >> subclasses [ 
	^subclasses
]

{ #category : #accessing }
DMRootModel >> subclasses: classesCollection [
	classesCollection size = 1
		& ((classesCollection at: 1) name = self name)
		ifTrue: [ size := 0 ].
	subclasses := classesCollection
		collect: [ :eachClass | eachClass classmodel ].
	
]

{ #category : #accessing }
DMRootModel >> suffixes [ 
	
	^suffixes
	
]

{ #category : #'as yet unclassified' }
DMRootModel >> suffixes: suffixesDictionary [
	suffixes := suffixesDictionary
	
	
]

{ #category : #accessing }
DMRootModel >> type [ 
	^type
]

{ #category : #'as yet unclassified' }
DMRootModel >> type: aType [
	type := aType.
]
