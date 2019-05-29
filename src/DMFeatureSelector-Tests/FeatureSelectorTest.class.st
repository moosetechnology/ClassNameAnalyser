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
	self assert: (conceptualModel packageModels at: 1) packageRef equals: 'Kernel'.
	self assert: (conceptualModel packageModels at: 2) packageRef equals: 'DMFeatureSelector'.
	self assert: (conceptualModel packageModels at: 1) classModels size equals: (RPackageOrganizer default packageNamed: 'Kernel') 	definedClasses size.
	
	
]

{ #category : #tests }
FeatureSelectorTest >> testEXtractConceptFromAClassName [

	| classModel aConcept |
	classModel := DMClassModel new.
	aConcept := featureSelector extractConceptFrom: DMPackageModel name.
	self assert: aConcept equals: 'Model'.
	
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
	classModel classRef: DMClassModel.
	classModel conceptName: (featureSelector extractConceptFrom: (DMClassModel name)).
	classModel rootClass: (featureSelector extractRootClassFrom: DMClassModel).
	actualRootClass := DMClassModel.
	self assert: actualRootClass equals: expectedRootClass.

]

{ #category : #tests }
FeatureSelectorTest >> testFilterAllSpecialCharsLastSymbol [

	| expected actual |
	actual := featureSelector 
					filterSpecialChars: true ; 
					extractConceptFrom: '12ClassName34Blueprint%./?'.
	expected := 'Blueprint'.
	self assert: actual equals: expected.
]

{ #category : #tests }
FeatureSelectorTest >> testFilterBothDigitsAndSpecialCharsLastSymbol [

	| expected actual |
	actual := featureSelector 
					filterAllDigitsAndSpecialChars: true; 
					extractConceptFrom: '12ClassName34Blueprint5%6/78'.
	expected := 'Blueprint'.
	self assert: actual equals: expected.
]

{ #category : #tests }
FeatureSelectorTest >> testFilterDigitsAndSpecialCharsLastSymbol [

	| expected actual |
	actual := featureSelector 
					filterAllDigits: true ; 
					filterSpecialChars: true ;
					extractConceptFrom: '12ClassName34Blueprint5%6/78'.
	expected := 'Blueprint'.
	self assert: actual equals: expected.
]

{ #category : #tests }
FeatureSelectorTest >> testFilteringAllDigitsLastSymbol [

	| expected actual |
	actual := featureSelector 
					filterAllDigits: true ; 
					extractConceptFrom: '12ClassName34Blueprint56'.
	expected := 'Blueprint'.
	self assert: actual equals: expected.
]

{ #category : #tests }
FeatureSelectorTest >> testStem [

	| expected actual |
	actual := featureSelector 
					filterAllDigits: true ; 
					stemming: true;
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
					extractConceptFrom: '12ClassBuil23%ding'.
	expected := 'build'.
	self assert: actual equals: expected.

]
