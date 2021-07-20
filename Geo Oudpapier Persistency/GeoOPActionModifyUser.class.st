Class {
	#name : #GeoOPActionModifyUser,
	#superclass : #GeoOPAction,
	#instVars : [
		'user',
		'id',
		'name',
		'email',
		'phoneNumber'
	],
	#category : #'Geo Oudpapier Persistency'
}

{ #category : #private }
GeoOPActionModifyUser class >> headerString [

	^'ModifyUser'
]

{ #category : #actions }
GeoOPActionModifyUser >> doIt [
	user
		name: name;
		email: email;
		phoneNumber: phoneNumber.
	self persist
]

{ #category : #accessing }
GeoOPActionModifyUser >> email [
	^ email
]

{ #category : #accessing }
GeoOPActionModifyUser >> email: anObject [
	email := anObject
]

{ #category : #actions }
GeoOPActionModifyUser >> fileIn [
	id := (substrings at: 3) asInteger.
	name := substrings at: 4.
	email := substrings at: 5 ifAbsent: [''].
	phoneNumber := substrings at: 6 ifAbsent: [''].
	user := schedule userAt: id.
	user
		name: name;
		email: email;
		phoneNumber: phoneNumber.
	self addToSchedule
]

{ #category : #accessing }
GeoOPActionModifyUser >> id [
	^ id
]

{ #category : #accessing }
GeoOPActionModifyUser >> id: anObject [
	id := anObject
]

{ #category : #accessing }
GeoOPActionModifyUser >> name [
	^ name
]

{ #category : #accessing }
GeoOPActionModifyUser >> name: anObject [
	name := anObject
]

{ #category : #persistence }
GeoOPActionModifyUser >> persistenceString [
	| ws |
	ws := WriteStream on: String new.
	self addHeaderOn: ws.
	ws
		print: user id;
		nextPut: self separator;
		nextPutAll: name;
		nextPut: self separator;
		nextPutAll: email;
		nextPut: self separator;
		nextPutAll: phoneNumber.
	^ ws contents
]

{ #category : #accessing }
GeoOPActionModifyUser >> phoneNumber [
	^ phoneNumber
]

{ #category : #accessing }
GeoOPActionModifyUser >> phoneNumber: anObject [
	phoneNumber := anObject
]

{ #category : #accessing }
GeoOPActionModifyUser >> user [
	^ user
]

{ #category : #accessing }
GeoOPActionModifyUser >> user: anObject [
	user := anObject
]
