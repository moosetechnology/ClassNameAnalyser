"
I am responsible for attributing colors to root models according to the type of the class.
"
Trait {
	#name : #CNBTColorAttributor,
	#instVars : [
		'palette'
	],
	#category : #'CNBBuilder-Traits'
}

{ #category : #assignments }
CNBTColorAttributor >> assignColorByType: aType [

	(aType = CNBClassType trait)
	ifTrue: [ ^palette traitColor ].
	
	(aType = CNBClassType monoClass)
	ifTrue: [ ^palette monoClassColor ].
	
	(aType = CNBClassType monoToken)
	ifTrue: [  ^palette monoTokenColor ].
	
	(aType = CNBClassType multiToken)
	ifTrue: [ ^palette aColorForMultiToken ].
]

{ #category : #accessing }
CNBTColorAttributor >> color: rootModels [

	^ (self 
			sortRootModels: rootModels)
					collect: [ :each | each 
									color: (self assignColorByType: each type).
									"colorPriorityNumber: "
									 ].

	
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
	newPalette := palette multiTokenColors asOrderedCollection.
	
	newPalette
		addAll:
			{palette monoTokenColor.
			palette monoClassColor.
			palette defaultColor}.
			
	^ ((1 to: newPalette size)
		collect: [ :cursor | 
			aCollection
				select: [ :aConceptVM | aConceptVM color = (newPalette at: cursor) ] ])
		flattened
]
