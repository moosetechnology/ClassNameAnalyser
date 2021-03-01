Class {
	#name : #CNBRoassal3Builder,
	#superclass : #Object,
	#instVars : [
		'model',
		'canvas'
	],
	#category : #CNBVisualization
}

{ #category : #building }
CNBRoassal3Builder class >> build: cnbModel [
	^self new
		build: cnbModel 
]

{ #category : #'as yet unclassified' }
CNBRoassal3Builder class >> exampleMooseCanvas [
	<sampleInstance>
	^(CNBClassNamesBlueprintGenerator projectNameMatches: 'moose*') show
]

{ #category : #'as yet unclassified' }
CNBRoassal3Builder class >> importProject: aPath [

	^ CNBClassNamesBlueprintGenerator importProject: aPath.
]

{ #category : #'as yet unclassified' }
CNBRoassal3Builder class >> importProject: aPath on: aCanvas [

	| cnb |
	cnb := self importProject: aPath.
	aCanvas addAll: (self new buildShapesOf: cnb).
	RSFlowLayout on: aCanvas nodes.
	aCanvas @ RSCanvasController.
	aCanvas color: aCanvas color darker.
	^aCanvas
]

{ #category : #'as yet unclassified' }
CNBRoassal3Builder class >> model: aCNB on: aCanvas [
	
	aCanvas addAll: (self new buildShapesOf: aCNB).
	RSFlowLayout on: aCanvas nodes.
	aCanvas @ RSCanvasController.
	aCanvas color: aCanvas color darker.
	^aCanvas
]

{ #category : #'as yet unclassified' }
CNBRoassal3Builder class >> mooseOn: aCanvas [

	| cnb |
	cnb := CNBClassNamesBlueprintGenerator projectNameMatches: 'moose*'.
	aCanvas addAll: (self new buildShapesOf: cnb).
	RSFlowLayout on: aCanvas nodes.
	aCanvas @ RSCanvasController.
	aCanvas color: aCanvas color darker.
	^aCanvas
]

{ #category : #'as yet unclassified' }
CNBRoassal3Builder class >> projectNameMatches: aString [
	
	^ CNBClassNamesBlueprintGenerator projectNameMatches: aString.
	
]

{ #category : #'as yet unclassified' }
CNBRoassal3Builder class >> projectNameMatches: aString on: aCanvas [
	
	| cnb |
	cnb := self projectNameMatches: aString.
	aCanvas addAll: (self new buildShapesOf: cnb).
	RSFlowLayout on: aCanvas nodes.
	aCanvas @ RSCanvasController.
	aCanvas color: aCanvas color darker.
	^aCanvas
]

{ #category : #building }
CNBRoassal3Builder >> build: cnbModel [
	canvas addAll: (self createPackageBoxesOf: cnbModel).
	
	RSFlowLayout on: canvas nodes.
	canvas @ RSCanvasController.
	^canvas
]

{ #category : #'as yet unclassified' }
CNBRoassal3Builder >> buildShapesOf: cnbModel [

		^self createPackageBoxesOf: cnbModel.
	
]

{ #category : #accessing }
CNBRoassal3Builder >> canvas [ 
	^canvas
]

{ #category : #accessing }
CNBRoassal3Builder >> canvas: aCanvas [

	canvas := aCanvas
]

{ #category : #creating }
CNBRoassal3Builder >> createBoxOf: aCNBObject [

	^aCNBObject createBox.
]

{ #category : #creating }
CNBRoassal3Builder >> createClassBoxesOf: aSuffix [
	| classBoxes |
	classBoxes := aSuffix classViewModels 
						collect: [ :class |  | classBox |
							classBox := self createBoxOf: class.
							classBox model: class ].
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
			namedAbbreviated := CNBNameAbbreviationCreator abbreviate: package name until: 4.
				label := RSLabel new text: namedAbbreviated;fontSize: 30;bold.
				composite := RSComposite new.
				packageComposite := self createBoxOf: package.
				packageComposite model: package.
				packageComposite addAll: (self createSuffixBoxesOf: package).
				RSGridLayout new on: packageComposite children;gapSize: 20.
				packageComposite border: package border.
				packageComposite adjustToChildren.
				packageComposite padding: 20.
				
				composite color: packageComposite color.
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
					suffixComposite model: suffix.
					suffixComposite addAll: (self createClassBoxesOf: suffix).
					suffixComposite border: suffix border.
					suffixComposite adjustToChildren.
					RSGridLayout new on: suffixComposite children.
					suffixComposite padding: 12.
					
					composite color: Color white darker.
					composite add: label; add: suffixComposite.
					RSVerticalLineLayout new alignCenter on: composite children.
					composite adjustToChildren.
					composite.
						]).
					
	^suffixBoxes 
					
		
]

{ #category : #initialization }
CNBRoassal3Builder >> initialize [ 
	super initialize.
	canvas := RSCanvas new.
]

{ #category : #accessing }
CNBRoassal3Builder >> model: aModel [
	^self build: aModel
]
