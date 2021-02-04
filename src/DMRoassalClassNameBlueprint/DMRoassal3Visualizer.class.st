Class {
	#name : #DMRoassal3Visualizer,
	#superclass : #DMVisualizer,
	#category : #DMRoassalClassNameBlueprint
}

{ #category : #accessing }
DMRoassal3Visualizer class >> view: aViewModel [
	^self new
		view: aViewModel 
]

{ #category : #accessing }
DMRoassal3Visualizer >> view: aViewModel [
	| canvas |
canvas := RSCanvas new.

canvas addAll:
(aViewModel 
	packageViewModels collect: 
		[ :each | |packageComposite|
			packageComposite := RSComposite new 
				model: each; popup; color: Color white darker.
			packageComposite addAll: 
			(each suffixViewModels 
				collect: [ :suffix | 
					|suffixComposite|
					suffixComposite := RSComposite new 
						model: suffix; popup;
						border: Color black;
						color: (Color value: suffix color) ;
						addAll: (suffix classViewModels 
						collect: [ :class | | aClassBox border | 
							"border := RSBorder new
								color: Color black;
								width: class borderWidth."
							aClassBox := RSBox new 
								model: class; 
								color: (Color value: class color).
								"border: border.	"
								]);			
								yourself.
						RSGridLayout new on: suffixComposite children.
						suffixComposite padding: 10; yourself]).
			RSGridLayout new on: packageComposite children.
			packageComposite adjustToChildren; yourself]).

	RSFlowLayout on: canvas nodes.
	canvas @ RSCanvasController.
	^canvas
]
