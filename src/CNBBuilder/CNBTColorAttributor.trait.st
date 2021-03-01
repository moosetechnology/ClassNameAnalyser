Trait {
	#name : #CNBTColorAttributor,
	#instVars : [
		'palette'
	],
	#category : #CNBBuilder
}

{ #category : #assignments }
CNBTColorAttributor >> assignColorByType: aType [

	(aType = CNBClassType trait)
	ifTrue: [ ^palette traitColor ].
	
	(aType = CNBClassType monoClass)
	ifTrue: [ ^palette monoClassColor ].
	
	(aType = CNBClassType monoSuffix)
	ifTrue: [  ^palette monoSuffixColor ].
	
	(aType = CNBClassType multiSuffix)
	ifTrue: [ ^palette aColorForMultiSuffix ].
]

{ #category : #accessing }
CNBTColorAttributor >> color: rootModels [
	| sortedRootModels coloredRootModels |
	sortedRootModels := self sortRootModels: rootModels.
	coloredRootModels := (sortedRootModels 
		collect: 
			[ :eachRootModel | eachRootModel color: (self assignColorByType: eachRootModel type) ]).
	^coloredRootModels 
	
]

{ #category : #initialize }
CNBTColorAttributor >> initialize [
	super initialize.
	palette := CNBPalette
		with:
			{#red . #yellow . #blue .#purple . #brown . #magenta . #orange . #green.
			#pink . #tan . #cyan . #lightRed . #lightGreen . #lightMagenta.
			#lightOrange . #lightYellow . #paleGreen . #paleMagenta . #paleOrange.
			#palePeach . #paleRed . #lightBrown . #paleTan . #paleMagenta}
]

{ #category : #sorting }
CNBTColorAttributor >> sortAccordingToPalette: aCollection [
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
