Class {
	#name : #GeoOPActionUpdatePartTimeStatus,
	#superclass : #GeoOPAction,
	#instVars : [
		'partTime',
		'status'
	],
	#category : #'Geo Oudpapier Persistency'
}

{ #category : #private }
GeoOPActionUpdatePartTimeStatus class >> headerString [

	^'UpdatePartTimeStatus'
]

{ #category : #actions }
GeoOPActionUpdatePartTimeStatus >> doIt [
	partTime status = status
		ifTrue: [ ^ self ].
	partTime status: status.
	
	self persist
]

{ #category : #actions }
GeoOPActionUpdatePartTimeStatus >> fileIn [
	
	partTime := schedule collectionPartTimeAt: (DateAndTime fromSeconds: (substrings at: 3) asInteger).
	status := GeoOPPartTimeStatus fromSymbol: (substrings at: 4) asSymbol.
	partTime status: status.
	self addToSchedule
]

{ #category : #accessing }
GeoOPActionUpdatePartTimeStatus >> partTime [
	^ partTime
]

{ #category : #accessing }
GeoOPActionUpdatePartTimeStatus >> partTime: anObject [
	partTime := anObject
]

{ #category : #persistence }
GeoOPActionUpdatePartTimeStatus >> persistenceString [
	| ws |
	ws := WriteStream on: String new.
	self addHeaderOn: ws.
	ws
		nextPutAll: partTime dateAndtimeString;
		nextPut: self separator;
		nextPutAll: status statusSymbol.
	^ ws contents
]

{ #category : #printing }
GeoOPActionUpdatePartTimeStatus >> prettyStringOn: ws [
	super prettyStringOn: ws.
	ws
		tab;
		nextPutAll: partTime prettyString;
		tab;
		nextPutAll: status statusString
]

{ #category : #accessing }
GeoOPActionUpdatePartTimeStatus >> status [
	^ status
]

{ #category : #accessing }
GeoOPActionUpdatePartTimeStatus >> status: anObject [
	status := anObject
]
