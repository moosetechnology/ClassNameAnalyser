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
]

{ #category : #tests }
DMBuilderTest >> testClassType [
	"the collection of classmodels must be of the same hierarchy (have the same root)"
	self assert: (builder classTypeWithSubclasses: {DMTBuilder classmodel}) equals: #Trait.
	self assert: (builder classTypeWithSubclasses: { DMBuilder classmodel} ) equals: #monoClass.
	self assert: (builder classTypeWithSubclasses: { DMConceptualModel classmodel . DMViewModel classmodel} ) equals: #monoSuffix.
	self assert: (builder classTypeWithSubclasses: { DMFeature classmodel }) equals: #multiSuffix
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
DMBuilderTest >> testHierarchies [
]
