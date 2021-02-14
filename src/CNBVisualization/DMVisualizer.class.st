Class {
	#name : #DMVisualizer,
	#superclass : #Object,
	#instVars : [
		'settings'
	],
	#category : #CNBVisualization
}

{ #category : #'as yet unclassified' }
DMVisualizer class >> exampleCalypsoView [

	<sampleInstance>
	| viewModel |
	viewModel := (DMClassNamesBlueprintSample projectNameMatches: 'calypso*') viewModel.
	^ self new roassal3VisualizerShow: viewModel
]

{ #category : #'as yet unclassified' }
DMVisualizer class >> exampleView [

	<sampleInstance>
	| viewModel |
	viewModel := (DMClassNamesBlueprintSample importProject: '/Users/nour/Downloads/Lucene2.mse') viewModel.
	^ self new roassal3VisualizerShow: viewModel
]

{ #category : #'as yet unclassified' }
DMVisualizer class >> exampleViewWithoutClassBorders [

	<sampleInstance>
	| viewModel |
	viewModel := ((DMClassNamesBlueprintSample projectNameMatches: 'calypso*') withoutClasses) viewModel.
	^ self new roassal3VisualizerShow: viewModel
]

{ #category : #'as yet unclassified' }
DMVisualizer class >> roassal3View: aCanvas [
	^self new
		roassal3VisualizerShow: aCanvas 
]

{ #category : #view }
DMVisualizer >> roassal3VisualizerShow: aViewModel [
	
	^ DMRoassal3Visualizer new
		view: aViewModel 
]
