Class {
	#name : #DMRoassal3Visualizer,
	#superclass : #DMVisualizer,
	#category : #DMRoassalClassNameBlueprint
}

{ #category : #visualization }
DMRoassal3Visualizer >> visualize: aViewModel [
	| view boxes packages |
	view := RTView new.
	packages := aViewModel packageViewModels.
	boxes := RSComposite new 
		shapes: (RSGroup new add: RSComposite new);
		padding: 3.
	view addAll: boxes.
	^view

]
