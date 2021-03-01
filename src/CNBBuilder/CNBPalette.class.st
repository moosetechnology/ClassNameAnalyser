Class {
	#name : #CNBPalette,
	#superclass : #Object,
	#instVars : [
		'multiSuffixColors',
		'defaultColor',
		'monoSuffixColor',
		'monoClassColor',
		'traitColor',
		'index'
	],
	#category : #CNBBuilder
}

{ #category : #'instance creation' }
CNBPalette class >> with: aCollectionOfColors [
	^self new
		multiSuffixColors:  aCollectionOfColors
]

{ #category : #selecting }
CNBPalette >> aColorForMultiSuffix [

	"we have 24 important colors"
	index := index +1.
	(index <=  multiSuffixColors size)
	ifTrue: [ ^ multiSuffixColors at: index ].
	
	^ defaultColor
]

{ #category : #accessing }
CNBPalette >> defaultColor [ 
	^Color black
]

{ #category : #accessing }
CNBPalette >> initialize [
	super initialize.
	index := 0
]

{ #category : #accessing }
CNBPalette >> monoClassColor [
	^Color white
]

{ #category : #accessing }
CNBPalette >> monoClassColor: aColor [ 
	monoClassColor := aColor
]

{ #category : #accessing }
CNBPalette >> monoSuffixColor [
	^Color gray
]

{ #category : #accessing }
CNBPalette >> multiSuffixColors [
	^multiSuffixColors
]

{ #category : #accessing }
CNBPalette >> multiSuffixColors: aCollectionOfColors [ 
	multiSuffixColors := aCollectionOfColors collect: [ :aColorName | Color value: aColorName ]
]

{ #category : #accessing }
CNBPalette >> traitColor [
	^Color white
]
