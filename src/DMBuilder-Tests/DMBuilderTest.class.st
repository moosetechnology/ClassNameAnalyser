Class {
	#name : #DMBuilderTest,
	#superclass : #TestCase,
	#instVars : [
		'builder',
		'mooseMooseModel',
		'cnbMoose',
		'calypsoMooseModel',
		'cnbCalypso',
		'roassalMooseModel',
		'cnbRoassal',
		'luceneMooseModel',
		'cnbLucene',
		'mooseClasses',
		'moosePackages'
	],
	#category : #'DMBuilder-Tests'
}

{ #category : #running }
DMBuilderTest >> setUp [
	"Hooks that subclasses may override to define the fixture of test."
	| lucenePath |
	lucenePath := '/Users/nour/Downloads/Lucene2.mse'.
	builder := DMBuilder new.
	mooseMooseModel := MooseModelSample projectNameMatches: 'moose*'.
	cnbMoose := DMClassNamesBlueprintSample projectNameMatches: 'moose*'.
	calypsoMooseModel := MooseModelSample projectNameMatches: 'calypso*'.
	cnbCalypso := DMClassNamesBlueprintSample projectNameMatches: 'calypso*'.
	"luceneMooseModel := MooseModelSample importProject: lucenePath.
	cnbLucene := DMClassNamesBlueprintSample importProject: lucenePath."
	moosePackages := mooseMooseModel allModelPackages.
	mooseClasses := moosePackages flatCollect: #classes.

]

{ #category : #tests }
DMBuilderTest >> testAttribueColor [
]

{ #category : #tests }
DMBuilderTest >> testBuildPackageViewModels [
	| expectedConcepts expectedPackagesNames  expectedClassModels |

	expectedClassModels := (mooseClasses
		collect: [ :each | each classModelAccordingTo: Object]).
	expectedConcepts := expectedClassModels collect: #concept.
	expectedPackagesNames := (moosePackages collect: #name) asSet.
	
	self
		assert: (cnbMoose viewModel packageViewModels collect: #name) asSet
		equals: expectedPackagesNames.
	self
		assert:
			((cnbMoose viewModel packageViewModels flatCollect: #conceptViewModels) collect: #name)
				asSet
		equals: expectedConcepts asSet.
]

{ #category : #tests }
DMBuilderTest >> testBuildRootModels [

	| expectedRoots actualRoots |
	 expectedRoots := (mooseClasses collect: [ :each | each rootAccordingTo: Object]) asSet.
	 actualRoots := (cnbMoose viewModel rootModels collect: #name) asSet.
	self assert: (actualRoots includesAll: (expectedRoots collect: #name))
	
	
	
]

{ #category : #tests }
DMBuilderTest >> testClassModels [
self assert: 
		((cnbMoose viewModel packageModels flatCollect: #classModels) collect: #name) asSet 
				equals: (mooseClasses collect: #name) asSet.
				
	self assert: 
		((cnbCalypso viewModel packageModels flatCollect: #classModels) collect: #name) asSet 
				equals: ((calypsoMooseModel allModelPackages flatCollect: #classes) collect: #name) asSet.
				
	
]

{ #category : #tests }
DMBuilderTest >> testClassType [
	| aMonoClass aMonoSuffixHierarchy aMultiSuffixHierarchy monoSuffixType multiSuffixType monoClassType |
	monoClassType := DMClassType monoClass.
	monoSuffixType := DMClassType monoSuffix.
	multiSuffixType := DMClassType multiSuffix.
	aMonoSuffixHierarchy := cnbMoose viewModel rootModels
		detect: [ :each | each isMonoSuffix ].
	aMultiSuffixHierarchy := cnbMoose viewModel rootModels
		detect: [ :each | each isMultiSuffix ].
	aMonoClass := cnbMoose viewModel rootModels
		detect: [ :each | each isMonoClass ].
	self
		assert: (DMClassType with: aMonoClass subclasses) type equals: monoClassType.
	self
		assert: (DMClassType with: aMonoSuffixHierarchy subclasses) type equals: monoSuffixType.
	self 
		assert: (DMClassType with: aMultiSuffixHierarchy subclasses) type equals: multiSuffixType
]

{ #category : #tests }
DMBuilderTest >> testPackageModels [.
	
	self assert: 
		(cnbMoose viewModel packageModels collect: #name) asSet 
				equals: (mooseMooseModel allModelPackages collect: #name) asSet.
				
	self assert: 
		(cnbCalypso viewModel packageModels collect: #name) asSet 
				equals: (calypsoMooseModel allModelPackages collect: #name) asSet.
	"			
	self assert: 
		(cnbLucene viewModel packageModels collect: #name) asSet 
			equals: (luceneMooseModel allModelNamespaces collect: #name) asSet."
	
]
