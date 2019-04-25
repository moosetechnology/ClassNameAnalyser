Class {
	#name : #DMColorAttributor,
	#superclass : #Object,
	#category : #DMClassNameBlueprint
}

{ #category : #building }
DMColorAttributor >> attributeColors: aViewModel [

	| allConceptsViewModels allClassViewModels featureSelector hierarchies concepts 		conceptsHierarchies hierarchiesColors conceptsColors |	
	
	featureSelector := DMFeatureSelector new.					
	hierarchies := self extractAllRootClassesFrom: aViewModel.
	concepts := self extractAllConceptsFrom: aViewModel.
	conceptsHierarchies:= (concepts collect: [ :aConcept | ((aConcept)->(OrderedCollection new)) ]) 		asDictionary.
	hierarchiesColors := (self setColorsOf: hierarchies).
	allConceptsViewModels := aViewModel packageViewModels flatCollect: [ :aPackageModel | 		aPackageModel	conceptViewModels ].	
	allConceptsViewModels do: [ :aConceptViewModel | 
		| Hierarchies |
		Hierarchies := aConceptViewModel classViewModels
		collect: [ :aClassModel | featureSelector extractRootClassFrom: (aClassModel classRef) ].
		(conceptsHierarchies at: aConceptViewModel conceptName) addAll: Hierarchies ].
	
	conceptsColors := (concepts collect: [ :aConcept |
		| color conceptsBiggestHierarchy |
	conceptsBiggestHierarchy := self selectBiggestHierarchy: (conceptsHierarchies at: aConcept).	
	color := (self selectColorOf:conceptsBiggestHierarchy From: hierarchiesColors).	
		(aConcept->color) ]) asDictionary.	
						
	allConceptsViewModels do: [ :aConceptViewModel | 
		aConceptViewModel color: (self selectConceptsColor: 	aConceptViewModel conceptName From: conceptsColors) ].			
	allClassViewModels := allConceptsViewModels 
		flatCollect: [ :aConceptVModel | aConceptVModel classViewModels ].	
	allClassViewModels do: [ :aClassViewModel |
		aClassViewModel color:(self selectColorOf: (aClassViewModel classRef) From: hierarchiesColors) ].
	^aViewModel 
]

{ #category : #actions }
DMColorAttributor >> extractAllConceptsFrom: aViewModel [

	| packageViewModels conceptsViewModels  resultedConcepts |
	packageViewModels := aViewModel packageViewModels.
	conceptsViewModels := packageViewModels flatCollect: [ :aPackageViewModel | aPackageViewModel 	conceptViewModels ].
	resultedConcepts := conceptsViewModels collect: [ :aConceptViewModel | aConceptViewModel  	conceptName  ].
	^ resultedConcepts asSet
]

{ #category : #actions }
DMColorAttributor >> extractAllRootClassesFrom: aViewModel [

	| packageViewModels resultedHierarchies conceptViewModels featureSelector classViewModels |
	featureSelector := DMFeatureSelector new.
	resultedHierarchies := OrderedCollection new.
	packageViewModels := aViewModel packageViewModels.
	conceptViewModels := packageViewModels flatCollect: [ :aPackageViewModel | aPackageViewModel 	conceptViewModels  ].
	classViewModels := conceptViewModels flatCollect: [ :aConceptViewModel | aConceptViewModel 	classViewModels ].
	resultedHierarchies := classViewModels collect: [ :aClassViewModel | (featureSelector 	extractRootClassFrom: aClassViewModel classRef ) ].
	^ resultedHierarchies asOrderedCollection.
	
	
]

{ #category : #building }
DMColorAttributor >> selectBiggestHierarchy: aCollection [
	^ aCollection asBag sortedCounts first value
]

{ #category : #actions }
DMColorAttributor >> selectColorOf: aClass From: hierarchiesColors [

	| featureSelector  theRootClass color |
	featureSelector := DMFeatureSelector new.
	theRootClass := featureSelector extractRootClassFrom: aClass.
	color := hierarchiesColors at: theRootClass.
	^ color
]

{ #category : #building }
DMColorAttributor >> selectConceptsColor: aConcept From: conceptsColors [
	^ (conceptsColors at: aConcept) 
]

{ #category : #actions }
DMColorAttributor >> setColorsOf: aCollection [

	| arrayOfColors index resultedColors|
	arrayOfColors := {#red . #brown . #blue . #purple . #magenta . #orange . #green . #yellow . #pink . #tan . #gray . #cyan . #darkGray.
	#lightBlue . #lightBrown . #lightCyan . #lightGray . #lightGreen.
	#lightMagenta . #lightOrange . #lightRed . #lightYellow . #paleBuff.
	#paleGreen . #paleMagenta . #paleOrange . #palePeach . #paleRed . #paleTan.
	#paleYellow . #black}.
	index := 0.
	resultedColors := ((aCollection asBag sortedCounts) collect: [ :anAssociation | 
		(index == arrayOfColors size)
		ifFalse: [ index := index + 1 ].
		(anAssociation value -> (arrayOfColors at: index)).	
		 ]).
	 ^ resultedColors asDictionary
]
