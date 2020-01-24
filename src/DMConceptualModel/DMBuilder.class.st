Class {
	#name : #DMBuilder,
	#superclass : #Object,
	#instVars : [
		'palette',
		'index'
	],
	#classInstVars : [
		'conceptsClasses'
	],
	#category : #DMConceptualModel
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

{ #category : #'as yet unclassified' }
DMBuilder >> aColorFromPalette [

	"we have 24 important colors"
	index := index +1.
	(index <= 24)
	ifTrue: [ ^palette at: index ].
	
	^#black
]

{ #category : #'as yet unclassified' }
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

{ #category : #'as yet unclassified' }
DMBuilder >> buildClassViewModelsFrom: aCollectionOfClassModels [

	^DMClassModelGroup new addAll: (aCollectionOfClassModels collect: [ :aClassModel | 
		DMClassViewModel new name: (aClassModel name); root: aClassModel root; color: 'not yet identified'; concept: aClassModel name.
		 ]).
]

{ #category : #'as yet unclassified' }
DMBuilder >> buildConceptViewModelsFrom: aPackageModel [

	| concepts |
	concepts := (self extractConceptsFrom: aPackageModel) asSet.

	^DMConceptModelGroup new addAll: 
	(concepts collect: [ :aConcept | 
		DMConceptViewModel 
		name: aConcept 
		with: (self buildClassViewModelsFrom: 
		(aPackageModel classmodels 
		select: [ :aClassModel | aClassModel concept = aConcept])).
		 ])
	
]

{ #category : #'as yet unclassified' }
DMBuilder >> buildConceptualModelFrom: aMooseModel [

		
		^DMConceptualModel 
		name: aMooseModel name 
		with: (((aMooseModel allModelNamespaces ifEmpty: aMooseModel allModelPackages) asMooseGroup) 		conceptualPackageModels)
]

{ #category : #'as yet unclassified' }
DMBuilder >> buildPackageViewModelsFrom: aConceptualModel [
 
	 
	^DMPackageModelGroup new addAll:(
		aConceptualModel packagemodels collect: [ :packageModel | DMPackageViewModel
		name: (packageModel name)
		with: (self buildConceptViewModelsFrom: packageModel)]).
 
]

{ #category : #'as yet unclassified' }
DMBuilder >> buildRootModelsFrom: aCollectionOfRoots [

	| collection |
	self initialize.
	collection := OrderedCollection new.
	aCollectionOfRoots associationsDo: [ :anAssociation | collection add: (DMRootModel new 
		name: 	anAssociation key name;
		concept: anAssociation key classmodel concept;
		subclasses: (DMClassModelGroup new addAll: (anAssociation value));
		type: 	(self classTypeWithSubclasses: anAssociation value);
		color: (self attributeColorByType: (self classTypeWithSubclasses: anAssociation value)) ). ].
	^collection.
			

	
]

{ #category : #building }
DMBuilder >> buildViewModelFrom: aConceptualModel [

	| viewmodel |
	viewmodel := DMViewModel new
	name: aConceptualModel name.
	DMHierarchy initializeRoots.
	viewmodel packageViewModels: (self buildPackageViewModelsFrom: aConceptualModel). 
	viewmodel hierarchies: (DMHierarchy rootmodels).
	DMHierarchy rootsANDclasses removeAll.
	^viewmodel
]

{ #category : #'as yet unclassified' }
DMBuilder >> classTypeWithSubclasses: aSet [

	(aSet value isTrait)
	ifTrue: [ ^ #Trait ].
	
	(aSet size == 1)
	ifTrue: [ ^ #monoClass ].
	
	((aSet collect: [ :each | each concept ]) asSet size == 1)
	ifTrue: [ ^ #monoSuffix ].
	
	^ #multiSuffix
]

{ #category : #actions }
DMBuilder >> extractConceptsFrom: aPackageModel [

	^aPackageModel classmodels collect: [ :aClassModel | aClassModel concept ]
]

{ #category : #'as yet unclassified' }
DMBuilder >> initialize [

	super initialize.
	palette := {#red . #yellow . #blue . #purple . #magenta . #orange . #green . #pink . #tan  . #cyan . #lightBlue . #lightBrown . #lightCyan  . #lightGreen.
	#lightMagenta . #lightOrange . #lightRed .
	#paleGreen . #paleMagenta . #paleOrange . #palePeach . #paleRed . #paleTan . #black}.
	index := 0
]
