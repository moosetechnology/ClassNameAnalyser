Class {
	#name : #PackageModelTest,
	#superclass : #TestCase,
	#instVars : [
		'packageModel'
	],
	#category : #'DMFeatureSelector-Tests'
}

{ #category : #running }
PackageModelTest >> setUp [
	packageModel := DMPackageModel new.
]

{ #category : #tests }
PackageModelTest >> testCreateClassModelFrom [


	| rootClasses featureSelector |
	featureSelector := DMFeatureSelector new.
	featureSelector 
		stem: false; 
		selectLastSymbol.
	packageModel createClassModelsFrom: 'Kernel' with: featureSelector.
	rootClasses := packageModel classModels collect: [ :aClassModel | aClassModel rootClass ].	
	self assert: (packageModel packageName) equals: 'Kernel'.
	self assert: (packageModel classModels size) equals: packageModel classes size.
	self assert: (packageModel classModels collect: [ :aClassModel | aClassModel class ]) 	asOrderedCollection equals: packageModel 	classes asOrderedCollection.
	


]

{ #category : #tests }
PackageModelTest >> testCreateClassModels [
	"Creates ClassModels then checks if the concepts/classes/classNames/rootClasses in the 						actualClassModel are the same as in the expectedClassModel"
							
	| featureSelector |
	featureSelector := DMFeatureSelector new.
	featureSelector 
		filterAllDigitsAndSpecialChars: true; 
		stem: true; selectMiddleSymbol.
	packageModel createClassModelsFrom: 'Kernel' with: featureSelector.
	
	self assert: packageModel packageName equals: 'Kernel'.
	self assert: packageModel classes size equals: (RPackageOrganizer default packageNamed: 'Kernel') 	definedClasses size.

	

]

{ #category : #tests }
PackageModelTest >> testExtractClassNames [

	| classNames |	
	classNames := ((RPackageOrganizer default packageNamed: 'Kernel') definedClasses 	
		collect: [ :each | each instanceSide 	name ] ).
	self assert: (packageModel extractClassNamesFrom: 'Kernel') equals: classNames.
]

{ #category : #tests }
PackageModelTest >> testExtractClasses [

	| expectedClasses |	
	expectedClasses := ((RPackageOrganizer default packageNamed: 'Kernel')	definedClasses 	
		collect: [ :each | each ] ) asOrderedCollection.		
	self assert: (packageModel extractClassesFrom: 'Kernel') equals: expectedClasses.
]
