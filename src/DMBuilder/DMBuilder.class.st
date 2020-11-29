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
		'conceptsClasses'
	],
	#category : #DMBuilder
}

{ #category : #'as yet unclassified' }
DMBuilder class >> buildConceptualModelFrom: aMooseModel [


	DMHierarchy initialize.
	^self new buildConceptualModelFrom: aMooseModel 
]

{ #category : #'as yet unclassified' }
DMBuilder class >> buildRootModelsFrom: aCollectionOfRoots [

	^self new buildRootModelsFrom: aCollectionOfRoots
]

{ #category : #building }
DMBuilder class >> buildViewModelFrom: aConceptualModel [

	^self new buildViewModelFrom: aConceptualModel
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
	index := 0
]
