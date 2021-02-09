Trait {
	#name : #DMTColorAttributor,
	#instVars : [
		'palette'
	],
	#category : #CNBBuilder
}

{ #category : #assignments }
DMTColorAttributor >> assignColorByType: aType [

	(aType = DMClassType trait)
	ifTrue: [ ^palette traitColor ].
	
	(aType = DMClassType monoClass)
	ifTrue: [ ^palette monoClassColor ].
	
	(aType = DMClassType monoSuffix)
	ifTrue: [  ^palette monoSuffixColor ].
	
	(aType = DMClassType multiSuffix)
	ifTrue: [ ^palette aColorForMultiSuffix ].
]

{ #category : #accessing }
DMTColorAttributor >> color: rootModels [
	| sortedRootModels coloredRootModels |
	sortedRootModels := self sortRootModels: rootModels.
	coloredRootModels := (sortedRootModels 
		collect: 
			[ :eachRootModel | eachRootModel color: (self assignColorByType: eachRootModel type) ]).
	^coloredRootModels 
	
]

{ #category : #initialize }
DMTColorAttributor >> initialize [
	super initialize.
	palette := DMPalette
		with:
			{#red . #yellow . #blue . #purple . #brown . #magenta . #orange . #green.
			#pink . #tan . #cyan . #lightRed . #lightGreen . #lightMagenta.
			#lightOrange . #lightYellow . #paleGreen . #paleMagenta . #paleOrange.
			#palePeach . #paleRed . #lightBrown . #paleTan . #paleMagenta}
]

{ #category : #sorting }
DMTColorAttributor >> sortAccordingToPalette: aCollection [
	| newPalette |
	newPalette := palette multiSuffixColors asOrderedCollection.
	newPalette
		addAll:
			{palette monoSuffixColor.
			palette monoClassColor.
			palette defaultColor}.
	^ ((1 to: newPalette size)
		collect: [ :cursor | 
			aCollection
				select: [ :aConceptVM | aConceptVM color = (newPalette at: cursor) ] ])
		flattened
]
