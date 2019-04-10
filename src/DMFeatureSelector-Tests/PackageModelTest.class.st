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
PackageModelTest >> testExtractClassNames [

	| expectedClassNames |	
	expectedClassNames := ((RPackageOrganizer default packageNamed: 'Kernel') definedClasses 	
		collect: [ :each | each instanceSide 	name ] ).
	self assert: (packageModel extractClassNamesFrom: 'Kernel') equals: expectedClassNames.
]

{ #category : #tests }
PackageModelTest >> testExtractClasses [

	| expectedClasses |	
	expectedClasses := ((RPackageOrganizer default packageNamed: 'Kernel')	definedClasses 	
		collect: [ :each | each ] ) asOrderedCollection.		
	self assert: (packageModel extractClassesFrom: 'Kernel') equals: expectedClasses.
]

{ #category : #tests }
PackageModelTest >> testPackageModelSettersAndGetters [

	| firstClassModel secondClassModel aCollectionOfclassModels expectedClasses|
	firstClassModel := DMClassModel new.
	secondClassModel := DMClassModel new.
	aCollectionOfclassModels := OrderedCollection new.
	aCollectionOfclassModels 
		add: firstClassModel;
		add: secondClassModel.
	expectedClasses := packageModel extractClassesFrom: 'Kernel'.
	packageModel packageName: 'Kernel'.
	packageModel classes: expectedClasses.
	packageModel classModels: aCollectionOfclassModels.
	self assert: (packageModel packageName) equals: 'Kernel'.
	self assert: (packageModel classModels) equals: aCollectionOfclassModels.
	self assert: (packageModel classes) equals: expectedClasses.
]
