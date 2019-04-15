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
DMClassViewModel >> classRef [
	^ class 
]

{ #category : #accessing }
DMClassViewModel >> classRef: aClass [
	class := aClass 
]

{ #category : #accessing }
DMClassViewModel >> color [
	^ color
]

{ #category : #accessing }
DMClassViewModel >> color: aColor [
	color := aColor 
]
