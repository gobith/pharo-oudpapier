Class {
	#name : #GeoOPActionConfirmMailPerUser,
	#superclass : #GeoOPAction,
	#instVars : [
		'partTime',
		'user',
		'id',
		'errorString'
	],
	#category : #'Geo Oudpapier Persistency'
}

{ #category : #private }
GeoOPActionConfirmMailPerUser class >> headerString [

	^'ConfirmMailPerUser'
]

{ #category : #actions }
GeoOPActionConfirmMailPerUser >> doIt [
	
	self persist
]

{ #category : #accessing }
GeoOPActionConfirmMailPerUser >> errorString [
	^ errorString
]

{ #category : #accessing }
GeoOPActionConfirmMailPerUser >> errorString: anObject [
	errorString := anObject
]

{ #category : #actions }
GeoOPActionConfirmMailPerUser >> fileIn [
	partTime := schedule collectionPartTimeAt: (DateAndTime fromSeconds: (substrings at: 3) asInteger).
	id := (substrings at: 4) asInteger.
	user := schedule userAt: id.
	errorString := substrings at: 5.
	self addToSchedule
]

{ #category : #accessing }
GeoOPActionConfirmMailPerUser >> id [
	^ id
]

{ #category : #accessing }
GeoOPActionConfirmMailPerUser >> id: anInt [

	id := anInt
]

{ #category : #accessing }
GeoOPActionConfirmMailPerUser >> partTime [
	^ partTime
]

{ #category : #accessing }
GeoOPActionConfirmMailPerUser >> partTime: anObject [
	partTime := anObject
]

{ #category : #persistence }
GeoOPActionConfirmMailPerUser >> persistenceString [
	| ws |
	ws := WriteStream on: String new.
	self addHeaderOn: ws.
	ws
		nextPutAll: partTime dateAndtimeString;
		nextPut: self separator;
		print: user id;
		nextPut: self separator;
		nextPutAll: errorString.
	^ ws contents
]

{ #category : #printing }
GeoOPActionConfirmMailPerUser >> prettyStringOn: ws [
	super prettyStringOn: ws.
	ws
		tab;
		nextPutAll: user name;
		tab;
		nextPutAll: partTime prettyString;
		tab;
		nextPutAll: errorString
]

{ #category : #accessing }
GeoOPActionConfirmMailPerUser >> user [
	^ user
]

{ #category : #accessing }
GeoOPActionConfirmMailPerUser >> user: anObject [
	user := anObject
]
