Class {
	#name : #CNBSpecRoassal,
	#superclass : #SpRoassalPresenter,
	#instVars : [
		'diagram',
		'label',
		'text',
		'button',
		'view'
	],
	#category : #CNBSpec
}

{ #category : #specs }
CNBSpecRoassal class >> defaultSpec [ 
	<spec: #default>
	^ SpPanedLayout newHorizontal 
		position: 35 percent;
		add: (SpBoxLayout newVertical
			add: #label withConstraints: [ :c | c height: self toolbarHeight ];
			add: #text;
			add: #button withConstraints: [ :c | c height: self toolbarHeight ]
			);
		add: #diagram ;
		yourself
]

{ #category : #configuring }
CNBSpecRoassal >> configure: canvas [
	canvas @ RSCanvasController.
	canvas color: self theme backgroundColor.
]

{ #category : #initialization }
CNBSpecRoassal >> connectPresenters [

	label
		label: 'Enter code below. Both view and canvas are accessible'.

	text
		text: self initialCode;
		autoAccept: true.

	button
		label: 'Draw this!';
		action: [ diagram refresh ].

	"This is the code for the Roassal view.
	The block takes both a view and a canvas."
	diagram script: [ :canvas |
		self configure: canvas.
		self textAsBlockClosure value: canvas ]

]

{ #category : #initialization }
CNBSpecRoassal >> initialCode [

	^
'"[:canvas | ]"

	| canvas |
	canvas := RSCanvas new.
	
	RSFlowLayout on: canvas nodes.
	canvas @ RSCanvasController.
	canvas
'
]

{ #category : #initialization }
CNBSpecRoassal >> initializePresenters [
	label := self newLabel.
	text := self newCode.
	button := self newButton.
	diagram := self instantiate: SpRoassalPresenter
]

{ #category : #initialization }
CNBSpecRoassal >> initializeWindow: w [
	w 
		title: 'ClassNamesBlueprint View';
		initialExtent: 800@500.
]

{ #category : #initialization }
CNBSpecRoassal >> release [
	self class instVarNames do: [ :n | self instVarNamed: n put: nil ]
]

{ #category : #initialization }
CNBSpecRoassal >> run [
	<script: 'self new openWithSpec'>
]

{ #category : #initialization }
CNBSpecRoassal >> textAsBlockClosure [
	"This could be made more clever with regard to compilation and runtime errors. But for this simple example it should suffice."

	^ self class compiler
		source: '[:canvas | ' , text text asString , ']';
		logged: false;
		evaluate
]
