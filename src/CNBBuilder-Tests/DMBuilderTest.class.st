Class {
	#name : #DMBuilderTest,
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
DMBuilderTest >> setUp [
	"Hooks that subclasses may override to define the fixture of test."
	| lucenePath |
	lucenePath := '/Users/nour/Downloads/Lucene2.mse'.
	builder := DMBuilder new.
	mooseMooseModel := MooseModelSample projectNameMatches: 'moose*'.
	cnbMoose := DMClassNamesBlueprintSample projectNameMatches: 'moose*'.
	calypsoMooseModel := MooseModelSample projectNameMatches: 'calypso*'.
	cnbCalypso := DMClassNamesBlueprintSample projectNameMatches: 'calypso*'.
"	luceneMooseModel := MooseModelSample importProject: lucenePath.
	cnbLucene := DMClassNamesBlueprintSample importProject: lucenePath."
	moosePackages := mooseMooseModel allModelPackages.
	mooseClasses := moosePackages flatCollect: #classes.

]

{ #category : #tests }
DMBuilderTest >> testAssignColor [

	self assert: false.
]

{ #category : #tests }
DMBuilderTest >> testAttribueColor [
]

{ #category : #tests }
DMBuilderTest >> testBuildConceptViewModels [

	| mooseSample mooseModel conceptualModel rootModels conceptVModels |
	mooseSample := MooseSampleData new.
	mooseModel := MooseModel new importFromMSEStream: (mooseSample modelVersion4) readStream.
	conceptualModel := builder buildConceptualModelFrom: mooseModel.
	rootModels := builder buildRootModelsFrom: conceptualModel.
	conceptVModels := builder buildConceptViewModelsFrom: conceptualModel concepts using:( builder extractClassModelsFrom: conceptualModel).
	self assert: (conceptVModels size) equals: conceptualModel concepts size.
	self assert: (conceptVModels collect: #name) equals: conceptualModel concepts.
	
]

{ #category : #'as yet unclassified' }
DMBuilderTest >> testBuildConceptualModel [

	| mooseSample mooseModel conceptualModel |
	mooseSample := MooseSampleData new.
	mooseModel := MooseModel new importFromMSEStream: (mooseSample modelVersion4) readStream.
	conceptualModel := builder buildConceptualModelFrom: mooseModel.
	builder buildRootModelsFrom: conceptualModel.
	self assert: conceptualModel class name equals: 'DMConceptualModel'.
	
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
			((cnbMoose viewModel packageViewModels flatCollect: #suffixViewModels) collect: #name)
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
DMBuilderTest >> testBuildViewModel [

	| mooseSample mooseModel conceptualModel viewmodel rootModels |
	mooseSample := MooseSampleData new.
	mooseModel := MooseModel new importFromMSEStream: (mooseSample modelVersion4) readStream.
	conceptualModel := builder buildConceptualModelFrom: mooseModel.
	rootModels := builder buildRootModelsFrom: conceptualModel.
	viewmodel := DMBuilder new buildViewModelFrom: conceptualModel.
	
	self assert: (conceptualModel name) equals: (viewmodel name).
	self assert: (builder extractAllHierarchiesFrom: conceptualModel models) size equals: (viewmodel rootmodels) size
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
DMBuilderTest >> testClassViewModel [

	| mooseSample mooseModel conceptualModel rootModels classmodels classViewModels aClassVM aRandomCVMRoot |
	mooseSample := MooseSampleData new.
	mooseModel := MooseModel new importFromMSEStream: (mooseSample modelVersion4) readStream.
	conceptualModel := builder buildConceptualModelFrom: mooseModel.
	rootModels := builder buildRootModelsFrom: conceptualModel.
	classmodels := builder extractClassModelsFrom: conceptualModel.
	classViewModels := builder buildClassViewModelsFrom: classmodels.
	aClassVM := classViewModels atRandom.
	aRandomCVMRoot := rootModels detect: [ :each | each name = aClassVM root name ].
	
	self assert: (classViewModels size) equals: (classmodels size).
	self assert: (aClassVM color) equals: aRandomCVMRoot color.
]

{ #category : #tests }
DMBuilderTest >> testExtractBiggestClassDepthFromAConceptualModel [

	| mooseSample mooseModel conceptualModel |
	mooseSample := MooseSampleData new.
	mooseModel := MooseModel new importFromMSEStream: (mooseSample modelVersion4) readStream.
	conceptualModel := builder buildConceptualModelFrom: mooseModel.
	builder buildRootModelsFrom: conceptualModel.
	self assert: (DMBuilder extractBiggestClassDepthFrom: conceptualModel) equals: 2
]

{ #category : #tests }
DMBuilderTest >> testExtractClassModels [

	| mooseSample mooseModel conceptualModel classModels |
	mooseSample := MooseSampleData new.
	mooseModel := MooseModel new importFromMSEStream: (mooseSample modelVersion5) readStream.
	conceptualModel := builder buildConceptualModelFrom: mooseModel.
	classModels := builder extractClassModelsFrom: conceptualModel.
	self assert: (classModels collect: #name) asSet equals: { 'ClassD' . 'ClassA' . 'ClassE' . 'ClassB' } asSet
	
	
]

{ #category : #tests }
DMBuilderTest >> testExtractClassViewModels [

	| mooseSample mooseModel conceptualModel rootModels viewModel classModels classViewModels |
	mooseSample := MooseSampleData new.
	mooseModel := MooseModel new importFromMSEStream: (mooseSample modelVersion5) readStream.
	conceptualModel := builder buildConceptualModelFrom: mooseModel.
	rootModels := builder buildRootModelsFrom: conceptualModel.
	viewModel := builder buildViewModelFrom: conceptualModel.
	classModels := builder extractClassModelsFrom: conceptualModel.
	classViewModels := builder extractClassViewModelsFrom: viewModel.
	self assert: (classViewModels size) equals: (classModels size).
	self assert: (classViewModels collect: #reference) asSet equals: (classModels collect: #reference) asSet
]

{ #category : #tests }
DMBuilderTest >> testExtractRootModelsForaConcept [ 

	"mooseSample has only one hierarchy that's how I know that the result would be 1 daaah there is only one hierarchy"
	| mooseSample mooseModel rootModels conceptualmodel|
	mooseSample := MooseSampleData new.
	mooseModel := MooseModel new importFromMSEStream: (mooseSample modelVersion5) readStream.
	conceptualmodel := builder buildConceptualModelFrom: mooseModel.
	builder buildRootModelsFrom: conceptualmodel.
	rootModels := builder extractRootModelsFor: 'E'.
	self assert: (rootModels size) equals: 1
]

{ #category : #'as yet unclassified' }
DMBuilderTest >> testExtractSmallestClassDepthFrom [

	| mooseSample mooseModel conceptualModel |
	mooseSample := MooseSampleData new.
	mooseModel := MooseModel new importFromMSEStream: (mooseSample modelVersion4) readStream.
	conceptualModel := builder buildConceptualModelFrom: mooseModel.
	builder buildRootModelsFrom: conceptualModel.
	self assert: (DMBuilder extractSmallestClassDepthFrom: conceptualModel) equals: 0
]

{ #category : #tests }
DMBuilderTest >> testPackageModels [.
	
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
DMBuilderTest >> testSelectBiggestHierarchyFor [

	"The modelVersion4 has two roots with the same name 'ClassA' one is a monoClass the other is a 	multiSuffix hierarchy each in a different package"
	| mooseSample mooseModel conceptualModel rootmodel |
	mooseSample := MooseSampleData new.
	mooseModel := MooseModel new importFromMSEStream: (mooseSample modelVersion4) readStream.
	conceptualModel := builder buildConceptualModelFrom: mooseModel.
	builder buildRootModelsFrom: conceptualModel.
	rootmodel := (builder selectBiggestHierarchyFor: 'A').
	self assert: (rootmodel name) equals: 'ClassA'.
	self assert: (rootmodel color) equals: #red

]

{ #category : #tests }
DMBuilderTest >> testSelectColorFor [
	"there is only one hierarchy its color is red"
	| mooseSample mooseModel conceptualModel color |
	mooseSample := MooseSampleData new.
	mooseModel := MooseModel new importFromMSEStream: (mooseSample modelVersion5) readStream.
	conceptualModel := builder buildConceptualModelFrom: mooseModel.
	builder buildRootModelsFrom: conceptualModel.
	color := builder selectColorFor: 'E'.
	self assert: color equals: #red
	
]

{ #category : #tests }
DMBuilderTest >> testSortRootModels [
	| rm1 rm2 rm3 rm4 rm5 rm6 c |
	rm1 := DMRootModel new name: 'rm1';size: 3.
	rm2 := DMRootModel new name: 'rm2';size: 0.
	rm3 := DMRootModel new name: 'rm3';size: 4.
	rm4 := DMRootModel new name: 'rm4';size: 2.
	rm5 := DMRootModel new name: 'rm5';size: 7.
	rm6 := DMRootModel new name: 'rm6';size: 0.
	c := { rm1 . rm2 . rm3 . rm4 . rm5 . rm6 } asSet.
	self assert: (builder sortRootModels: c) asSet equals: { rm5 . rm3. rm1 . rm4 . rm2 . rm6} asSet
]

{ #category : #'as yet unclassified' }
DMBuilderTest >> testbuildConceptViewModels [
	""
	| mooseSample mooseModel conceptualModel conceptViewModels |
	mooseSample := MooseSampleData new.
	mooseModel := MooseModel new importFromMSEStream: (mooseSample modelVersion5) readStream.
	conceptualModel := builder buildConceptualModelFrom: mooseModel.
	builder buildRootModelsFrom: conceptualModel.
	conceptViewModels := builder buildConceptViewModelsFrom: conceptualModel concepts using: (conceptualModel models atRandom) classmodels.
	self assert: (conceptViewModels collect: #color) equals: {#red} asSet
]
