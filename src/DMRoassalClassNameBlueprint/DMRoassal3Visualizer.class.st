Class {
	#name : #DMRoassal3Visualizer,
	#superclass : #DMVisualizer,
	#category : #DMRoassalClassNameBlueprint
}

{ #category : #'as yet unclassified' }
DMRoassal3Visualizer class >> exampleView [

	| viewModel |
	viewModel := (DMClassNamesBlueprintSample projectNameMatches: 'moose*') viewModel.
	^ DMVisualizer roassal3View: viewModel
]

{ #category : #accessing }
DMRoassal3Visualizer class >> view: aViewModel [

	| canvas |
	canvas := RSCanvas new.
	canvas addAll: 
	(aViewModel packageViewModels collect: 
		[ :each | |packageComposite|
			packageComposite := RSComposite new 
				model: each; popup; color: Color veryLightGray.
			packageComposite addAll: 
			(each suffixViewModels 
				collect: [ :suffix | 
					|suffixComposite|
					suffixComposite := RSComposite new 
						model: suffix; popup;
						color: Color lightGray;
						addAll: (suffix classViewModels 
						collect: [ :class | RSBox new model: class; color: Color red ]); yourself.
						RSGridLayout new on: suffixComposite children.
						suffixComposite padding: 10; yourself]).
			RSGridLayout new on: packageComposite children.
			packageComposite adjustToChildren; yourself]).

	RSFlowLayout on: canvas nodes.
	canvas @ RSCanvasController.
	^canvas
]
