Class {
	#name : #DMClassNameBlueprintBuilder,
	#superclass : #Object,
	#instVars : [
		'rootClasses',
		'rootClassesColors'
	],
	#category : #DMClassNameBlueprint
}

{ #category : #'as yet unclassified' }
DMClassNameBlueprintBuilder >> attributeColorsTo: aCollectionOfRootClasses [

	| arrayOfColors index |
	arrayOfColors := {#red . #blue . #pink . #purple . #tan . #yellow.
	#orange . #magenta . #green . #gray . #cyan . #brown . #darkGray.
	#lightBlue . #lightBrown . #lightCyan . #lightGray . #lightGreen.
	#lightMagenta . #lightOrange . #lightRed . #lightYellow . #paleBuff.
	#paleGreen . #paleMagenta . #paleOrange . #palePeach . #paleRed . #paleTan.
	#paleYellow . #black}.
	index := 0.
	rootClassesColors := (aCollectionOfRootClasses asBag sortedCounts) collect: [ :anAssociation | 
		(index == arrayOfColors size)
		ifFalse: [ index := index + 1 ]	.
		(anAssociation value -> (arrayOfColors at: index)).	
		 ].
	 ^ rootClassesColors 
]

{ #category : #'as yet unclassified' }
DMClassNameBlueprintBuilder >> buildModelFrom: aConceptualModel [

	| viewModel |
	rootClasses := self extractAllRootClassesFrom: aConceptualModel.
	rootClassesColors := self attributeColorsTo: (rootClasses).
	viewModel := self createViewModelFrom: aConceptualModel.
	^ viewModel 
	
	
	
]

{ #category : #'as yet unclassified' }
DMClassNameBlueprintBuilder >> createClassViewModelsFrom: aCollectionOfClassModels [

	| classViewModels |
	classViewModels := aCollectionOfClassModels collect: [ :aClassModel | | aClassViewModel |
		aClassViewModel := DMClassViewModel new.
		aClassViewModel theClass: (aClassModel theClass).
		aClassViewModel color: (self findColorOf: aClassViewModel theClass).
		 ].
	^classViewModels 
]

{ #category : #'as yet unclassified' }
DMClassNameBlueprintBuilder >> createConceptsViewModelsFrom: aPackageModel [

	| conceptsViewModels  classModels conceptsBag |
	conceptsViewModels := OrderedCollection new.
	conceptsBag := self extractConceptsFrom: aPackageModel.
	conceptsViewModels := conceptsBag collect: [ :aConceptAssociation | 
		| aConceptViewModel |
		aConceptViewModel := DMConceptViewModel new.
		aConceptViewModel conceptsName: aConceptAssociation value.
		classModels := aPackageModel classModels select: [ :aClassModel | 
			(aClassModel concept == aConceptViewModel conceptsName) ].
		aConceptViewModel classViewModels: (self createClassViewModelsFrom: classModels)
		 ].
	^ conceptsViewModels 
	
]

{ #category : #'as yet unclassified' }
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

{ #category : #'as yet unclassified' }
DMClassNameBlueprintBuilder >> createViewModelFrom: aConceptualModel [
	
	| aViewModel |
	aViewModel := DMViewModel new.
	aViewModel packageViewModels: (self createPackageViewModelsFrom: aConceptualModel packageModels).
	^aViewModel 
]

{ #category : #'as yet unclassified' }
DMClassNameBlueprintBuilder >> extractAllRootClassesFrom: aConceptualModel [

	| packageModels classModels |
	rootClasses := OrderedCollection new.
	packageModels := aConceptualModel packageModels.
	classModels := packageModels flatCollect: [ :aPackageModel | aPackageModel classModels ].
	rootClasses := classModels collect: [ :aClassViewModel | aClassViewModel rootClass ].
	^ rootClasses asOrderedCollection.
	
	
]

{ #category : #'as yet unclassified' }
DMClassNameBlueprintBuilder >> extractConceptsFrom: aPackageModel [

	| conceptsBag |
	conceptsBag := (aPackageModel classModels collect: [ :aClassModel | aClassModel concept ]) asBag.
	^ conceptsBag 
]

{ #category : #'as yet unclassified' }
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
