#  Bedriftslotteri
"Bedriftslotteri" skal revolusjonere måten vinlotterier organiseres internt i bedrifter og tilby en
kostnadseffektiv og miljøvennlig løsning som skal være så enkel i bruk at til og med gamle tanter i bedriften
vil ønske å ta den i bruk.

---

## Hvordan starte prosjektet
Løsningen kan nåes her `https://pure-castle-2703.herokuapp.com/`
Domenet bedriftslotteri.no er også kjøpt opp og klargjort for en eventuell deployment.

## Oppsett av utviklermiljø
```ruby
git clone https://github.com/nith/nith-pg4300-14-2
bundle install
rake db:create
rake db:migrate
rake db:seed
```

## Oppsett av testmiljø
```ruby
rake db:test:prepare
#kjør cucumber testene med:
rake cucumber
#eller for vanlig tester
rake test
```

## Tilpasninger som må utføres for overtakelse
Det er blitt benyttet eksterne API'er slik som Stripe, Amazon S3, og liknende som er avhengige av SECRET_KEYS eller PUBLISHABLE_KEYS. Disse må settes for ditt eget miljø dersom løsningen skal utrulles.

## Oppgavebeskrivelse

### Hva skal applikasjonen løse?
"Bedriftslotteri" skal revolusjonere måten vinlotterier organiseres internt i bedrifter og tilby en
kostnadseffektiv og miljøvennlig løsning som skal være så enkel i bruk at til og med gamle tanter i bedriften
vil ønske å ta den i bruk.

### Hvilke forretningsområder skal løsningen dekke?
Det er svært populært med vinlotterier innad i bedrifter i dagens Norge. Undertegnede har hands-on
erfaring med dette fra tidligere jobb og husker med glede hvordan vi benyttet små papirlodd til å holde
styr på vinnere. Samfunnet forøvrig blir stadig mer digitalisert, og vi ser ingen grunn til at dette området
skal være et unntak. “Vinlotteri” skal løse problemet med at papirlapper blir borte, så vel som tilby en
enkel måte å kjøpe loddene på. For hvem er det som går rundt med kontanter i disse dager?

### Hvilke brukere skal ta i bruk applikasjonen?
Både teknisk kompetente og digitale nybegynnere vil få glede av den moderne stilen i applikasjonen. Det
skal oppleves som en lett oppgave å både lage nye trekninger så vel som å kjøpe lodd, uavhengig av om
du benytter telefon, nettbrett eller pc.

## Begrensninger og videre utvikling

### Salgsskjema
Per i dag, hvis en bruker klikker på "Skaff bredriftslotteri i dag!" på forsiden vil det ble navigert til
kontaktsiden. Dette kunne ha vært løst bedre ved å heller navigere til et salgsskjema hvor brukeren kan enkelt
skrive inn informasjon om firmanavn, anall brukere, betalingsinformasjon, osv.

### Selvgående bestillingssystem
Hvis en kunde per i dag ønsker å kjøpe en firmakonto til Bedriftslotteri, må han sende en epost hvor det blir
beskrevet hva som ønskes å kjøpes. Det kunne ha vært spennende å implementere et selvgående system som automatisk
tar imot bestillingen, og gir kunde en epost med firma-nøkkel, slik at kunden kan administrere brukerene selv.



