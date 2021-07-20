Class {
	#name : #GeoOPUser,
	#superclass : #Object,
	#instVars : [
		'schedule',
		'id',
		'name',
		'email',
		'phoneNumber',
		'password',
		'role',
		'websiteRole',
		'collectionPartTimes',
		'exchangeDayTemplate'
	],
	#category : #'Geo Oudpapier Domain'
}

{ #category : #accessing }
GeoOPUser class >> neoJsonMappingOn: mapping [

	"schedule id name email phoneNumber password role websiteRole collectionPartTimes exchangeDayTemplate"

	mapping
		mapInstVar: #id;
		mapInstVar: #name;
		mapInstVar: #email;
		mapInstVar: #phoneNumber;
		mapAccessor: #roleString to: #role;
		mapAccessor: #websiteRoleString to: #websiteRole
		
]

{ #category : #accessing }
GeoOPUser >> activeSortedCollectionPartTimes [

	^self sortedCollectionPartTimes select: [ : partTime | partTime isActive ]
]

{ #category : #accessing }
GeoOPUser >> activeSortedCollectionPartTimesPerAll [
	^ (self activeSortedCollectionPartTimes groupedBy: [ :partTime | '' ]) associations
		asSortedCollection
]

{ #category : #accessing }
GeoOPUser >> activeSortedCollectionPartTimesPerMonth [

	^ (self activeSortedCollectionPartTimes groupedBy: [ :partTime | partTime month index ]) associations
		asSortedCollection
]

{ #category : #accessing }
GeoOPUser >> activeSortedCollectionPartTimesPerTitle [
	^ (self activeSortedCollectionPartTimes groupedBy: [ :partTime | partTime title ]) associations
		asSortedCollection
]

{ #category : #accessing }
GeoOPUser >> collectionPartTimeAt: aCollectionPartTime [
	^ collectionPartTimes
		at: aCollectionPartTime dateAndTime
		ifAbsentPut: [ aCollectionPartTime userCollectionDayClass new
				dateAndTime: aCollectionPartTime dateAndTime;
				partTime: aCollectionPartTime;
				user: self ]
]

{ #category : #accessing }
GeoOPUser >> collectionPartTimeAtDateAndTime: aDateAndTime [
	^ collectionPartTimes at: aDateAndTime
]

{ #category : #accessing }
GeoOPUser >> collectionPartTimes [

	^collectionPartTimes
]

{ #category : #accessing }
GeoOPUser >> decodedUserNamePassword [
	^'?auth=Basic%20' , (ZnUtils encodeBase64: name , ':' , password)
]

{ #category : #accessing }
GeoOPUser >> email [
	^ email
]

{ #category : #accessing }
GeoOPUser >> email: anObject [
	email := anObject
]

{ #category : #accessing }
GeoOPUser >> ensureCollectionPartTimes [

	schedule collectionPartTimes do: [ : partTime | self collectionPartTimeAt: partTime ]
]

{ #category : #accessing }
GeoOPUser >> exchangeDayStep1DateAndTime [
	^ self collectionPartTimes
		detect: [ :each | each dateAndTime = self exchangeDayTemplate step1DateAndTime ]
		ifNone: nil
]

{ #category : #accessing }
GeoOPUser >> exchangeDayTemplate [
	exchangeDayTemplate ifNil: [ exchangeDayTemplate := GeoOPExchangeDayTemplate new ].
	^ exchangeDayTemplate
]

{ #category : #accessing }
GeoOPUser >> firstName [

	^name readStream upTo: Character space
]

{ #category : #accessing }
GeoOPUser >> httpLoginString [

	^'http://185.14.187.114:8080/login<1s>' expandMacrosWith: self decodedUserNamePassword 
]

{ #category : #testing }
GeoOPUser >> iCanOnPartTime: aPartTimeOrNil [
	aPartTimeOrNil ifNil: [ ^ false ].
	^ self collectionPartTimes
		anySatisfy: [ :each | each dateAndTime = aPartTimeOrNil dateAndTime and: [ each status isICan ] ] 
]

{ #category : #accessing }
GeoOPUser >> id [
	^ id
]

{ #category : #accessing }
GeoOPUser >> id: anObject [
	id := anObject
]

{ #category : #testing }
GeoOPUser >> inSchedule [
	^ role inSchedule
]

{ #category : #initialization }
GeoOPUser >> initialize [

	super initialize.
	collectionPartTimes := Dictionary new.
	role := GeoOPNormalRole new.
	websiteRole := GeoOPUserWebsiteNormalRole new.
	password := '1234'
]

{ #category : #testing }
GeoOPUser >> isAdmin [

	^websiteRole isAdmin
]

{ #category : #testing }
GeoOPUser >> isDriver [

	^role isDriver
]

{ #category : #accessing }
GeoOPUser >> name [
	^ name
]

{ #category : #accessing }
GeoOPUser >> name: anObject [
	name := anObject
]

{ #category : #accessing }
GeoOPUser >> password [
	^ password
]

{ #category : #accessing }
GeoOPUser >> password: aString [
	password := aString
]

{ #category : #accessing }
GeoOPUser >> phoneNumber [
	^ phoneNumber
]

{ #category : #accessing }
GeoOPUser >> phoneNumber: anObject [
	phoneNumber := anObject
]

{ #category : #printing }
GeoOPUser >> printOn: aStream [
	
	super printOn: aStream.
	aStream tab; nextPutAll: name
]

{ #category : #accessing }
GeoOPUser >> role [

	^role
]

{ #category : #accessing }
GeoOPUser >> role: aRole [

	role := aRole
]

{ #category : #accessing }
GeoOPUser >> roleString [

	^role roleString
]

{ #category : #accessing }
GeoOPUser >> schedule [
	^ schedule
]

{ #category : #accessing }
GeoOPUser >> schedule: anObject [
	schedule := anObject
]

{ #category : #mail }
GeoOPUser >> sendConfirmMailFor: aPartTime [
	| template |
	template := GeoOPMailMessageConfirm new
		schedule: schedule;
		user: self;
		partTime: aPartTime.
	template send
]

{ #category : #private }
GeoOPUser >> sendMailSubject: subjectString content: contentString [
	| mailMessage |
	mailMessage := MailMessage empty.
	mailMessage setField: 'subject' toString: subjectString.
	mailMessage makeMultipart.
	mailMessage body: (MIMEDocument contentType: 'text/html' content: contentString).
	schedule sendMailMessage: mailMessage to: self.
	^mailMessage
]

{ #category : #'mail old' }
GeoOPUser >> sendMailSubject: subjectString html: html [
	| mailMessage |
	mailMessage := MailMessage empty.
	mailMessage setField: 'subject' toString: subjectString.
	mailMessage addMixedPart: html contentType: 'text/html'.
	schedule sendMailMessage: mailMessage to: self.
	^ mailMessage
]

{ #category : #'mail old' }
GeoOPUser >> sendMailSubject: subjectString text: text html: html [
	| mailMessage |
	mailMessage := MailMessage empty.
	mailMessage setField: 'subject' toString: subjectString.
	mailMessage addMixedPart: text contentType: 'text/plain'.
	mailMessage addMixedPart: html contentType: 'text/html'.
	schedule sendMailMessage: mailMessage to: self.
	^ mailMessage
]

{ #category : #'mail old' }
GeoOPUser >> sendTestMail [
	self
		sendMailSubject: 'Test Mail Oud Papier'
		html: '
		<html>
			<head></head>
			<body>
				<h1>This is html</h1>
				<a href="https://www.w3schools.com/html/">Visit our HTML tutorial</a>
			</body>
		</html>'
]

{ #category : #'mail old' }
GeoOPUser >> sendTestMail2 [
	self
		sendMailSubject: 'Test Mail Oud Papier Test'
		html: '
		<html>
			<head></head>
			<body>
				<h1>Hallo Georges,</h1>
				<p>Je bent ingepland op <b>Zaterdag 18 maart in de ochtend</b> (verzamelen 9:00 uur op de parkeerplaats aan de Sportlaan)</p>
				<a href="https://www.w3schools.com/html/">Druk hier om te bevestigen</a>
				<p><ul><li>test</li><li>test2</li><li>test3</li><li>test4</li><ul></p>
				<p>Alvast bedankt,</p>
				<p>Georges en Rene</p>
				<p>ps Als het niet lukt om te bevestigen of als je verhinderd bent laat het ons zo spoedig mogelijk weten d.m.v. een reply op deze mail</p>
			</body>
		</html>'
]

{ #category : #'mail old' }
GeoOPUser >> sendWelcomMail [
	^ self sendMailSubject: 'Oud Papier ophaalplanning 2017' content: self welcomeContent
]

{ #category : #testing }
GeoOPUser >> showInSchedule [

	^role showInSchedule
]

{ #category : #accessing }
GeoOPUser >> sortedCollectionPartTimes [

	^collectionPartTimes asSortedCollection: [ : dayA : dayB | dayA dateAndTime <= dayB dateAndTime ]
]

{ #category : #accessing }
GeoOPUser >> sortedCollectionPartTimesPerTitle [
	^ (self sortedCollectionPartTimes groupedBy: [ :partTime | partTime title ]) associations
		asSortedCollection
]

{ #category : #'mail test' }
GeoOPUser >> testSendConfirmMail [

	self sendConfirmMailFor: collectionPartTimes values first partTime
]

{ #category : #printing }
GeoOPUser >> userNamePasswordString [
	^ 'Gebruikers naam(vergeet niet de spatie):%<br%><1s>%<br%>Wachtwoord:%<br%><2s>' expandMacrosWith: name with: password
]

{ #category : #accessing }
GeoOPUser >> visibleCollectionPartTimes [
	
	
	^self collectionPartTimes select: [ : partTime | partTime isVisible ]
]

{ #category : #accessing }
GeoOPUser >> websiteRole [

	^websiteRole
]

{ #category : #accessing }
GeoOPUser >> websiteRole: aRole [

	websiteRole := aRole
]

{ #category : #accessing }
GeoOPUser >> websiteRoleString [ 

	^websiteRole roleString
]

{ #category : #'mail old' }
GeoOPUser >> welcomeContent [
	^ 'Beste <1s>,

Afgelopen 21e januari hebben we voor het eerst oud papier ingezameld met de nieuwe afvalverwerker Remondis. We hebben dit nog op de "oude" manier gedaan, met 3 vrachtwagens en een personenauto met kar. Ondanks het feit dat de vrachtwagenchauffeurs de papierinzameling voor het eerst deden en de vrachtwagens nog wat te wensen over lieten, is alles vlekkeloos verlopen. De terugkoppeling die ik vanuit Remondis heb gekregen is dat ze erg onder de indruk waren van de professionele wijze waarop de AC Waterland vrijwilligers de inzameling doen en heel blij zijn met de samenwerking.

Vanaf februari gaan we de inzameling op de nieuwe manier doen.
Op de 3e zaterdag van de maand zamelen we in ten oosten van het lint in de ochtend en middag. We doen dan de huidige Havezathe- en Oude Dorp routes. De personenauto met kar rijdt op deze dag z''n reguliere route alleen in de ochtend. De bedoeling is om dan met een ochtend- en een middagteam te gaan werken. Op de 4e zaterdag van de maand zamelen we in de ochtend in ten westen van het lint (Luyendijk en een paar zijstraten van de Dorpsstraat). Er worden een paar kleine wijzigingen doorgevoerd in de routes, maar eigenlijk blijven ze nagenoeg zoals ze nu zijn. Doelstelling voor dit jaar is wel om actief te gaan onderzoeken of we de inzet van de kar kunnen gaan beperken. Op de 21e hebben we op een paar plaatsen al gekeken wat de mogelijkheden waren en dat zag er hoopvol uit.

Concreet ziet de planning en de benodigde inzet er komende tijd zo uit:

De 3e zaterdag van de maand in de ochtend:
- 2 vrijwilligers op de vrachtwagen
- Personenauto met kar met een bestuurder en 2 vrijwilligers

De 3e zaterdag van de maand in de middag:
- 2 vrijwilligers op de vrachtwagen

De 4e zaterdag van de maand in de ochtend:
- 2 vrijwilligers op de vrachtwagen

De totale inzet van ACW vrijwilligers blijft op deze manier gelijk, maar vindt alleen op verschillende tijden plaats. Het geeft jou als vrijwilliger dus meer mogelijkheden om te kiezen. Niet alleen uit het aantal zaterdagen, maar ook of je liever in de ochtend of middag helpt.

We willen nu dus de planning voor de rest van het jaar gaan maken. Om dit makkelijker te doen hebben we een website gebouwd waarop je makkelijk kunt aangeven wanneer je wel en niet wilt/kunt helpen. Ook kun je zelf tussentijds eenvoudig wijzigingen aanbrengen bij veranderingen in je beschikbaarheid. Je ontvangt hierbij een persoonlijke gebruikersnaam en wachtwoord voor de site, maar er staat onderaan deze mail ook een persoonlijke link naar de website waarmee je direct inlogt.

Ons verzoek aan jou is of je op de website wilt aangeven wanneer je beschikbaar bent om te helpen. Wij zullen dan zo spoedig mogelijk een definitieve planning maken waarbij de inzet van alle vrijwilligers zo evenredig mogelijk wordt verdeeld.

Als je problemen ondervindt, vragen hebt en/of hulp nodig hebt, laat het dan even weten door middel van een reply op deze mail.

Alvast hartelijk dank!
Georges Kerssies
Rene Schaap

Website:
http://oudpapieracw.pharocloud.com

Gebruikers naam (vergeet niet de spatie):
<4s>

Wachtwoord:
<2s>

Meteen inloggen:
http://oudpapieracw.pharocloud.com/login<3s>&a=b'
		expandMacrosWith: self firstName
		with: password
		with: self decodedUserNamePassword
		with: name
]

{ #category : #printing }
GeoOPUser >> welcomeHtmlStringOn: aWriteStream [
	GeoScheduleDataDispatcher welcomeHtmlStringOn: aWriteStream user: self
]
