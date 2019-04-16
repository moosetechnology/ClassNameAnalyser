Class {
	#name : #DMClassNameBlueprintBuilder,
	#superclass : #Object,
	#instVars : [
		'rootClasses',
		'rootClassesColors',
		'conceptsColors',
		'conceptsClasses',
		'concepts'
	],
	#category : #DMClassNameBlueprint
}

{ #category : #actions }
DMClassNameBlueprintBuilder >> attributeColorsTo: aCollection [

	| arrayOfColors index resultedColors|
	arrayOfColors := {#red . #blue . #pink . #purple . #tan . #yellow.
	#orange . #magenta . #green . #gray . #cyan . #brown . #darkGray.
	#lightBlue . #lightBrown . #lightCyan . #lightGray . #lightGreen.
	#lightMagenta . #lightOrange . #lightRed . #lightYellow . #paleBuff.
	#paleGreen . #paleMagenta . #paleOrange . #palePeach . #paleRed . #paleTan.
	#paleYellow . #black}.
	index := 0.
	resultedColors := (aCollection asBag sortedCounts) collect: [ :anAssociation | 
		(index == arrayOfColors size)
		ifFalse: [ index := index + 1 ]	.
		(anAssociation value -> (arrayOfColors at: index)).	
		 ].
	 ^ resultedColors 
]

{ #category : #actions }
DMClassNameBlueprintBuilder >> buildModelFrom: aConceptualModel [

	| viewModel |
	rootClasses := self extractAllRootClassesFrom: aConceptualModel.
	rootClassesColors := self attributeColorsTo: (rootClasses).
	concepts := (self extractAllConceptsFrom: aConceptualModel) asSet.
	viewModel := self createViewModelFrom: aConceptualModel.
	^ viewModel 
	
	
	
]

{ #category : #accessing }
DMClassNameBlueprintBuilder >> concepts [
	^concepts
]

{ #category : #accessing }
DMClassNameBlueprintBuilder >> concepts: aCollectionOfConcepts [
	concepts := aCollectionOfConcepts 
]

{ #category : #accessing }
DMClassNameBlueprintBuilder >> conceptsClasses [
	^ conceptsClasses 
]

{ #category : #accessing }
DMClassNameBlueprintBuilder >> conceptsClasses: aCollectionOfAssociations [
	conceptsClasses := aCollectionOfAssociations 
]

{ #category : #actions }
DMClassNameBlueprintBuilder >> createClassViewModelsFrom: aCollectionOfClassModels [

	| classViewModels |
	classViewModels := aCollectionOfClassModels collect: [ :aClassModel | | aClassViewModel |
		aClassViewModel := DMClassViewModel new.
		aClassViewModel classRef: (aClassModel classRef).
		aClassViewModel color: (self findColorOf: aClassViewModel classRef) value.
		 ].
	^classViewModels 
]

{ #category : #actions }
DMClassNameBlueprintBuilder >> createConceptsViewModelsFrom: aPackageModel [

	| conceptsViewModels packageConcepts |
	conceptsViewModels := OrderedCollection new.
	packageConcepts := (self extractConceptsFrom: aPackageModel) asSet.
	self conceptsClasses: (concepts collect: [ :aConcept | ((aConcept)->(OrderedCollection new)) ]) 		asDictionary.
	conceptsViewModels := packageConcepts collect: [ :aConcept | | classModels classes aConceptViewModel |
	classModels := aPackageModel classModels select: [ :aClassModel | aClassModel concept = 			aConcept].
	classes := classModels collect: [ :aClassModel | aClassModel classRef ].
	(self conceptsClasses at: aConcept) add: classes.
	aConceptViewModel := DMConceptViewModel new.
	aConceptViewModel conceptsName: aConcept.
		aConceptViewModel classViewModels: (self createClassViewModelsFrom: (classModels)).
		 ].
	^conceptsViewModels 
]

{ #category : #actions }
DMClassNameBlueprintBuilder >> createPackageViewModelsFrom: aCollectionOfPackageModels [
	
	| packageViewModels |
	packageViewModels := OrderedCollection new.
	packageViewModels := aCollectionOfPackageModels collect: [ :aPackageModel | | packageViewModel |
		packageViewModel := DMPackageViewModel new.
		packageViewModel packageName: aPackageModel packageName.
		packageViewModel conceptViewModels: (self createConceptsViewModelsFrom: aPackageModel).
		 ].
	^packageViewModels 

]

{ #category : #actions }
DMClassNameBlueprintBuilder >> createViewModelFrom: aConceptualModel [
	
	| aViewModel |
	aViewModel := DMViewModel new.
	aViewModel packageViewModels: (self createPackageViewModelsFrom: aConceptualModel packageModels).
	^aViewModel 
]

{ #category : #actions }
DMClassNameBlueprintBuilder >> extractAllConceptsFrom: aConceptualModel [

	| packageModels classModels resultedConcepts |
	rootClasses := OrderedCollection new.
	packageModels := aConceptualModel packageModels.
	classModels := packageModels flatCollect: [ :aPackageModel | aPackageModel classModels ].
	resultedConcepts := classModels collect: [ :aClassModel | aClassModel concept ].
	^ resultedConcepts asOrderedCollection 
]

{ #category : #actions }
DMClassNameBlueprintBuilder >> extractAllRootClassesFrom: aConceptualModel [

	| packageModels classModels resultedHierarchies |
	resultedHierarchies := OrderedCollection new.
	packageModels := aConceptualModel packageModels.
	classModels := packageModels flatCollect: [ :aPackageModel | aPackageModel classModels ].
	resultedHierarchies := classModels collect: [ :aClassViewModel | aClassViewModel rootClass ].
	^ resultedHierarchies asOrderedCollection.
	
	
]

{ #category : #actions }
DMClassNameBlueprintBuilder >> extractConceptsFrom: aPackageModel [

	| resultedConcepts |
	resultedConcepts := (aPackageModel classModels collect: [ :aClassModel | aClassModel concept ]).
	^resultedConcepts 
]

{ #category : #actions }
DMClassNameBlueprintBuilder >> findColorOf: aClass [ 

	| featureSelector  theRootClass color theAssociation |
	featureSelector := DMFeatureSelector new.
	theRootClass := featureSelector extractRootClassFrom: aClass.
	theAssociation := (rootClassesColors select: [ :anAssociation | 
		(anAssociation key == theRootClass)
		 ]).
	color := theAssociation value.
	^ color
]

{ #category : #actions }
DMClassNameBlueprintBuilder >> initialize [ 
	
	super initialize.
	conceptsClasses := Dictionary new.
]

{ #category : #accessing }
DMClassNameBlueprintBuilder >> rootClasses [ 
	^rootClasses 
]

{ #category : #accessing }
DMClassNameBlueprintBuilder >> rootClasses: aCollectionOfRootClasses [
	rootClasses := aCollectionOfRootClasses 
]

{ #category : #accessing }
DMClassNameBlueprintBuilder >> rootClassesColors [
	^ rootClassesColors 
]

{ #category : #accessing }
DMClassNameBlueprintBuilder >> rootClassesColors: aCollectionOfRootClassesAndTheirColors [
	rootClassesColors := aCollectionOfRootClassesAndTheirColors 
]
