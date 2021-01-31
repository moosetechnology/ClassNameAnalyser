Class {
	#name : #DMPalette,
	#superclass : #Object,
	#instVars : [
		'multiSuffixColors',
		'defaultColor',
		'monoSuffixColor',
		'monoClassColor',
		'traitColor',
		'index'
	],
	#category : #DMBuilder
}

{ #category : #'instance creation' }
DMPalette class >> with: aCollectionOfColors [
	^self new
		multiSuffixColors:  aCollectionOfColors
]

{ #category : #'as yet unclassified' }
DMPalette >> aColorForMultiSuffix [

	"we have 24 important colors"
	index := index +1.
	(index <=  multiSuffixColors size)
	ifTrue: [ ^ multiSuffixColors at: index ].
	
	^ defaultColor
]

{ #category : #accessing }
DMPalette >> defaultColor [ 
	^#black
]

{ #category : #initialization }
DMPalette >> initialize [
	super initialize.
	index := 0
]

{ #category : #accessing }
DMPalette >> monoClassColor [
	^#white
]

{ #category : #accessing }
DMPalette >> monoSuffixColor [
	^#gray
]

{ #category : #accessing }
DMPalette >> multiSuffixColors [
	^multiSuffixColors
]

{ #category : #accessing }
DMPalette >> multiSuffixColors: aCollectionOfColors [ 
	multiSuffixColors := aCollectionOfColors 
]

{ #category : #accessing }
DMPalette >> traitColor [
	^#white
]
