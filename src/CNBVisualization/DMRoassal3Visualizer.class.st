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

	| packages packageBoxes composite |
	composite := RSComposite new.
	packages := orderBySize isNotNil 
		ifTrue: [ aViewModel modelsOrderedDescending ]
		ifFalse: [ aViewModel packageViewModels ].
		
	packageBoxes :=
	(packages
		collect: 
			[ :package | | packageComposite label |
				label := RSLabel new text: package name.
				packageComposite := self createBoxOf: package.
				packageComposite addAll: (self createSuffixBoxesOf: package).
				RSGridLayout new on: packageComposite children;gapSize: 20.
				packageComposite border: package border.
				packageComposite adjustToChildren.
				packageComposite padding: 20.
			"	composite add: label; add: packageComposite.
				RSVerticalLineLayout new alignCenter; on:  { label . packageComposite }.
				composite adjustToChildren."
				
				 ]).
		^packageBoxes 
]

{ #category : #'as yet unclassified' }
DMRoassal3Visualizer >> createSuffixBoxesOf: aPackage [ 
	| suffixes suffixBoxes |
	suffixes := aPackage suffixViewModels.
	suffixes := orderBySize isNotNil
		ifTrue: [ aPackage suffixViewModels: aPackage modelsOrderedDescending ]. 
	suffixes :=	orderByColor isNotNil
		ifTrue: [ aPackage modelsOrderedByColor ].
		
	suffixBoxes := (suffixes 
			collect: [ :suffix | | suffixComposite label composite |
				composite := RSComposite new.
					label := RSLabel new text: suffix name;bold; fontSize:20.
					suffixComposite := self createBoxOf: suffix.
					suffixComposite addAll: (self createClassBoxesOf: suffix).
					suffixComposite border: suffix border.
					suffixComposite adjustToChildren.
					RSGridLayout new on: suffixComposite children.
					suffixComposite padding: 12.
					
					composite add: label; add: suffixComposite.
					RSVerticalLineLayout new alignCenter on: composite children.
					composite adjustToChildren.
					composite.
						]).
					
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
