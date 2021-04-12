"
I am a predefined palette for the ClassNames Distribution.
"
Class {
	#name : #CNBPalette,
	#superclass : #Object,
	#instVars : [
		'multiTokenColors',
		'defaultColor',
		'monoTokenColor',
		'monoClassColor',
		'traitColor',
		'index'
	],
	#category : #CNBBuilder
}

{ #category : #'instance creation' }
CNBPalette class >> with: aCollectionOfColors [
	^self new
		multiTokenColors:  aCollectionOfColors
]

{ #category : #selecting }
CNBPalette >> aColorForMultiToken [
	"we have 24 important colors"
	
	index := index + 1.
	^ (index <=  multiTokenColors size)
		ifTrue: [ multiTokenColors at: index ]
		ifFalse: [ self defaultColor ].
]

{ #category : #accessing }
CNBPalette >> defaultColor [ 

	^ Color black
]

{ #category : #accessing }
CNBPalette >> index [
	^ index
]

{ #category : #accessing }
CNBPalette >> initialize [
	super initialize.
	
	index := 0
]

{ #category : #accessing }
CNBPalette >> monoClassColor [

	^ Color white
]

{ #category : #accessing }
CNBPalette >> monoClassColor: aColor [ 

	monoClassColor := aColor
]

{ #category : #accessing }
CNBPalette >> monoTokenColor [

	^ Color gray
]

{ #category : #accessing }
CNBPalette >> multiTokenColors [

	^ multiTokenColors
]

{ #category : #accessing }
CNBPalette >> multiTokenColors: colorsCollection [ 

	multiTokenColors := colorsCollection 
]

{ #category : #accessing }
CNBPalette >> traitColor [

	^ Color white
]
