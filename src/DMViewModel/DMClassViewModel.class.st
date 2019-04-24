Class {
	#name : #DMClassViewModel,
	#superclass : #Object,
	#instVars : [
		'classRef',
		'color',
		'size'
	],
	#category : #DMViewModel
}

{ #category : #accessing }
DMClassViewModel >> classRef [
	^ classRef
]

{ #category : #accessing }
DMClassViewModel >> classRef: aClassRef [
	classRef := aClassRef
]

{ #category : #accessing }
DMClassViewModel >> color [
	^ color
]

{ #category : #accessing }
DMClassViewModel >> color: aColor [
	color := aColor 
]
