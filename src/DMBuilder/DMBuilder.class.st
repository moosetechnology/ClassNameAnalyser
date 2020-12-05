Class {
	#name : #DMBuilder,
	#superclass : #Object,
	#traits : 'DMTBuilder + DMTColorAttributor + DMTDataExtractor',
	#classTraits : 'DMTBuilder classTrait + DMTColorAttributor classTrait + DMTDataExtractor classTrait',
	#instVars : [
		'palette',
		'index'
	],
	#classInstVars : [
		'rootmodels',
		'conceptualmodel'
	],
	#category : #DMBuilder
}

{ #category : #accessing }
DMBuilder class >> conceptualmodel [
	^conceptualmodel 
]

{ #category : #accessing }
DMBuilder class >> conceptualmodel: aConceptualModel [ 
	conceptualmodel := aConceptualModel 
]

{ #category : #accessing }
DMBuilder class >> rootmodels [
	^rootmodels
]

{ #category : #accessing }
DMBuilder class >> rootmodels: collectionOfRootModels [
	rootmodels := collectionOfRootModels 
]

{ #category : #coloring }
DMBuilder >> aColorFromPalette [

	"we have 24 important colors"
	index := index +1.
	(index <= 24)
	ifTrue: [ ^palette at: index ].
	
	^#black
]

{ #category : #coloring }
DMBuilder >> attributeColorByType: aType [

	(aType == #Trait)
	ifTrue: [ ^ #white ].
	
	(aType == #monoClass)
	ifTrue: [ ^ #white ].
	
	(aType == #monoSuffix)
	ifTrue: [ ^#gray ].
	
	(aType == #multiSuffix)
	ifTrue: [ ^self aColorFromPalette ].
]

{ #category : #initialize }
DMBuilder >> initialize [

	super initialize.
	palette := {#red . #yellow . #blue . #purple . #magenta . #orange . #green . #pink . #tan  . #cyan . #lightBlue . #lightBrown . #lightCyan  . #lightGreen.
	#lightMagenta . #lightOrange . #lightRed .
	#paleGreen . #paleMagenta . #paleOrange . #palePeach . #paleRed . #paleTan . #black}.
	index := 0.
]

{ #category : #accessing }
DMBuilder >> sortRootModels [.
	self class rootmodels sorted: #size descending
]

{ #category : #accessing }
DMBuilder >> sortRootModels: aSetOfRootModels [
	^(aSetOfRootModels sorted: #size descending)
]
