Class {
	#name : #DMRoassal3Visualizer,
	#superclass : #DMVisualizer,
	#category : #DMRoassalClassNameBlueprint
}

{ #category : #'as yet unclassified' }
DMRoassal3Visualizer class >> exampleView [

	<sampleInstance>
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
		[ :package | | packageComposite |
			packageComposite := RSComposite new 
				model: package; popup; color: (Color white darker); withBorder; borderColor: Color black.
			packageComposite addAll: 
			(package suffixViewModels 
				collect: [ :suffix | 
					|suffixComposite|
					suffixComposite := RSComposite new 
						model: suffix; popup; withBorder; borderColor: Color black;
						color: suffix color;
						addAll: (suffix classViewModels 
						collect: [ :class | | classBox |
							classBox := RSBox new width: 25; height: 25.
							classBox model: class; popup; color: class color; withBorder.
							classBox  border width: class borderWidth.
							classBox borderColor: Color black ]); yourself.
						RSGridLayout new on: suffixComposite children.
						suffixComposite padding: 7; yourself]).
			RSGridLayout new on: packageComposite children.
			packageComposite padding: 7; yourself]).

	RSFlowLayout on: canvas nodes.
	canvas @ RSCanvasController.
	^canvas
]
