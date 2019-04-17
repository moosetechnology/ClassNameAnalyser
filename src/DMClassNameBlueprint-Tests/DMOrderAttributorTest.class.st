Class {
	#name : #DMOrderAttributorTest,
	#superclass : #TestCase,
	#instVars : [
		'orderAttributor'
	],
	#category : #'DMClassNameBlueprint-Tests'
}

{ #category : #running }
DMOrderAttributorTest >> setUp [ 
	orderAttributor := DMOrderAttributor new.
]

{ #category : #tests }
DMOrderAttributorTest >> testOrderFromBiggestPackageViewModels [

	| featureSelector conceptualModel viewModel  builder orderedViewModel |
	featureSelector := DMFeatureSelector new.
	builder := DMClassNameBlueprintBuilder new.
	orderedViewModel := DMViewModel new.
	conceptualModel := featureSelector applyFeaturesOn: { 'Kernel' . 'DMViewModel' 	.'DMFeatureSelector'}.
	viewModel := builder buildModelFrom: conceptualModel.
	orderAttributor orderFromBiggest: true.
	orderedViewModel := orderAttributor setOrder: viewModel.
	self assert:( (viewModel packageViewModels collect: [ :aPVM | aPVM size ]) == (orderedViewModel 	packageViewModels collect: [ :aPVM | aPVM size ]) asSortedCollection ) equals: false.
	self assert: (viewModel packageViewModels collect: [ :aPackageViewModel | aPackageViewModel 	conceptViewModels ]) == (orderedViewModel packageViewModels collect: [ :aPackageVM | aPackageVM 	conceptViewModels ]) equals: false.

]

{ #category : #tests }
DMOrderAttributorTest >> testOrderFromSmallestPackageViewModels [

	| featureSelector conceptualModel viewModel  builder orderedViewModel |
	featureSelector := DMFeatureSelector new.
	builder := DMClassNameBlueprintBuilder new.
	orderedViewModel := DMViewModel new.
	conceptualModel := featureSelector applyFeaturesOn: { 'Kernel' . 'DMViewModel' 	.'DMFeatureSelector'}.
	viewModel := builder buildModelFrom: conceptualModel.
	orderAttributor orderFromSmallest: true.
	orderedViewModel := orderAttributor setOrder: viewModel.
	self assert:( (viewModel packageViewModels collect: [ :aPVM | aPVM size ]) == (orderedViewModel 	packageViewModels collect: [ :aPVM | aPVM size ]) asSortedCollection ) equals: false.
	self assert: (viewModel packageViewModels collect: [ :aPackageViewModel | aPackageViewModel 	conceptViewModels ]) == (orderedViewModel packageViewModels collect: [ :aPackageVM | aPackageVM 	conceptViewModels ]) equals: false.

]

{ #category : #tests }
DMOrderAttributorTest >> testSetOrderFromSmallest [


	| featureSelector conceptualModel viewModel  builder orderedViewModel |
	featureSelector := DMFeatureSelector new.
	builder := DMClassNameBlueprintBuilder new.
	orderedViewModel := DMViewModel new.
	conceptualModel := featureSelector applyFeaturesOn: { 'Kernel' . 'DMViewModel' 	.'DMFeatureSelector'}.
	viewModel := builder buildModelFrom: conceptualModel.
	orderAttributor orderFromSmallest: true.
	orderedViewModel := orderAttributor setOrder: viewModel.
	self assert: (orderedViewModel == viewModel ) equals: false.
]

{ #category : #tests }
DMOrderAttributorTest >> testsetOrderByDefault [

	| featureSelector conceptualModel viewModel  builder actualViewModel |
	featureSelector := DMFeatureSelector new.
	builder := DMClassNameBlueprintBuilder new.
	conceptualModel := featureSelector applyFeaturesOn: { 'Kernel' . 'DMViewModel' }.
	viewModel := builder buildModelFrom: conceptualModel.
	actualViewModel := orderAttributor setOrder: viewModel.
	self assert: actualViewModel equals: viewModel
	

]

{ #category : #tests }
DMOrderAttributorTest >> testsetOrderFromBiggest [

	| featureSelector conceptualModel viewModel  builder orderedViewModel |
	featureSelector := DMFeatureSelector new.
	builder := DMClassNameBlueprintBuilder new.
	orderedViewModel := DMViewModel new.
	conceptualModel := featureSelector applyFeaturesOn: { 'Kernel' . 'DMViewModel' 	.'DMFeatureSelector'}.
	viewModel := builder buildModelFrom: conceptualModel.
	orderAttributor orderFromBiggest: true.
	orderedViewModel := orderAttributor setOrder: viewModel.
	self assert: (orderedViewModel == viewModel ) equals: false.
]
