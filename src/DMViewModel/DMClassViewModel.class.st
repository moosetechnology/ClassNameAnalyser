Class {
	#name : #DMClassViewModel,
	#superclass : #Object,
	#instVars : [
		'class',
		'color'
	],
	#category : #DMViewModel
}

{ #category : #accessing }
DMClassViewModel >> color [
	^ color
]

{ #category : #accessing }
DMClassViewModel >> color: aColor [
	color := aColor 
]

{ #category : #accessing }
DMClassViewModel >> theClass [
	^ class 
]

{ #category : #accessing }
DMClassViewModel >> theClass: aClass [
	class := aClass 
]
