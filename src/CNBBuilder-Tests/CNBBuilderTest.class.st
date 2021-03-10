Class {
	#name : #CNBBuilderTest,
	#superclass : #TestCase,
	#instVars : [
		'builder',
		'mooseMooseModel',
		'cnbMoose',
		'calypsoMooseModel',
		'cnbCalypso',
		'luceneMooseModel',
		'cnbLucene',
		'moosePackages',
		'mooseClasses'
	],
	#category : #'CNBBuilder-Tests'
}

{ #category : #running }
CNBBuilderTest >> setUp [
	"Hooks that subclasses may override to define the fixture of test."
	| lucenePath |
	lucenePath := '/Users/nour/Downloads/Lucene2.mse'.
	builder := CNBBuilder new.
	mooseMooseModel := CNBMooseModelGenerator projectNameMatches: 'moose*-'.
	cnbMoose := CNBClassNamesBlueprintGenerator projectNameMatches: 'moose*-'.
	calypsoMooseModel := CNBMooseModelGenerator projectNameMatches: 'calypso*-'.
	cnbCalypso := CNBClassNamesBlueprintGenerator projectNameMatches: 'calypso*-'.
"	luceneMooseModel := MooseModelSample importProject: lucenePath.
	cnbLucene := DMClassNamesBlueprintSample importProject: lucenePath."
	moosePackages := mooseMooseModel allModelPackages.
	mooseClasses := moosePackages flatCollect: #classes.

]

{ #category : #tests }
CNBBuilderTest >> testAssignColor [

	self assert: false.
]

{ #category : #tests }
CNBBuilderTest >> testBuildPackageViewModels [
	| expectedConcepts expectedPackagesNames  expectedClassModels |

	expectedClassModels := (mooseClasses
		collect: [ :each | each classModelAccordingTo: Object]).
	expectedConcepts := expectedClassModels collect: #suffix.
	expectedPackagesNames := (moosePackages collect: #name) asSet.
	
	self
		assert: (cnbMoose viewModel packageViewModels collect: #name) asSet
		equals: expectedPackagesNames.
	self
		assert:
			((cnbMoose viewModel packageViewModels flatCollect: #tokenViewModels) collect: #name)
				asSet
		equals: expectedConcepts asSet.
]

{ #category : #tests }
CNBBuilderTest >> testBuildRootModels [

	| expectedRoots actualRoots |
	 expectedRoots := (mooseClasses collect: [ :each | each rootAccordingTo: Object]) asSet.
	 actualRoots := (cnbMoose viewModel rootModels collect: #name) asSet.
	self assert: (actualRoots includesAll: (expectedRoots collect: #name))
	
	
	
]

{ #category : #tests }
CNBBuilderTest >> testClassModels [
self assert: 
		((cnbMoose viewModel packageModels flatCollect: #classModels) collect: #name) asSet 
				equals: (mooseClasses collect: #name) asSet.
				
	self assert: 
		((cnbCalypso viewModel packageModels flatCollect: #classModels) collect: #name) asSet 
				equals: ((calypsoMooseModel allModelPackages flatCollect: #classes) collect: #name) asSet.
				
	
]

{ #category : #tests }
CNBBuilderTest >> testClassType [
	| aMonoClass aMonoSuffixHierarchy aMultiSuffixHierarchy monoSuffixType multiSuffixType monoClassType |
	monoClassType := CNBClassType monoClass.
	monoSuffixType := CNBClassType monoToken.
	multiSuffixType := CNBClassType multiToken.
	aMonoSuffixHierarchy := cnbMoose viewModel rootModels
		detect: [ :each | each isMonoToken ].
	aMultiSuffixHierarchy := cnbMoose viewModel rootModels
		detect: [ :each | each isMultiToken ].
	aMonoClass := cnbMoose viewModel rootModels
		detect: [ :each | each isMonoClass ].
	self
		assert: (CNBClassType with: aMonoClass subclasses) type equals: monoClassType.
	self
		assert: (CNBClassType with: aMonoSuffixHierarchy subclasses) type equals: monoSuffixType.
	self 
		assert: (CNBClassType with: aMultiSuffixHierarchy subclasses) type equals: multiSuffixType
]

{ #category : #tests }
CNBBuilderTest >> testPackageModels [.
	
	self assert: 
		(cnbMoose viewModel packageModels collect: #name) asSet 
				equals: (mooseMooseModel allModelPackages collect: #name) asSet.
				
	self assert: 
		(cnbCalypso viewModel packageModels collect: #name) asSet 
				equals: (calypsoMooseModel allModelPackages collect: #name) asSet.
				
	"self assert: 
		(cnbLucene viewModel packageModels collect: #name) asSet 
			equals: (luceneMooseModel allModelNamespaces collect: #name) asSet."
	
]

{ #category : #tests }
CNBBuilderTest >> testSortRootModels [
	| rm1 rm2 rm3 rm4 rm5 rm6 c |
	rm1 := CNBRootModel new name: 'rm1';size: 3.
	rm2 := CNBRootModel new name: 'rm2';size: 0.
	rm3 := CNBRootModel new name: 'rm3';size: 4.
	rm4 := CNBRootModel new name: 'rm4';size: 2.
	rm5 := CNBRootModel new name: 'rm5';size: 7.
	rm6 := CNBRootModel new name: 'rm6';size: 0.
	c := { rm1 . rm2 . rm3 . rm4 . rm5 . rm6 } asSet.
	self assert: (builder sortRootModels: c) asSet equals: { rm5 . rm3. rm1 . rm4 . rm2 . rm6} asSet
]

{ #category : #'as yet unclassified' }
CNBBuilderTest >> testbuildConceptViewModels [
	""
	
]
