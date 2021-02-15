Class {
	#name : #CNBPatternSelector,
	#superclass : #Object,
	#instVars : [
		'cnb'
	],
	#category : #'CNB-Core'
}

{ #category : #'instance creation' }
CNBPatternSelector class >> of: aClassNamesBlueprint [

	^self new
		of: aClassNamesBlueprint
]

{ #category : #'instance creation' }
CNBPatternSelector >> of: aCNB [
	cnb := aCNB
]

{ #category : #'instance creation' }
CNBPatternSelector >> selectHomogeneous [
	
]
