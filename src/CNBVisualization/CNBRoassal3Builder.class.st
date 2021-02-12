Class {
	#name : #CNBRoassal3Builder,
	#superclass : #Object,
	#instVars : [
		'model'
	],
	#category : #CNBVisualization
}

{ #category : #building }
CNBRoassal3Builder class >> build: aViewModel [
	^self new
		build: aViewModel 
]

{ #category : #building }
CNBRoassal3Builder >> build: cnbModel [
	| canvas |
	canvas := RSCanvas new.
	canvas addAll: (self createPackageBoxesOf: cnbModel).
	
	RSFlowLayout on: canvas nodes.
	canvas @ RSCanvasController.
	^canvas
]

{ #category : #creating }
CNBRoassal3Builder >> createBoxOf: aCNBObject [

	^aCNBObject createBox.
]

{ #category : #creating }
CNBRoassal3Builder >> createClassBoxesOf: aSuffix [
	| classBoxes |
	classBoxes := aSuffix classViewModels 
						collect: [ :class |  self createBoxOf: class ].
	^classBoxes 
]

{ #category : #creating }
CNBRoassal3Builder >> createPackageBoxesOf: cnbModel [

	| packages packageBoxes  |
	cnbModel viewModel packageViewModels: cnbModel viewModel modelsOrderedDescending.
	cnbModel viewModel packageViewModels: cnbModel viewModel packageViewModels.
	packages := cnbModel viewModel packageViewModels.	
	packageBoxes :=
	(packages
		collect: 
			[ :package | | packageComposite label composite namedAbbreviated |
			namedAbbreviated := DMNameAbbreviationCreator abbreviate: package name until: 4.
				label := RSLabel new text: namedAbbreviated;fontSize: 30;bold.
				composite := RSComposite new.
				packageComposite := self createBoxOf: package.
				packageComposite addAll: (self createSuffixBoxesOf: package).
				RSGridLayout new on: packageComposite children;gapSize: 20.
				packageComposite border: package border.
				packageComposite adjustToChildren.
				packageComposite padding: 20.
				composite add: label; add: packageComposite.
				RSVerticalLineLayout new alignCenter; on:  { label . packageComposite }.
				composite adjustToChildren.
				
				 ]).
		^packageBoxes 
]

{ #category : #creating }
CNBRoassal3Builder >> createSuffixBoxesOf: aPackage [ 
	| suffixBoxes |
	aPackage suffixViewModels: aPackage modelsOrderedDescending. 
	aPackage suffixViewModels: aPackage modelsOrderedByColor.
		
	suffixBoxes := (aPackage suffixViewModels 
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
CNBRoassal3Builder >> model: aModel [
	^self build: aModel
]
