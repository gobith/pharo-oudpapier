Class {
	#name : #GeoOPPartTimeStatus,
	#superclass : #Object,
	#classInstVars : [
		'singleInstance'
	],
	#category : #'Geo Oudpapier Domain'
}

{ #category : #'instance creation' }
GeoOPPartTimeStatus class >> fromSymbol: aStatusSymbol [

	| statusClass |
	statusClass := self allSubclasses
		detect: [ :statusCls | statusCls singleInstance statusSymbol = aStatusSymbol ]
		ifNone: nil.
	^ statusClass ifNotNil: [ statusClass singleInstance ]
]

{ #category : #'instance creation' }
GeoOPPartTimeStatus class >> new [

	self shouldNotImplement 
]

{ #category : #'instance creation' }
GeoOPPartTimeStatus class >> singleInstance [
	singleInstance
		ifNil: [ singleInstance := self basicNew
				initialize;
				yourself ].
	^ singleInstance
]

{ #category : #accessing }
GeoOPPartTimeStatus >> buttonString [

	^self subclassResponsibility 
]

{ #category : #testing }
GeoOPPartTimeStatus >> canSendMail [

	^false
]

{ #category : #testing }
GeoOPPartTimeStatus >> isActive [

	^true
]

{ #category : #testing }
GeoOPPartTimeStatus >> isArchived [

	^false
]

{ #category : #testing }
GeoOPPartTimeStatus >> isClosed [

	^false
]

{ #category : #testing }
GeoOPPartTimeStatus >> isFinished [

	^false
]

{ #category : #testing }
GeoOPPartTimeStatus >> isVisible [

	^self isArchived not
]

{ #category : #accessing }
GeoOPPartTimeStatus >> nextStatus [

	^self subclassResponsibility 
]

{ #category : #visiting }
GeoOPPartTimeStatus >> scheduleImageFor: aStatus [

	self subclassResponsibility 
]

{ #category : #visiting }
GeoOPPartTimeStatus >> scheduleStringFor: aStatus [

	self subclassResponsibility 
]

{ #category : #accessing }
GeoOPPartTimeStatus >> statusString [

	self subclassResponsibility 
]

{ #category : #accessing }
GeoOPPartTimeStatus >> statusSymbol [

	^self subclassResponsibility 
]
