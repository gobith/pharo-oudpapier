Class {
	#name : #GeoOPActionUserConfirm,
	#superclass : #GeoOPAction,
	#instVars : [
		'partTime',
		'user',
		'id'
	],
	#category : #'Geo Oudpapier Persistency'
}

{ #category : #'as yet unclassified' }
GeoOPActionUserConfirm class >> headerString [

	^'UserConfirm'
]

{ #category : #actions }
GeoOPActionUserConfirm >> doIt [
	| collectionPartTime |
	collectionPartTime := user collectionPartTimeAt: partTime.
	collectionPartTime status nextConfirmedStatusOrNil
		ifNotNil: [ :status | collectionPartTime status: status ].
	self persist
]

{ #category : #actions }
GeoOPActionUserConfirm >> fileIn [
	| collectionPartTime |
	id := (substrings at: 3) asInteger.
	user := schedule userAt: id.
	partTime := schedule collectionPartTimes at: (DateAndTime fromSeconds: (substrings at: 4) asInteger).
	collectionPartTime := user collectionPartTimeAt: partTime.
	collectionPartTime status nextConfirmedStatusOrNil
		ifNotNil: [ :status | collectionPartTime status: status ].
	self addToSchedule
]

{ #category : #accessing }
GeoOPActionUserConfirm >> id [
	^ id
]

{ #category : #accessing }
GeoOPActionUserConfirm >> id: anObject [
	id := anObject
]

{ #category : #accessing }
GeoOPActionUserConfirm >> partTime [
	^ partTime
]

{ #category : #accessing }
GeoOPActionUserConfirm >> partTime: anObject [
	partTime := anObject
]

{ #category : #persistence }
GeoOPActionUserConfirm >> persistenceString [
	| ws |
	ws := WriteStream on: String new.
	self addHeaderOn: ws.
	ws
		print: user id;
		nextPut: self separator;
		nextPutAll: partTime dateAndtimeString.
	^ ws contents
]

{ #category : #printing }
GeoOPActionUserConfirm >> prettyStringOn: ws [
	super prettyStringOn: ws.
	ws
		tab;
		nextPutAll: user name;
		tab;
		print: partTime date;
		tab;
		nextPutAll: partTime partTimeString
]

{ #category : #accessing }
GeoOPActionUserConfirm >> user [
	^ user
]

{ #category : #accessing }
GeoOPActionUserConfirm >> user: anObject [
	user := anObject
]
