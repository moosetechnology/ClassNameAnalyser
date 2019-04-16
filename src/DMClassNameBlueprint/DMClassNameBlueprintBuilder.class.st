Class {
	#name : #DMClassNameBlueprintBuilder,
	#superclass : #Object,
	#instVars : [
		'rootClasses',
		'rootClassesColors',
		'conceptsColors',
		'concepts',
		'conceptsClasses'
	],
	#classInstVars : [
		'conceptsClasses'
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

{ #category : #building }
DMClassNameBlueprintBuilder >> buildModelFrom: aConceptualModel [

	| viewModel allConceptsViewModels |
	rootClasses := self extractAllRootClassesFrom: aConceptualModel.
	rootClassesColors := self attributeColorsTo: (rootClasses).
	concepts := (self extractAllConceptsFrom: aConceptualModel) asSet.
	self conceptsHierarchies: (concepts collect: [ :aConcept | ((aConcept)->(OrderedCollection new)) ]) 		asDictionary.
	viewModel := self createViewModelFrom: aConceptualModel.
	self conceptsColors: self conceptsHierarchies deepCopy.
	self conceptsColors: (concepts collect: [ :aConcept | (aConcept)-> (self findColorOf: ((self selectBiggestHierarchy: (conceptsClasses at: aConcept)))) ] ) asDictionary.
	allConceptsViewModels := viewModel packageViewModels flatCollect: [ :aPackageModel | aPackageModel conceptViewModels ].
	allConceptsViewModels do: [ :aConceptViewModel | aConceptViewModel color: (self selectConceptsColor: aConceptViewModel conceptsName)  ].
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
DMClassNameBlueprintBuilder >> conceptsColors [
	^conceptsColors 
]

{ #category : #accessing }
DMClassNameBlueprintBuilder >> conceptsColors: aCollectionOfAssociation [
	conceptsColors := aCollectionOfAssociation 
]

{ #category : #accessing }
DMClassNameBlueprintBuilder >> conceptsHierarchies [ 
	^ conceptsClasses
]

{ #category : #accessing }
DMClassNameBlueprintBuilder >> conceptsHierarchies: aCollectionOfAssociations [
	conceptsClasses := aCollectionOfAssociations 
]

{ #category : #building }
DMClassNameBlueprintBuilder >> createClassViewModelsFrom: aCollectionOfClassModels [

	| classViewModels |
	classViewModels := aCollectionOfClassModels collect: [ :aClassModel | | aClassViewModel |
		aClassViewModel := DMClassViewModel new.
		aClassViewModel classRef: (aClassModel classRef).
		aClassViewModel color: (self findColorOf: aClassViewModel classRef) value.
		 ].
	^classViewModels 
]

{ #category : #building }
DMClassNameBlueprintBuilder >> createConceptsViewModelsFrom: aPackageModel [

	| conceptsViewModels packageConcepts |
	conceptsViewModels := OrderedCollection new.
	packageConcepts := (self extractConceptsFrom: aPackageModel) asSet.
	conceptsViewModels := packageConcepts collect: [ :aConcept | | classModels hierarchies aConceptViewModel |
	classModels := aPackageModel classModels select: [ :aClassModel | aClassModel concept = 			aConcept].
	hierarchies := classModels collect: [ :aClassModel | aClassModel rootClass ].
	(self conceptsHierarchies at: aConcept) addAll: hierarchies.
	aConceptViewModel := DMConceptViewModel new.
	aConceptViewModel conceptsName: aConcept.
		aConceptViewModel classViewModels: (self createClassViewModelsFrom: (classModels)).
		 ].
	^conceptsViewModels 
]

{ #category : #building }
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

{ #category : #building }
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

	| featureSelector  theRootClass color selectedItem |
	featureSelector := DMFeatureSelector new.
	theRootClass := featureSelector extractRootClassFrom: aClass.
	selectedItem := (rootClassesColors select: [ :anAssociation | 
		(anAssociation key == theRootClass)
		 ]).
	color := (selectedItem at: 1) value.
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

{ #category : #building }
DMClassNameBlueprintBuilder >> selectBiggestHierarchy: aCollection [
	^ aCollection asBag sortedCounts first value
]

{ #category : #building }
DMClassNameBlueprintBuilder >> selectConceptsColor: aConcept [
	^ conceptsColors at: aConcept 
]
