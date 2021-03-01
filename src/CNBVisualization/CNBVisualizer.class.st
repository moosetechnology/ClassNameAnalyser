Class {
	#name : #CNBVisualizer,
	#superclass : #Object,
	#instVars : [
		'settings'
	],
	#category : #CNBVisualization
}

{ #category : #'as yet unclassified' }
CNBVisualizer class >> exampleCalypsoView [

	<sampleInstance>
	| viewModel |
	viewModel := (CNBClassNamesBlueprintGenerator projectNameMatches: 'calypso*') viewModel.
	^ self new roassal3VisualizerShow: viewModel
]

{ #category : #'as yet unclassified' }
CNBVisualizer class >> exampleView [

	<sampleInstance>
	| viewModel |
	viewModel := (CNBClassNamesBlueprintGenerator importProject: '/Users/nour/Downloads/Lucene2.mse') viewModel.
	^ self new roassal3VisualizerShow: viewModel
]

{ #category : #'as yet unclassified' }
CNBVisualizer class >> exampleViewWithoutClassBorders [

	<sampleInstance>
	| viewModel |
	viewModel := ((CNBClassNamesBlueprintGenerator projectNameMatches: 'calypso*') withoutClasses) viewModel.
	^ self new roassal3VisualizerShow: viewModel
]

{ #category : #'as yet unclassified' }
CNBVisualizer class >> roassal3View: aCanvas [
	^self new
		roassal3VisualizerShow: aCanvas 
]

{ #category : #view }
CNBVisualizer >> roassal3VisualizerShow: aViewModel [
	
	^ CNBRoassal3Visualizer new
		view: aViewModel 
]
