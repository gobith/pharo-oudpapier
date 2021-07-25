Class {
	#name : #GeoOPUserStatusScheduledDriver,
	#superclass : #GeoOPUserStatusParticipating,
	#category : #'Geo Oudpapier Domain'
}

{ #category : #accessing }
GeoOPUserStatusScheduledDriver class >> statusSymbol [

	^#scheduledDriver
]

{ #category : #accessing }
GeoOPUserStatusScheduledDriver class >> userStatusString [


	^'Ingepland Chauffeur'
]

{ #category : #accessing }
GeoOPUserStatusScheduledDriver >> color [

	^Color blue
]

{ #category : #testing }
GeoOPUserStatusScheduledDriver >> isScheduled [

	^true
]

{ #category : #testing }
GeoOPUserStatusScheduledDriver >> isScheduledDriver [

	^true
]

{ #category : #accessing }
GeoOPUserStatusScheduledDriver >> nextAdminStatusesOn: coll [ 
	coll
		add: self iCanStatus;
		add: self iCannotStatus
]

{ #category : #accessing }
GeoOPUserStatusScheduledDriver >> nextAdminStatusesOn: coll user: aUser [
	coll
		add: self iCanStatus;
		add: self iCannotStatus;
		add: self confirmedDriverStatus
]

{ #category : #accessing }
GeoOPUserStatusScheduledDriver >> nextConfirmedStatusOrNil [

	^self confirmedDriverStatus
]

{ #category : #'accessing schedule' }
GeoOPUserStatusScheduledDriver >> scheduleImageClosed [

	^'/resources/20_kar_confirm.png'
]

{ #category : #'accessing schedule' }
GeoOPUserStatusScheduledDriver >> scheduleImageFinished [

	^'/resources/20_kar_finished.png'
]

{ #category : #'accessing schedule' }
GeoOPUserStatusScheduledDriver >> scheduleImageOpen [

	^'/resources/20_kar.png'
]

{ #category : #accessing }
GeoOPUserStatusScheduledDriver >> userButtonString [

	^'Plan in Chauffeur'
]
