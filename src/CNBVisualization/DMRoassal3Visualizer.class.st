Class {
	#name : #DMRoassal3Visualizer,
	#superclass : #DMVisualizer,
	#category : #CNBVisualization
}

{ #category : #'as yet unclassified' }
DMRoassal3Visualizer >> createBoxOf: aCNBObject [

	^aCNBObject createBox.
]

{ #category : #'as yet unclassified' }
DMRoassal3Visualizer >> createClassBoxesOf: aSuffix [
	| classBoxes |
	classBoxes := aSuffix classViewModels 
						collect: [ :class |  self createBoxOf: class ].
	^classBoxes 
]

{ #category : #'as yet unclassified' }
DMRoassal3Visualizer >> createPackageBoxesOf: aViewModel [

	| packages packageBoxes |
	packages := orderBySize isNotNil 
		ifTrue: [ aViewModel modelsOrderedDescending ]
		ifFalse: [ aViewModel packageViewModels ].
		
	packageBoxes :=
	(packages
		collect: 
			[ :package | | packageComposite |
				packageComposite := self createBoxOf: package.
				packageComposite addAll: (self createSuffixBoxesOf: package).
				RSGridLayout new on: packageComposite children.
				packageComposite padding: 7 ]).
		^packageBoxes 
]

{ #category : #'as yet unclassified' }
DMRoassal3Visualizer >> createSuffixBoxesOf: aPackage [ 
	| suffixes suffixBoxes |
	
	suffixes := aPackage suffixViewModels.
	suffixes := orderBySize isNotNil
		ifTrue: [ aPackage modelsOrderedDescending.
					orderByColor isNotNil
						ifTrue: [ aPackage modelsOrderedByColor ]
				].
		
	suffixBoxes := (suffixes 
			collect: [ :suffix | | suffixComposite |
					suffixComposite := self createBoxOf: suffix.
					suffixComposite addAll: (self createClassBoxesOf: suffix).
						RSGridLayout new on: suffixComposite children.
						suffixComposite padding: 12]).
					
	^suffixBoxes 
					
		
]

{ #category : #accessing }
DMRoassal3Visualizer >> view: aViewModel [

	| canvas |
	canvas := RSCanvas new.
	canvas addAll: (self createPackageBoxesOf: aViewModel).

	RSFlowLayout on: canvas nodes.
	canvas @ RSCanvasController.
	^canvas
]
