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
