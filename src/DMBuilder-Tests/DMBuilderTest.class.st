Class {
	#name : #DMBuilderTest,
	#superclass : #TestCase,
	#instVars : [
		'builder'
	],
	#category : #'DMBuilder-Tests'
}

{ #category : #running }
DMBuilderTest >> setUp [
	"Hooks that subclasses may override to define the fixture of test."
	
	builder := DMBuilder new
]

{ #category : #tests }
DMBuilderTest >> testAttribueColor [
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

	| mooseSample mooseModel conceptualModel packageViewModels viewModel |
	mooseSample := MooseSampleData new.
	mooseModel := MooseModel new importFromMSEStream: (mooseSample modelVersion3) readStream.
	conceptualModel := builder buildConceptualModelFrom: mooseModel.
	builder buildRootModelsFrom: conceptualModel.
	packageViewModels := builder buildPackageViewModelsFrom: conceptualModel packagemodels.
	viewModel := builder buildViewModelFrom: conceptualModel.
	self assert: (packageViewModels size) equals:(conceptualModel packagemodels size).
	self assert: (packageViewModels collect: #name) asArray equals: (conceptualModel packagemodels collect: #name) asArray.
	self assert: (builder extractClassViewModelsFrom: viewModel) size equals: (builder extractClassModelsFrom: conceptualModel) size 
]

{ #category : #tests }
DMBuilderTest >> testBuildRootModels [
	"The modelVersion4 has two roots with the same name 'ClassA' one is a monoClass the other is a multiSuffix hierarchy each in a different package"
	| mooseSample mooseModel conceptualModel rootModels |
	mooseSample := MooseSampleData new.
	mooseModel := MooseModel new importFromMSEStream: (mooseSample modelVersion4) readStream.
	conceptualModel := builder buildConceptualModelFrom: mooseModel.
	rootModels := builder buildRootModelsFrom: conceptualModel.
	self assert: (rootModels collect: #name) asSet equals: (conceptualModel hierarchies collect: #name) .
	self assert: (rootModels size) equals: 2.
	
	
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
	self assert: (builder extractAllHierarchiesFrom: conceptualModel packagemodels) size equals: (viewmodel rootmodels) size
]

{ #category : #tests }
DMBuilderTest >> testClassType [
	"the collection of classmodels must be of the same hierarchy (have the same root)"
	self assert: (builder classTypeWithSubclasses: { DMTBuilder classmodel}) equals: #Trait.
	self assert: (builder classTypeWithSubclasses: { DMBuilder classmodel} ) equals: #monoClass.
	self assert: (builder classTypeWithSubclasses: { DMConceptualModel classmodel . DMViewModel classmodel} ) equals: #monoSuffix.
	self assert: (builder classTypeWithSubclasses: { DMFeature classmodel }) equals: #multiSuffix
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
	self assert: (classViewModels collect: #reference) asArray equals: (classModels collect: #reference) asArray
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
	self assert: (builder sortRootModels: c) asArray equals: { rm5 . rm3. rm1 . rm4 . rm2 . rm6} asArray
]

{ #category : #'as yet unclassified' }
DMBuilderTest >> testbuildConceptViewModels [
	""
	| mooseSample mooseModel conceptualModel conceptViewModels |
	mooseSample := MooseSampleData new.
	mooseModel := MooseModel new importFromMSEStream: (mooseSample modelVersion5) readStream.
	conceptualModel := builder buildConceptualModelFrom: mooseModel.
	builder buildRootModelsFrom: conceptualModel.
	conceptViewModels := builder buildConceptViewModelsFrom: conceptualModel concepts using: (conceptualModel packagemodels atRandom) classmodels.
	self assert: (conceptViewModels collect: #color) equals: {#red} asSet
]
