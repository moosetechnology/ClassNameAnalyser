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

{ #category : #'as yet unclassified' }
DMBuilderTest >> testBuildConceptualModel [

	| mooseSample mooseModel conceptualModel |
	mooseSample := MooseSampleData new.
	mooseModel := MooseModel new importFromMSEStream: (mooseSample modelVersion5) readStream.
	conceptualModel := builder buildConceptualModelFrom: mooseModel.
	self assert: conceptualModel class name equals: 'DMConceptualModel'
	
]

{ #category : #tests }
DMBuilderTest >> testBuildRootModels [

	| mooseSample mooseModel conceptualModel rootModels |
	mooseSample := MooseSampleData new.
	mooseModel := MooseModel new importFromMSEStream: (mooseSample modelVersion5) readStream.
	conceptualModel := builder buildConceptualModelFrom: mooseModel.
	rootModels := builder buildRootModelsFrom: conceptualModel.
	self assert: (rootModels collect: #name) asArray equals: (conceptualModel hierarchies collect: #name) asArray
	
]

{ #category : #tests }
DMBuilderTest >> testBuildViewModel [

	| mooseSample mooseModel conceptualModel viewmodel rootModels |
	mooseSample := MooseSampleData new.
	mooseModel := MooseModel new importFromMSEStream: (mooseSample modelVersion5) readStream.
	conceptualModel := builder buildConceptualModelFrom: mooseModel.
	rootModels := builder buildRootModelsFrom: conceptualModel.
	viewmodel := DMBuilder new buildViewModelFrom: conceptualModel using: rootModels.
	
	self assert: (conceptualModel name) equals: (viewmodel name)
	
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
	mooseModel := MooseModel new importFromMSEStream: (mooseSample modelVersion5) readStream.
	conceptualModel := builder buildConceptualModelFrom: mooseModel.
	rootModels := builder buildRootModelsFrom: conceptualModel.
	classmodels := builder extractClassModelsFrom: conceptualModel.
	classViewModels := builder buildClassViewModelsFrom: classmodels.
	aClassVM := classViewModels atRandom.
	aRandomCVMRoot := rootModels detect: [ :each | each name = aClassVM root name ].
	
	self assert: (classViewModels size) equals: (classmodels size).
	self assert: (aClassVM color) equals: aRandomCVMRoot color
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
DMBuilderTest >> testExtractRootModelsForaConcept [ 

	"mooseSample has only one hierarchy that's how I know that the result would be 1 daaah there is only one hierarchy"
	| mooseSample mooseModel rootModels  |
	mooseSample := MooseSampleData new.
	mooseModel := MooseModel new importFromMSEStream: (mooseSample modelVersion5) readStream.
	builder buildConceptualModelFrom: mooseModel.
	rootModels := builder extractRootModelsFor: 'E'.
	self assert: (rootModels size) equals: 1
]

{ #category : #tests }
DMBuilderTest >> testHierarchies [
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
