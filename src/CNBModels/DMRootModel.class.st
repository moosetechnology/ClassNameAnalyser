"
I am a representation of a Root Model which is the highest class in the hierarchy tree of the ClassNamesBlueprint.
"
Class {
	#name : #DMRootModel,
	#superclass : #DMModel,
	#instVars : [
		'reference',
		'subclasses',
		'color',
		'type',
		'suffixes',
		'size',
		'dominantSuffixes',
		'concepts'
	],
	#category : #CNBModels
}

{ #category : #'as yet unclassified' }
DMRootModel class >> reference: aClass with: aCollectionOfSubClassModels [ 
	| rootType |
	rootType := (DMClassType with: aCollectionOfSubClassModels) type.
	^self new 
		reference: aClass;
		name: aClass name;
		subclasses: aCollectionOfSubClassModels;
		size: aCollectionOfSubClassModels size;
		suffixes: (DMBuilder doSuffixesDictionaryFrom: aCollectionOfSubClassModels);
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

{ #category : #accessing }
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

{ #category : #initialization }
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

{ #category : #testing }
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
DMRootModel >> reference [ 
	^reference
]

{ #category : #accessing }
DMRootModel >> reference: aClass [
	reference := aClass
]

{ #category : #accessing }
DMRootModel >> size [
	^ subclasses size
	
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
DMRootModel >> subclasses: aCollectionOfSubClassModels [

	subclasses := aCollectionOfSubClassModels.
	
]

{ #category : #accessing }
DMRootModel >> suffixes [ 
	
	^suffixes
	
]

{ #category : #accessing }
DMRootModel >> suffixes: suffixesDictionary [
	suffixes := suffixesDictionary
	
	
]

{ #category : #accessing }
DMRootModel >> type [ 
	^type
]

{ #category : #accessing }
DMRootModel >> type: aType [
	type := aType.
]
