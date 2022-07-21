# Asistent Automat pentru student la medicină

##UI 
<p float="left">
 <img src="https://user-images.githubusercontent.com/63847951/180194181-e61c0b76-7139-473e-8a2c-12115aa1b9f3.png" width="200" height="400" />
<img src="https://user-images.githubusercontent.com/63847951/180194214-eff10793-8f3c-41f7-a6e9-f2fa89e49552.png" width="200" height="400" />
<img src="https://user-images.githubusercontent.com/63847951/180194222-87551da6-ca74-4139-8891-12ff2f5f2050.png" width="200" height="400" />
<img src="https://user-images.githubusercontent.com/63847951/180194229-2a913720-eef6-4dcd-ae0a-0d4404212558.png" width="200" height="400" />
<img src="https://user-images.githubusercontent.com/63847951/180194238-f24e6b79-2067-47ea-9d6c-5f786e921bfa.png" width="200" height="400" />
</p>


## Ideea de bază
În procesul de învățare desfașurat de un student la medicină ar fi utilă o aplicație (mobilă) care sa îi prezinte vizual informații relevante despre organele și bolile investigate. Astfel se dorește o aplicatie care, plecând de la informații preluate în format RMN, sa permită vizualizarea 3D a unui organ (în întregime sau parțial, din diferite unghiuri, reliefând anumite detalii – de ex. vizualizarea vezicii urinare și a peretelui, cu straturile corespunzatoare, etc.), precum și a unor leziuni posibile (identificarea automată a acestor leziuni și vizualizarea lor – de ex. tumori în vezică).

## Descrierea aplicației

Pentru a ajuta la procesul de învaţare a studenţilor de la medicină aceştia dispun de o aplicaţie mobilă care le prezintă vizual informaţii relevante despre vezica urinară şi peretele acestuia cu straturile corespunzatoare, precum şi a unor leziuni posibile. Prin urmare, plecând de la informaţiile RMN (Imagistica prin rezonanţă magnetică), studenţii pot să vizualizeze 2D imagini cu vezica urinară sau tumori posibile. Un student poate să încarce o arhivă de tipul .rar cu imagini în formatul .jpeg şi să verifice dacă există sau nu malformaţii ale viziicii urinare

## Flow-ul aplicației

După ce aplicaţia porneşte studentul alege opţiunea de încarcare a unei arhive de imaginii în format .jpeg prin butonul "Upload". Arhiva respectivă cu imagini se trimite la server, unde imaginile vor fi preluate de algoritmi inteligenţi care detectează posibilele malformaţii ale vezicii urinare bazându-se pe informaţiile furnizate de utilizator. Serverul returnează o imagine de tip .gif care scoate în evidenţă posibilele anomalii.

## Tehnologii
Pentru acest proiect am folosit Python ca limbaj de programare împreună cu câteva biblioteci utile, cum ar fi: Numpy, Flask. Pe partea de fronted s-a utilizat Angular.

**Python**

Python este un limbaj de programare de uz general de nivel înalt interpretat. Suportă multiple paradigme de programare, inclusiv programare structurată (în special, procedurală), orientată pe obiecte și funcțională. Filosofia sa de design pune accent pe lizibilitatea codului prin utilizarea unei indentări semnificative. Construcțiile sale de limbaj, precum și abordarea orientată pe obiecte urmăresc să ajute programatorii să scrie cod logic clar pentru proiecte mici și mari. 

**Flask**

Flask este un cadru web micro scris în Python. Este clasificat ca un microcadru deoarece nu necesită instrumente sau biblioteci speciale. Nu are un strat de abstractizare a bazei de date, validare de formulare sau orice alte componente în care bibliotecile terțe preexistente oferă funcții comune. Cu toate acestea, Flask acceptă extensii care pot adăuga caracteristici ale aplicației ca și cum ar fi implementate în Flask însuși. Există extensii pentru cartografii obiect-relațional, validarea formularelor, gestionarea încărcării, diverse tehnologii de autentificare deschisă și câteva instrumente comune legate de cadru.

**NumPy**

NumPy este o bibliotecă pentru limbajul de programare Python, adăugând suport pentru matrice și matrice mari, multidimensionale, împreună cu o colecție mare de funcții matematice de nivel înalt pentru a opera pe aceste matrice.

NumPy vizează implementarea de referință CPython a lui Python, care este un interpret de cod de octet care nu se optimizează. Algoritmii matematici scriiți pentru această versiune de Python rulează adesea mult mai lent decât echivalentele compilate. NumPy abordează problema încetinirii parțial prin furnizarea de matrice multidimensionale și funcții și operatori care operează eficient pe matrice, necesitând rescrierea unui cod, mai ales bucle interioare folosind NumPy.

**Angular**

Angular ajută la construirea de aplicații interactive și dinamice pe o singură pagină (SPA) prin caracteristicile sale convingătoare, care includ șabloane, legare bidirecțională, modularizare, gestionarea API-ului RESTful, injectarea dependenței și gestionarea AJAX.

## Instalarea și lansarea aplicației:

- Instalați npm
- Instalați python ultima versiune
- Rulați pip install -r requirements.txt
- Rulați app.py din folderul backend folosind python


- Instalați Node.js care include Node Package Manager
- Instalați CLI-ul Angular la nivel global: npm install -g @angular/cli
- Accesați folderul frontend-assistent și executați comanda npm start


Cerințe:

* Ca utilizator, vreau să pot încărca o arhivă de imagini în format .jpeg.
* Ca utilizator, vreau să pot vedea un .gif cu posibile leziuni.

## Abordare
Abordarea propusă de noi se bazează pe segmentarea imaginii pe regiuni. Scopul segmentării imaginii este de a înţelege şi extrage informaţii din imagini la nivel de pixel. 

Segmentarea imaginii poate fi utilizată pentru recunoaşterea şi localizarea obiectelor, ceea ce oferă o valoare extraordinară în multe aplicaţii. Folosind segmentarea imaginii, o reţea neuronală va fi antrenată pentru a produce o mască în funcţie de pixelii imaginii. În cazul în care dimensiunea imaginii mai mare, atunci se va redimisiona pe lăţime şi lungime înainte de aplicarea algoritmului. 

O mască reprezintă ieşirea produsă de modelul de segmentare a imaginii, iar în rezolvarea noastră am utilizat o mască pentru pentru cavitatea vezicii, tumoare şi pentru peretele vezicii urinare. Pentru a reprezenta această mască, trebuie mai întâi să aplatizam imaginea într-o matrice. Măştile au fost create de mână. 

Tehnicile moderne de segmentare a imaginilor se bazează pe abordarea de învăţare profundă, care utilizează arhitecturi comune, cum ar fi CNN, FCNs (Fully Convolution Networks) şi Deep Encoders Decoders. La acest proiect, arhitectura Res-U-Net este folosită pentru a îndeplini aceast sarcină. 

Pentru segmentarea ROI s-a folosit darknet Vezi Darknet pentru a crea modelul de localizare a vezicii, identificarea peretelui, respectiv a cavităţii vezicii sau a tumorii.

**U-Net**

Structura de algoritm este de forma U-Net Vezi U-Net cu scurtături pe o structură de CNN deoarece oferă o fidelitate bună pentru masca finală chiar dacă este un nivel
scăzut de noduri comparativ cu alte structuri la acelaşi nivel de training.
Operaţia de convoluţie se bazează pe luarea unei secţiuni de 3x3 din tensor centrată pe un anumit nod şi aplicarea unei funcţii pe zona respectivă, rezultatul urmând să fie valoarea nodului în stratul următor.

Pooling-ul este o operaţie a CNN care constă în luarea unei zone de 2x2 şi alegerea valorii maxime din zona respectivă pentru a forma noul layer. Astfel se micşorează mărimea stratului pe 2 dimensiuni cu un factor de 50 la sută.

Operatia de Shortcut sau de adăugare oferă o direcţie mai scurtă pentru informaţia de intrare. Aceasta se realizează prin adaugarea celor două matrici ce reprezintă valorile nodurilor. Scopul operaţiei este de a eficientiza antrenarea prin păstrarea fidelităţi datelor mai adânc în network.
Structura generală este formată dintr-un encoder care transformă imaginea dintr-un spaţiu bidimensional mare pe 2 dimensiuni (imagine 100x100) într-un spaţiu 3d mare pe o dimensiune (4x4x64) abstractizând informaţia imaginii prin straturi convoluţionale şi un decoder care formează operaţia inversă. Aceste doua elemente sunt cuplate transversal pe straturile de aceeaşi mărime pentru a obţine o fidelitate mai clară a maţtii prin concatenarea tensorilor din partea de encoder cu tensori care au trecut prin operaţia de upscale.

Mai concret, CNN-ul are 4 straturi de encoding, şi anume un strat de bridge şi patru straturi de decoder. Fiecare strat de encoding este format dint 2 convoluţii, o adăugare şi o convoluţie finală urmată de o operaţie de activare non liniară ReLU şi o normalizare. Intre straturile de Encoder este o operaţie de Pooling, iar între straturile de Decoder este o operaţie de Upscale. Imediat după operaţia de upscale se realizează o concatenare cu rezultatele stratului echivalent din encoder. Scopul concatenării
este destul de similar cu cel al shortcut-ului, mai exact de a reduce detaliul imagini originale în imagina degradată generată de encoder.

**YOLO**

YOLO (You Only Look Once) este un algoritm care foloseşte reţele neuronale pentru a oferi detectarea obiectelor în timp real. 

YOLO este popular deoarece atinge o precizie ridicată, putând rula în timp real. Algoritmul „se uită doar o data” la imagine, în sensul că necesită o singură trecere de propagare înainte prin rețeaua neuronală pentru a face predicții. După suprimarea non-max (care se asigură că algoritmul de detectare a obiectelor detectează fiecare obiect o singură dată), apoi scoate obiectele recunoscute împreună cu casetele de delimitare. 

YOLO este extrem de rapid și vede întreaga imagine în timpul antrenamentului și testelor, astfel încât în mod implicit codifică informații contextuale despre clase, precum și aspectul acestora.

YOLO învață reprezentări generalizabile ale obiectelor, astfel încât atunci când este antrenat pe imagini naturale și testat pe opere de artă, algoritmul depășește alte metode de detectare de top.

În comparaţie cu alte reţele de clasificare a propunerilor de regiune (RCNN rapid) care efectuează detectarea pe diferite propuneri de regiune ajungând să efectueze predicţii de mai multe ori pentru diferite regiuni dintr-o imagine, arhitectura Yolo seamănă mai mult cu FCNN (reţea neuronală complet convoluţională). YOLO transmite imaginea (nxn) prin FCNN, iar ieşirea este o predicţie (mxm). Această arhitectură împarte imaginea de intrare în grila mxm iar pentru fiecare generaţie de grilă sunt 2 casete de delimitare şi probabilităţi de clasă pentru casetele respective. 

Yolov4 este o îmbunătăţire a algoritmului Yolov3, având o îmbunătăţire a preciziei de medii (mAP) cu până la 10 la sută şi a numărului de cadre pe secundă cu 12 la sută.

**Tensorflow**

Tensorflow este o bibliotecă de inteligenţă artificială open source, care utilizează grafice ale fluxului de date pentru a construi modele. Acesta permite dezvoltatorilor să creeze reţele neuronale la scară largă cu multe straturi.

TensorFlow este folosit în principal pentru:
* Clasificare
* Percepţie
* Înţelegere
* Descoperire
* Creare

## Metodologie

Am folosit o structura de U-net bazată pe un encoder, Stem şi Decoder. Fiecare din cele 4 nivele de encoding, respectiv decoding este format din 2 straturi convoluţionale (Conv2D) şi un shortcut intern care se adaugă la rezultatul acestora.

Downscaling-ul se realizează prin schimbarea stride-ului în cadrul ultimei convoluţii de la 1 la 2, iar stem-ul este format din aceeaşi structură ca şi Decoder-ul, cu excepţia concatenări datelor reziduale de la nivelul corespunzător din Encoder. Structura nivelelor acestora este de 2 convoluţii, un shortcut intern care se adaugă la rezultatul acestora, respectiv un layer de Upsampling.

Pentru a menţine integritatea informaţiei, fiecare layer trece printr-un strat de normalizare yar pentru a creşte fidelitatea imaginii în fiecare nivel de encoder, respectiv fiecare nivel de decoder, astfel se realizează o activare non liniară RELU.

## Date
Pe parcusul proiectului, datele de antrenament s-au îmbunătăţit, optimizând astfel predicţia şi acurateţea algoritmului.

Pentru început am utilizat bucăţi de date de la diferiţi pacienţi la care am creat aroximativ 50 de măşti de mână.

Mai apoi, ne-am axat pe date concrete primite de la un centru medical, mai exact date de antrenament de la 19 pacienţi şi 446 de măşti.

**Primul model**

- Numărul de date de antrenament: 19 pacienţi
- Numărul de teste: 100
- Numărul de măţi: 446 (118 tumoare, 328 perete)
- Rezultate validare: 35% date de validare (40 tumoare, 114 perete)
- Rezultate antrenament: 65% date de antrenament(78 tumoare, 214 perete)


**Al doilea model**

- Numărul de date de antrenament: 19 pacienţi
- Numărul de teste: 100
- Numărul de măţi: 446 (118 tumoare, 328 perete)
- Rezultate validare: 50% date de validare (59 tumoare, 164 perete)
- Rezultate antrenament: 50% date de antrenament (59 tumoare, 164 perete)


## Concluzii
Lucrarea noastră a încercat să ofere un punct de vedere clar şi uşor din perspectiva detectării tumorilor maligne a vezicii urinare pentru a facilita procesul de învăţare şi a creşte productivitatea acestuia pentru studenţii de la medicină şi nu numai.

Puterea rezultatelor noastre constă în utilizarea algoritmului YOLO, care este un detector puternic recunoscut pentru obiecte. Am folosit ultima sa versiune pentru a avea cele mai recente îmbunătăţiri atunci când vorbim despre detectarea posibilelor malformaţii ale vezicii urinare şi a peretelui.

În final, am obţinut o precizie şi o acurateţe mare de 0.788 datorită utilizării de scurtături în reţea
şi un timp de răspuns mic ca urmare a folosirii unui algoritm eficient de ROI.

**Analiza SWOT**

Punctele tari:
* acuratețea detecrării este mare datorită utilizării de scurtături în rețea
* timpul de răspuns este mic datorită utilizării unui algoritm efficient de ROI
* interacțiunea cu aplicația este ușoară datorită folosirii unei platforme compatibilă cu telefoane mobile
* designeul este foarte accesibil și ușor de utilizat

Punctele slabe:
* lipsa datelor
* necesitatea unei conexiuni la internet

Oportunități:
* creşterea datelor de antrenament poate conduce la creşterea predicţiei
* îmbunătățirea calității procesului de învățare
* creșterea productivității de învățare
* oricine poate utiliza aplicația

Amenințări
* existența altor aplicații de același gen

**Lucrări viitoare**

Pentru viitor ne propunem să creştem numărul de date de antrenament pentru a creşte acurateţea algorimului şi predicţia aplicaţiei. Totodată, dorim să analizăm şi cazurile de pietre urinare şi cistita emfizematoasă.

## Link-uri
* [Documentation PDF](./Documentation/Medical_Assistent_Documentation.pdf)  
* [Documentation Overleaf](./Documentation/Medical_Assistent_Documentation.lex)  
* [Presentation Prezi](https://prezi.com/view/DVLFntZ5UDdFk22BzP85/)
* [Teaser](./Documentation/teaser.mp4)
* [Gif](./Documentation/segm.gif)

## Contribuții
* Gherasim Georgian - [GherasimGeorgian](https://github.com/GherasimGeorgian)
* Hârșan Mihnea - [Mihnea-H](https://github.com/Mihnea-H)
* Irimiciuc Andreea - [Iri25](https://github.com/Iri25)

