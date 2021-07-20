Class {
	#name : #GeoOPUserStatusICan,
	#superclass : #GeoOPUserStatusParticipating,
	#category : #'Geo Oudpapier Domain'
}

{ #category : #accessing }
GeoOPUserStatusICan class >> statusSymbol [

	^#iCan
]

{ #category : #accessing }
GeoOPUserStatusICan class >> userStatusString [

	^'Ik Kan Wel'
]

{ #category : #testing }
GeoOPUserStatusICan >> canChoose [

	^true
]

{ #category : #accessing }
GeoOPUserStatusICan >> color [

	^Color green
]

{ #category : #testing }
GeoOPUserStatusICan >> isICan [
	^ true
]

{ #category : #accessing }
GeoOPUserStatusICan >> nextAdminStatusesOn: coll user: aUser [
	aUser isDriver
		ifTrue: [ coll add: self scheduledDriverStatus ].
	coll
		add: self scheduledStatus;
		add: self iCannotStatus
]

{ #category : #accessing }
GeoOPUserStatusICan >> registrationStatusesOn: aCollection [
	
	aCollection
		add: self iCanStatus;
		add: self iCannotStatus
]

{ #category : #accessing }
GeoOPUserStatusICan >> userButtonString [

	^'Ik Kan Wel'
]
