Class {
	#name : #DMVisualizer,
	#superclass : #Object,
	#instVars : [
		'orderBySize',
		'orderByColor'
	],
	#category : #CNBVisualization
}

{ #category : #'as yet unclassified' }
DMVisualizer class >> exampleView [

	<sampleInstance>
	| viewModel |
	viewModel := (DMClassNamesBlueprintSample projectNameMatches: 'calypso*') viewModel.
	^ self new roassal3View: viewModel
]

{ #category : #'as yet unclassified' }
DMVisualizer class >> exampleViewWithoutClassBorders [

	<sampleInstance>
	| viewModel |
	viewModel := ((DMClassNamesBlueprintSample projectNameMatches: 'calypso*') withoutClasses) viewModel.
	^ self new roassal3View: viewModel
]

{ #category : #accessing }
DMVisualizer >> orderByColor [
	orderByColor := true 
]

{ #category : #accessing }
DMVisualizer >> orderBySize [
	orderBySize := true
]

{ #category : #view }
DMVisualizer >> roassal3View: aViewModel [
	
	| roassal3View |
	roassal3View := DMRoassal3Visualizer new.
	
	self orderByColor isNotNil 
		ifTrue: [ roassal3View orderByColor ].
	self orderBySize isNotNil 
		ifTrue: [ roassal3View orderBySize ].
		
	^roassal3View 
		view: aViewModel 
]
