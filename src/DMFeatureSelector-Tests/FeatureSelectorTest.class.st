Class {
	#name : #FeatureSelectorTest,
	#superclass : #TestCase,
	#instVars : [
		'featureSelector'
	],
	#category : #'DMFeatureSelector-Tests'
}

{ #category : #running }
FeatureSelectorTest >> setUp [ 
	featureSelector := DMFeatureSelector new.
]

{ #category : #tests }
FeatureSelectorTest >> testApplyFeaturesOn [

	| conceptualModel |	
	conceptualModel := featureSelector applyFeaturesOn: { 'Kernel' . 'DMFeatureSelector' }.
	self assert: (conceptualModel packageModels size) equals: 2.
	self assert: (conceptualModel packageModels at: 1) packageName equals: 'Kernel'.
	self assert: (conceptualModel packageModels at: 2) packageName equals: 'DMFeatureSelector'.
	self assert: (conceptualModel packageModels at: 1) classModels size equals: (RPackageOrganizer default packageNamed: 'Kernel') 	definedClasses size.
	
	
]

{ #category : #tests }
FeatureSelectorTest >> testEXtractConceptFromAClassName [

	| classModel aConcept |
	classModel := DMClassModel new.
	featureSelector 
		filterAllDigits: true; 
		filterAllDigitsAndSpecialChars: true; 
		stemming: true; 	
		selectLastSymbol: true. 	
	aConcept := featureSelector extractConceptFrom: DMPackageModel name.
	self assert: aConcept equals: 'model'.
	
]

{ #category : #tests }
FeatureSelectorTest >> testExtractConceptFrom [

	self assert: (featureSelector extractConceptFrom: 'ClassName') equals: 'Name'
]

{ #category : #tests }
FeatureSelectorTest >> testExtractConceptFromNameByDefault [
	"extracts the last symbol by default, the last word in CamelCase without any filters"
	
	self assert: (featureSelector extractConceptFrom: 'ClassName34Blueprint') equals: 'Blueprint'.
	self assert: (featureSelector extractConceptFrom: 'ClassName34') equals: 'Name34'.
	self assert: (featureSelector extractConceptFrom: '%ClassName34%') equals: 'Name34%'.
	self assert: (featureSelector extractConceptFrom: '%Class%') equals: 'Class%'.
]

{ #category : #tests }
FeatureSelectorTest >> testExtractRootClassFromObjectClass [

	| expectedRootClass classModel |
	classModel := DMClassModel new.
	featureSelector
		filterAllDigits: true; 
		stemming: true; 
		selectFirstSymbol: true.
	expectedRootClass := Object.
	classModel classRef: Object.
	classModel conceptName: (featureSelector extractConceptFrom: Object name).
	classModel rootClass: (featureSelector extractRootClassFrom: Object).
	self assert: expectedRootClass equals: Object.

]

{ #category : #tests }
FeatureSelectorTest >> testExtractRootClassNoHierarchy [

	| expectedRootClass actualRootClass classModel |
	
	expectedRootClass := DMClassModel.
	classModel := DMClassModel new.
	featureSelector 
		filterAllDigits: true; 
		stemming: true; 
		selectFirstSymbol: true.
	classModel classRef: DMClassModel.
	classModel conceptName: (featureSelector extractConceptFrom: (DMClassModel name)).
	classModel rootClass: (featureSelector extractRootClassFrom: DMClassModel).
	actualRootClass := DMClassModel.
	self assert: actualRootClass equals: expectedRootClass.

]

{ #category : #tests }
FeatureSelectorTest >> testFilterAllDigitsFirstSymbol [

	| expected actual |
	actual := featureSelector 
					filterAllDigits: true ; 
					selectFirstSymbol: true;
					extractConceptFrom: '12ClassName34Blueprint56'.
	expected := ''.
	self assert: actual equals: expected.
]

{ #category : #tests }
FeatureSelectorTest >> testFilterAllSpecialCharsFirstSymbol [

	| expected actual |
	actual := featureSelector 
					filterSpecialChars: true ; 
					selectFirstSymbol: true;
					extractConceptFrom: '12ClassName34Blueprint%./?'.
	expected := '12'.
	self assert: actual equals: expected.
]

{ #category : #tests }
FeatureSelectorTest >> testFilterAllSpecialCharsLastSymbol [

	| expected actual |
	actual := featureSelector 
					filterSpecialChars: true ; 
					selectLastSymbol: true;
					extractConceptFrom: '12ClassName34Blueprint%./?'.
	expected := 'Blueprint'.
	self assert: actual equals: expected.
]

{ #category : #tests }
FeatureSelectorTest >> testFilterAllSpecialCharsMiddleSymbol [

	| expected actual |
	actual := featureSelector 
					filterSpecialChars: true ; 
					selectMiddleSymbol: true;
					extractConceptFrom: '12ClassName34Blueprint%./?'.
	expected := 'Name34'.
	self assert: actual equals: expected.
]

{ #category : #tests }
FeatureSelectorTest >> testFilterBothDigitsAndSpecialCharsFirstSymbol [

	| expected actual |
	actual := featureSelector 	
					filterAllDigitsAndSpecialChars: true; 
					selectFirstSymbol: true;
					extractConceptFrom: '12ClassName34Blueprint5%6/78'.							 							
	expected := ''.
	self assert: actual equals: expected.
]

{ #category : #tests }
FeatureSelectorTest >> testFilterBothDigitsAndSpecialCharsLastSymbol [

	| expected actual |
	actual := featureSelector 
					filterAllDigitsAndSpecialChars: true; 
					selectLastSymbol: true;
					extractConceptFrom: '12ClassName34Blueprint5%6/78'.
	expected := 'Blueprint'.
	self assert: actual equals: expected.
]

{ #category : #tests }
FeatureSelectorTest >> testFilterBothDigitsAndSpecialCharsMiddleSymbol [

	| expected actual |
	actual := featureSelector 
					filterAllDigitsAndSpecialChars: true; 
					selectMiddleSymbol: true;
					extractConceptFrom: '12ClassNa%34meBlueprint5%6/78'.
	expected := 'Name'.
	self assert: actual equals: expected.
]

{ #category : #tests }
FeatureSelectorTest >> testFilterDigitsAndSpecialCharsFirstSymbol [

	| expected actual |
	actual := featureSelector 
					filterAllDigits: true ; 
					filterSpecialChars: true ;
					selectFirstSymbol: true;
					extractConceptFrom: '%/12ClassName34Blueprint5%6/78'.								
	expected := ''.
	self assert: actual equals: expected.
]

{ #category : #tests }
FeatureSelectorTest >> testFilterDigitsAndSpecialCharsLastSymbol [

	| expected actual |
	actual := featureSelector 
					filterAllDigits: true ; 
					filterSpecialChars: true ;
					selectLastSymbol: true;
					extractConceptFrom: '12ClassName34Blueprint5%6/78'.
	expected := 'Blueprint'.
	self assert: actual equals: expected.
]

{ #category : #tests }
FeatureSelectorTest >> testFilterDigitsAndSpecialCharsMiddleSymbol [

	| expected actual |
	actual := featureSelector 
					filterAllDigits: true ; 
					filterSpecialChars: true ;
					selectMiddleSymbol: true;
					extractConceptFrom: '12ClassName%34Blueprint5%6/78'.
	expected := 'Name'.
	self assert: actual equals: expected.
]

{ #category : #tests }
FeatureSelectorTest >> testFilteringAllDigitsFirstSymbol [

	| expected actual |
	actual := featureSelector 
					filterAllDigits: true ; 
					selectFirstSymbol: true;
					extractConceptFrom: '12ClassName34Blueprint56'.
	expected := ''.
	self assert: actual equals: expected.
]

{ #category : #tests }
FeatureSelectorTest >> testFilteringAllDigitsLastSymbol [

	| expected actual |
	actual := featureSelector 
					filterAllDigits: true ; 
					selectLastSymbol: true;
					extractConceptFrom: '12ClassName34Blueprint56'.
	expected := 'Blueprint'.
	self assert: actual equals: expected.
]

{ #category : #tests }
FeatureSelectorTest >> testFilteringAllDigitsMiddleSymbol [

	| expected actual |
	actual := featureSelector 
					filterAllDigits: true ; 
					selectMiddleSymbol: true;
					extractConceptFrom: '12ClassName34Blueprint56'.					
	expected := 'Name'.
	self assert: actual equals: expected.
]

{ #category : #tests }
FeatureSelectorTest >> testStem [

	| expected actual |
	actual := featureSelector 
					filterAllDigits: true ; 
					stemming: true;
					selectLastSymbol: true;
					extractConceptFrom: '12ClassName34Building56'.
	expected := 'build'.
	self assert: actual equals: expected.

]

{ #category : #tests }
FeatureSelectorTest >> testStemFirstSymbol [

	| expected actual |
	actual := featureSelector 
					filterAllDigits: true ; 
					stemming: true;
					selectLastSymbol: true;
					extractConceptFrom: '12ClassName34Building56'.
	expected := 'build'.
	self assert: actual equals: expected.

]

{ #category : #tests }
FeatureSelectorTest >> testStemLastSymbol [

	| expected actual |
	actual := featureSelector 
					filterAllDigits: true ; 
					filterSpecialChars: true; 
					stemming: true;
					selectLastSymbol: true;
					extractConceptFrom: '12ClassBuil23%ding'.
	expected := 'build'.
	self assert: actual equals: expected.

]

{ #category : #tests }
FeatureSelectorTest >> testStemMiddleSymbol [

	| expected actual |
	actual := featureSelector 
					filterAllDigits: true ; 
					stemming: true;
					selectMiddleSymbol: true;
					extractConceptFrom: '12ClassName34Building56'.
	expected := 'name'.
	self assert: actual equals: expected.

]

{ #category : #tests }
FeatureSelectorTest >> testWithoutFiltersFirstSymbol [

	| expected actual |
	actual := featureSelector
					selectFirstSymbol: true;
					extractConceptFrom: '12ClassName34Blueprint56'.
	expected := '12'.
	self assert: actual equals: expected.
]

{ #category : #tests }
FeatureSelectorTest >> testWithoutFiltersLastSymbol [

	| expected actual |
	actual := featureSelector
					selectLastSymbol: true;
					extractConceptFrom: '12ClassName34Blueprint56'.
	expected := 'Blueprint56'.
	self assert: actual equals: expected.
]

{ #category : #tests }
FeatureSelectorTest >> testWithoutFiltersMiddleSymbol [

	| expected actual |
	actual := featureSelector 
					selectMiddleSymbol: true;
					extractConceptFrom: '12ClassName34Blueprint56'.
	expected := 'Name34'.
	self assert: actual equals: expected.
]
