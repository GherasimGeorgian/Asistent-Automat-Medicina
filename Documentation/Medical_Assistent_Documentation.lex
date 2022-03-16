\documentclass[runningheads,a4paper,11pt]{report}

\usepackage{algorithmic}
\usepackage{algorithm} 
\usepackage{array}
\usepackage{amsmath}
\usepackage{amsfonts}
\usepackage{amssymb}
\usepackage{amsthm}
\usepackage{caption}
\usepackage{comment} 
\usepackage{epsfig} 
\usepackage{fancyhdr}
\usepackage[T1]{fontenc}
\usepackage{geometry} 
\usepackage{graphicx}
\usepackage[colorlinks]{hyperref} 
\usepackage[latin1]{inputenc}
\usepackage{multicol}
\usepackage{multirow} 
\usepackage{rotating}
\usepackage{setspace}
\usepackage{subfigure}
\usepackage{url}
\usepackage{verbatim}
\usepackage{xcolor}

\geometry{a4paper,top=3cm,left=2cm,right=2cm,bottom=3cm}

\pagestyle{fancy}
\fancyhf{}
\fancyhead[LE,RO]{MedicalAssistent}
\fancyhead[RE,LO]{MedSegm}
\fancyfoot[RE,LO]{MIRPR 2020-2021}
\fancyfoot[LE,RO]{\thepage}

\renewcommand{\headrulewidth}{2pt}
\renewcommand{\footrulewidth}{1pt}
\renewcommand{\headrule}{\hbox to\headwidth{%
  \color{lime}\leaders\hrule height \headrulewidth\hfill}}
\renewcommand{\footrule}{\hbox to\headwidth{%
  \color{lime}\leaders\hrule height \footrulewidth\hfill}}

\hypersetup{
pdftitle={artTitle},
pdfauthor={name},
pdfkeywords={pdf, latex, tex, ps2pdf, dvipdfm, pdflatex},
bookmarksnumbered,
pdfstartview={FitH},
urlcolor=cyan,
colorlinks=true,
linkcolor=red,
citecolor=green,
}

\setcounter{secnumdepth}{3}
\setcounter{tocdepth}{3}

\linespread{1}

\makeindex


\begin{document}

\begin{titlepage}
\sloppy
\begin{center}
UNIVERSITATEA BABE\c S BOLYAI, CLUJ NAPOCA, ROM\^ANIA

FACULTATEA DE MATEMATIC\u{A} \c{S}I INFORMATIC\u{A}

\vspace{6cm}

\Huge \textbf{MEDICAL ASSISTENT}

\vspace{1cm}

\normalsize -- MIRPR --

\end{center}


\vspace{5cm}

\begin{flushright}
\Large{\textbf{Membrii Echipei}}\\
Gherasim Georgian, Informatic\u{a}, 233\\
H\^ar\c san Mihnea, Informatic\u{a}, 233\\
Irimiciuc Andreea, Informatic\u{a}, 237
\end{flushright}

\vspace{4cm}

\begin{center}
2021-2022
\end{center}

\end{titlepage}

\pagenumbering{gobble}

\begin{abstract}

Cancerul vezicii urinare este una dintre cele mai frecvente \c{s}i mai costisitoare afec\c{t}iuni maligne umane de tratat. Succesul tratamentului depinde de stadiul tumorii primare \c{s}i de starea ganglionilor limfatici regionali \href{https://seer.cancer.gov/statfacts/html/urinb.html}{Vezi rata de cazuri noi \c{s}i decese} \c{s}i \href{https://publications.jrc.ec.europa.eu/repository/handle/JRC101380}{epidemiologia cancerului vezicii urinare}.

Asistentul automatizat abordeaz\u{a} problema proces\u{a}rii \c{s}i clasificarea imaginilor venind astfel \^{i}n sprijinul studen\c{t}ilor de la medicin\u{a} pentru o mai bun\u{a} \^{i}n\c{t}elegere \c{s}i interpretare a diagnosticului prezent\^{a}nd vizual informa\c{t}ii caracteristice. Aceast\u{a} aplica\c{t}ie are rolul de a \^{i}mbun\u{a}t\u{a}\c{t}i calitatea procesului de \^{i}nv\u{a}\c{t}are \c{s}i asimilarea de noi cuno\c{s}tin\c{t}e \^{i}ntr-o manier\u{a} mai atractiv\u{a} cu ajutorul algoritmilor inteligen\c{t}i.
	
Metoda noastr\u{a} se bazeaz\u{a} pe segmentarea imaginilor pe regiuni folosind m\u{a}\c{s}ti pentru organele investigate. Pentru crearea modelului de localizare a organelor, segmentarea ROI, am utilizat o re\c{t}ea de tip darknet. Structura algoritmului este de forma U-Net cu scurt\u{a}turi pe o structur\u{a} de Convolutional Neural Network. Pentru detectarea obiectelor \^{i}n timp real am folosind \c{s}i algoritmul YOLO \c{s}i biblioteca Tensorflow pentru contruirea modelelor.

\^{I}n final, am ob\c{t}inut o precizie \c{s}i o acurate\c{t}e mare de 0.788 datorit\u{a} utiliz\u{a}rii de scurt\u{a}turi \^{i}n re\c{t}ea \c{s}i un timp de r\u{a}spuns mic datorit\u{a} folosirii unui algoritm eficient de ROI.
\end{abstract}


\tableofcontents

\newpage

\listoftables
\listoffigures
\listofalgorithms

\newpage

\setstretch{1.5}

\newpage

\pagenumbering{arabic}

\chapter{Introducere}
\label{chapter:introduction}

\section{Descrierea aplica\c{t}iei}
\label{section:what}

Pentru a ajuta la procesul de \^{i}nva\c{t}are a studen\c{t}ilor de la 
medicin\u{a} ace\c{s}tia dispun de o aplica\c{t}ie mobil\u{a} care le prezint\u{a}
vizual informa\c{t}ii relevante despre vezica urinar\u{a} \c{s}i peretele 
acestuia cu straturile corespunzatoare, precum \c{s}i a unor leziuni 
posibile.
Prin urmare, plec\^{a}nd de la informa\c{t}iile RMN (Imagistica prin rezonan\c{t}\u{a} magnetic\u{a}), studen\c{t}ii pot s\u{a} vizualizeze 2D imagini cu vezica urinar\u{a} sau 
tumori posibile. 
Un student poate s\u{a} \^{i}ncarce o arhiv\u{a} de tipul .rar cu imagini \^{i}n formatul .jpeg \c{s}i s\u{a} verifice dac\u{a} exist\u{a} sau nu malforma\c{t}ii ale viziicii urinare.

\begin{itemize}
	\item Care este problema (\c{s}tiin\c{t}ific\u{a})? 
	
	Problema abordeaz\u{a} procesarea limbajului natural, \^{i}n\c{t}elegerea limbajului natural \c{s}i clasificarea imaginilor. Utilizatorul va \^{i}ncarca o arhiv\u{a} de imaginii cu vezica urinar\u{a} \^{i}n format .jpeg pentru detectarea posibilelor anomalii. Algoritmii inteligen\c{t}i de pe server vor deduce dac\u{a} sunt malforma\c{t}ii la nivelul vezicii urinare \c{s}i vor returna un fi\c{s}ier .gif c\u{a}tre utilizator facilit\u{a}nd astfel procesul de \^{i}nv\u{a}\c{t}are pentru studen\c{t}ii de la medicin\u{a}.

	\item  De ce este important?
	
	Aceast\u{a} aplica\c{t}ie este un asistent automatizat pentru studen\c{t}ii de la medicin\u{a}, ceea ce \^{i}nseamn\u{a} c\u{a} va prezenta vizual informa\c{t}ii relevante despre vezica urinar\u{a} \c{s}i peretele acesteia cu straturile corespunzatoare, precum \c{s}i a unor leziuni posibile sau tumori.

	\item Care este abordarea de baz\u{a}?
	
	Construim un prototip care demonstreaz\u{a} func\c{t}ionalit\u{a}\c{t}ile de baz\u{a} ale aplica\c{t}iei. Aceasta include \^{i}nc\u{a}rcarea unei arhive de imagini \c{s}i recunoa\c{s}terea tumorilor maligne a vezicii urinare din setul de date \^{i}nc\u{a}rcat de c\u{a}tre utilizator folosind API-ului Upload \^{i}mpreun\u{a} cu AI-ul nostru pentru a oferi informa\c{t}ii potrivite.
\end{itemize}

 \begin{figure}[h]
\graphicspath {  { ./images/ }  }
\caption{Mindmap}
\centering
\includegraphics [scale=0.25] { mindmap }
\label{mindmap}
\end{figure}

\section{Flow-ul aplica\c{t}iei}
\label{section:structure}

 \begin{figure}[h]
\graphicspath {  { ./images/ }  }
\caption{Schema flow-ului aplica\c{t}iei}
\centering
\includegraphics [scale=0.7] { metoda }
\label{schema_flow}
\end{figure}

Dup\u{a} ce aplica\c{t}ia porne\c{s}te studentul alege op\c{t}iunea de 
\^{i}ncarcare a unei arhive de imaginii \^{i}n format .jpeg prin butonul "Upload". Arhiva respectiv\u{a} cu imagini se trimite la server, unde imaginile vor fi preluate de algoritmi inteligen\c{t}i care detecteaz\u{a} posibilele malforma\c{t}ii ale vezicii urinare baz\^{a}ndu-se pe informa\c{t}iile furnizate de utilizator. Serverul returneaz\u{a} o imagine de tip .gif care scoate \^{i}n eviden\c{t}\u{a} posibilele anomalii.

\newpage
 \begin{figure}[h]
\graphicspath {  { ./images/ }  }
\caption{Diagrama flow-ului aplica\c{t}iei}
\centering
\includegraphics [scale=0.425] { flow_diagram }
\label{diagram_flow}
\end{figure}

\chapter{Problema \c{s}tiin\c{t}ific\u{a}}
\label{section:scientificProblem}


\section{Descrierea problemei}
\label{section:problemDefinition}

Algoritmii de inteligen\c{t}\u{a} artificial\u{a} au rol important pentru culegerea datelor, contribuie la procesele de diagnosticare, la dezvoltarea protocolului de tratament, la dezvoltarea medicamentelor sau \c{s}i \^{i}n medicina personalizat\u{a}.
\^{I}n analizarea problemei vom utiliza 4 cazuri:
\begin{itemize}
	\item cazul normal
 	\item tumoare malign\u{a} sau neoplasm malign
 	\item pietre urinare
 	\item  cistita emfizematoas\u{a}
\end{itemize}

Din punct de vedere plastic, pe baza unei imagini RMN a unei vezici urinare se poate  observa unul dintre cele 4 cazuri analiz\^{a}nd imaginea la nivelul pixelilor utiliz\^{a} algoritmi inteligen\c{t}i pe imagini.

Din punctul de vedere formal avem proiectarea unui algoritm ce realizeaz\u{a} clasificarea vezicii urinare dintr-o imagine RMN \^{i}n 4 clase. 
Algoritmul analizeaz\u{a} vezica cu ajutorul unei re\c{t}ele CNN (vezi Figure \ref{cnn}) \c{s}i 
determin\u{a} dac\u{a} vezica este sanatoas\u{a} sau nu.


\chapter{Stadiul artei/Lucr\u{a}ri conexe}
\label{chapter:stateOfArt}

\^{I}n contextul cercet\u{a}rii noastre ne-am bazat pe lucr\u{a}ri, cum ar fi: pentru detectarea tumorilor pe creier
  \href{https://github.com/Aryavir07/Detecting-Brain-Tumor-Using-Deep-Learning}
{Vezi detectarea tumorii cerebrale}, segmentarea automat\u{a} a prostatei \c{s}i a zonelor de prostat\u{a} \href{https://www.nature.com/articles/s41598-020-71080-0}
{Vezi segmentarea prostatei \c{s}i a zonelor de prostat\u{a}}.
De asemenea, ne-am axat  pe algoritmi \c{s}i metode inteligente de \^{i}nv\u{a}\c{t}are. 

\^{I}n primul stadiu al cercet\u{a}rii am utilizat informa\c{t}ii \c{s}i surse de date de pe  \href{https://www.cancerimagingarchive.net/tcia-analysis-results/}{Data analysis}
pentru diferite etape ale tumorii pentru vezica urinar\u{a} \href{https://www.ncbi.nlm.nih.gov/pmc/articles/PMC6690492/}{Vezi standalizarea cancerului vezicii urinare} la care am aplicat algoritmi pentru segmentarea imagilor \c{s}i antrenarea algoritmului folosind m\u{a}\c{s}ti create de m\u{a}n\u{a}, aproximativ 50 de m\u{a}\c{s}ti \^{i}n prima faz\u{a}. 

\^{I}n a doua parte a cercet\u{a}rii ne-am axat pe un set de date de la 19 pacien\c{t}i primit de la un centru medical. Algoritmul a fost optimizat \c{s}i antrenat pe noul set de date cu m\u{a}\c{s}tile generate, un total de 446 de m\u{a}\c{s}ti pe baza datelor noi.

\^{I}n final, s-a ob\c{t}inut o precizie \c{s}i o acurate\c{t}e foarte bun\u{a}, fiind mai mare de 0.7.

\newpage
\begin{figure}[h]
\graphicspath {  { ./images/ }  }
Mai jos este prezentat o compara\c{t}ie de algoritmi:
\caption{SOTA (State of the art)}
\centering
\includegraphics [scale=0.32] { coco }
%\includegraphics[width=\linewidth]{coco}
\label{sota}
\end{figure}
Putem observa ca Scaled-YOLOv4 este de 3.7x mai rapid dec\u{a}t EfficientDet pentru un batch de 100 de imagini \c{s}i average precision de 55.

%\begin{itemize}
%	\item What is their problem and method? 
%	\item How is your problem and method different? 
%	\item Why is your problem and method better?
%\end{itemize}

\chapter{Abordare propus\u{a}}
\label{chapter:proposedApproach}

Abordarea propus\u{a} de noi se bazeaz\u{a} pe segmentarea imaginii pe regiuni. Scopul segment\u{a}rii imaginii este de a \^{i}n\c{t}elege \c{s}i extrage informa\c{t}ii din imagini la nivel de pixel.

Segmentarea imaginilor medicale este un pas important de procesare a imaginii. Compararea imaginilor pentru a evalua calitatea segment\u{a}rii este o parte esen\c{t}ial\u{a} a m\u{a}sur\u{a}rii progresului \^{i}n acest domeniu de cercetare \href{https://github.com/RonaldGalea/imATFIB}{Vezi Deep Learning de segmentare a imaginilor medicale}.

Segmentarea imaginii poate fi utilizat\u{a} pentru recunoa\c{s}terea \c{s}i localizarea obiectelor, ceea ce ofer\u{a} o valoare extraordinar\u{a} \^{i}n multe aplica\c{t}ii.

Folosind segmentarea imaginii, o re\c{t}ea neuronal\u{a} va fi antrenat\u{a} pentru a produce o masc\u{a} \href{https://www.kaggle.com/robertkag/rle-to-mask-converter}{Vezi Mask Converter} \^{i}n func\c{t}ie de pixelii imaginii. \^{I}n cazul \^{i}n care dimensiunea imaginii mai mare, atunci se va redimisiona pe l\u{a}\c{t}ime \c{s}i lungime \^{i}nainte de aplicarea algoritmului.

O masc\u{a} reprezint\u{a} ie\c{s}irea produs\u{a} de modelul de segmentare a imaginii, iar \^{i}n rezolvarea noastr\u{a} am utilizat o masc\u{a} pentru pentru cavitatea vezicii, tumoare \c{s}i pentru peretele vezicii urinare. Pentru a reprezenta aceast\u{a} masc\u{a}, trebuie mai \^{i}nt\^{a}i s\u{a} aplatizam imaginea \^{i}ntr-o matrice.
\^{I}n prima faz\u{a} de lucru a proiectului, m\u{a}\c{s}tile au fost create de m\^{a}n\u{a} din lipsa de date, mai apoi au fost generate pe baza setului de date primit de la un centru medical.

Tehnicile moderne de segmentare a imaginilor se bazeaz\u{a} pe abordarea de \^{i}nv\u{a}\c{t}are profund\u{a}, care utilizeaz\u{a} arhitecturi comune, cum ar fi CNN, FCNs (Fully Convolution Networks) \c{s}i Deep Encoders Decoders \href{https://www.kaggle.com/paulorzp/rle-functions-run-lenght-encode-decode}{Vezi Encode \c{s}i Decode}.
La acest proiect, arhitectura Res-U-Net 
\href{https://www.kaggle.com/ekhtiar/resunet-a-baseline-on-tensorflow/notebook}
{Vezi ResUNet-a Baseline pe TensorFlow}
este folosit\u{a} pentru a \^{i}ndeplini aceast\a{a} sarcin\u{a}.

Pentru segmentarea ROI s-a folosit re\c{t}eaua neuronal\u{a} darknet 
\href{https://github.com/AlexeyAB/darknet}{Vezi Darknet}
pentru a crea modelul de localizare a vezicii, identificarea peretelui, respectiv a cavit\u{a}\c{t}ii vezicii sau a tumorii. 

\newpage
\^{I}n continuare sunt prezentate date par\c{t}iale de m\u{a}\c{s}ti create \^{i}n primul stadiu de cercetare realizate de m\^{a}n\u{a} din lipsa de date.

 \begin{figure}[h]
\graphicspath {  { ./images/ }  }
\caption{Masck Defect Class 1 prima faz\u{a}}
\centering
\includegraphics [scale=1] { mask_defect_class1_1 }
\label{mask_defect_class_1}
\end{figure}

 \begin{figure}[h]
\graphicspath {  { ./images/ }  }
\caption{Masck Defect Class 2 prima faz\u{a}}
\centering
\includegraphics [scale=1] { mask_defect_class2_1 }
\label{mask_defect_class_2}
\end{figure}

\newpage
 \begin{figure}[h]
\graphicspath {  { ./images/ }  }
\caption{Masck Defect Class 1 a doua faz\u{a}}
\centering
\includegraphics [scale=1] { mask_defect_class1_2 }
\label{mask_defect_class_1_2}
\end{figure}

 \begin{figure}[h]
\graphicspath {  { ./images/ }  }
\caption{Masck Defect Class 2 a doua faz\u{a}}
\centering
\includegraphics [scale=1] { mask_defect_class2_2 }
\label{mask_defect_class_2_2}
\end{figure}

\newpage
 \begin{figure}[h]
\graphicspath {  { ./images/ }  }
\caption{Masck Defect Class 1 a treia faz\u{a}}
\centering
\includegraphics [scale=1] { mask_defect_class1_3 }
\label{mask_defect_class_1_3}
\end{figure}

 \begin{figure}[h]
\graphicspath {  { ./images/ }  }
\caption{Masck Defect Class 2 a treia faz\u{a}}
\centering
\includegraphics [scale=1] { mask_defect_class2_3 }
\label{mask_defect_class_2_3}
\end{figure}

\newpage
 \begin{figure}[h]
\graphicspath {  { ./images/ }  }
\caption{Masck Defect Class 1 a patra faz\u{a}}
\centering
\includegraphics [scale=1] { mask_defect_class1_4 }
\label{mask_defect_class_1_4}
\end{figure}

 \begin{figure}[h]
\graphicspath {  { ./images/ }  }
\caption{Masck Defect Class 2 a patra faz\u{a}}
\centering
\includegraphics [scale=1] { mask_defect_class2_4 }
\label{mask_defect_class_2_4}
\end{figure}

\newpage 

De asemenea, date par\c{t}iale de m\u{a}\c{s}ti pe baza datelor primite de la un centru medical pentru 2 pacien\c{t}i.

 \begin{figure}[h]
\graphicspath {  { ./images/ }  }
\caption{Masck Defect \c{s}i Predicted Mask Class 1 a prima faz\u{a} (2 pacien\c{t}i)}
\centering
\includegraphics [scale=0.75] { mask_predicted_class1_1}
\label{mask_predicted_class_1_1}
\end{figure}

 \begin{figure}[h]
\graphicspath {  { ./images/ }  }
\caption{Masck Defect \c{s}i Predicted Mask Class 1 a doua faz\u{a} (2 pacien\c{t}i)}
\centering
\includegraphics [scale=0.75] { mask_predicted_class1_2}
\label{mask_predicted_class_1_2}
\end{figure}

 \begin{figure}[h]
\graphicspath {  { ./images/ }  }
\caption{Masck Defect \c{s}i Predicted Mask Class 1 a treia faz\u{a} (2 pacien\c{t}i)}
\centering
\includegraphics [scale=0.8] { mask_predicted_class1_3}
\label{mask_predicted_class_1_3}
\end{figure}

\newpage
Totodat\u{a}, date par\c{t}iale de m\u{a}\c{s}ti pe baza datelor primite de la un centru medical pentru 19 pacien\c{t}i.

 \begin{figure}[h]
\graphicspath {  { ./images/ }  }
\caption{Masck Defect Mask Class 1 a prima faz\u{a} (19 pacien\c{t}i)}
\centering
\includegraphics [scale=0.9] { mask_defect_new_class1_1 }
\label{mask_defect_new_class1_1}
\end{figure}

\newpage
 \begin{figure}[h]
\graphicspath {  { ./images/ }  }
\caption{Masck Defect Class 1 a doua faz\u{a} (19 pacien\c{t}i)}
\centering
\includegraphics [scale=0.9] { mask_defect_new_class1_2 }
\label{mask_defect_new_class_1_2}
\end{figure}

 \begin{figure}[h]
\graphicspath {  { ./images/ }  }
\caption{Masck Defect Mask Class 1 a treia faz\u{a} (19 pacien\c{t}i)}
\centering
\includegraphics [scale=0.9] { mask_defect_new_class1_3 }
\label{mask_defect_new_class_1_3}
\end{figure}

\newpage
 \begin{figure}[h]
\graphicspath {  { ./images/ }  }
\caption{Masck Defect Mask Class 1 a patra faz\u{a} (19 pacien\c{t}i)}
\centering
\includegraphics [scale=0.9] { mask_defect_new_class1_4 }
\label{mask_defect_new_class1_4}
\end{figure}

 \begin{figure}[h]
\graphicspath {  { ./images/ }  }
\caption{Masck Defect Class 1 a cincea faz\u{a} (19 pacien\c{t}i)}
\centering
\includegraphics [scale=0.9] { mask_defect_new_class1_5 }
\label{mask_defect_new_class_1_5}
\end{figure}

\newpage
 \begin{figure}[h]
\graphicspath {  { ./images/ }  }
\caption{Masck Defect Mask Class 1 a \c{s}asea faz\u{a} (19 pacien\c{t}i)}
\centering
\includegraphics [scale=0.9] { mask_defect_new_class1_6}
\label{mask_defect_new_class_1_6}
\end{figure}

 \begin{figure}[h]
\graphicspath {  { ./images/ }  }
\caption{Masck Defect Mask Class 1 a \c{s}aptea faz\u{a} (19 pacien\c{t}i)}
\centering
\includegraphics [scale=0.9] { mask_defect_new_class1_7}
\label{mask_defect_new_class1_7}
\end{figure}

\newpage
 \begin{figure}[h]
\graphicspath {  { ./images/ }  }
\caption{Masck Defect Class 1 a opta faz\u{a} (19 pacien\c{t}i)}
\centering
\includegraphics [scale=0.9] { mask_defect_new_class1_8}
\label{mask_defect_new_class_1_8}
\end{figure}

 \begin{figure}[h]
\graphicspath {  { ./images/ }  }
\caption{Masck Defect Mask Class 1 a noua faz\u{a} (19 pacien\c{t}i)}
\centering
\includegraphics [scale=0.9] { mask_defect_new_class1_9}
\label{mask_defect_new_class_1_9}
\end{figure}

\newpage
\section{U-net}

Structura de algoritm este de forma U-Net \href{https://lmb.informatik.uni-freiburg.de/people/ronneber/u-net/}{Vezi U-Net}
cu scurt\u{a}turi pe o structur\u{a} de CNN (Convolutional Neural Network) deoarece ofer\u{a} o fidelitate bun\u{a} pentru masca final\u{a} chiar dac\u{a} este un nivel sc\u{a}zut de noduri comparativ cu alte structuri la acela\c{s}i nivel de training.

\begin{figure}[h]
\graphicspath {  { ./images/ }  }
\caption{Convolutional Networks pentru segmentarea imaginilor biomedicale}
\centering
\includegraphics [scale=0.2] { diagram }
\label{cnn}
\end{figure}

Opera\c{t}ia de convolu\c{t}ie se bazeaz\u{a} pe luarea unei sec\c{t}iuni de 3x3 din tensor centrat\u{a} pe un anumit nod \c{s}i aplicarea unei func\c{t}ii pe zona respectiv\u{a}, rezultatul urm\^{a}nd s\u{a} fie valoarea nodului \^{i}n stratul urm\u{a}tor. 

Pooling-ul este o opera\c{t}ie a CNN care const\u{a} \^{i}n luarea unei zone de 2x2 \c{s}i alegerea valorii maxime din zona respectiv\u{a} pentru a forma noul layer. Astfel se mic\c{s}oreaz\u{a} m\u{a}rimea stratului pe 2 dimensiuni cu un factor de 50\%.

Operatia de Shortcut sau de ad\u{a}ugare ofer\u{a} o direc\c{t}ie mai scurt\u{a} pentru informa\c{t}ia de intrare. Aceasta se realizeaz\u{a} prin adaugarea celor dou\u{a} matrici ce reprezint\u{a} valorile nodurilor. Scopul opera\c{t}iei este de a eficientiza antrenarea prin p\u{a}strarea fidelit\u{a}\c{t}i datelor mai ad\^{a}nc \^{i}n network.

Structura general\u{a} este format\u{a} dintr-un encoder care transform\u{a} imaginea dintr-un spa\c{t}iu bidimensional mare pe 2 dimensiuni (imagine 100x100) \^{i}ntr-un spa\c{t}iu 3d mare pe o dimensiune (4x4x64) abstractiz\^{a}nd informa\c{t}ia imaginii prin straturi convolu\c{t}ionale \c{s}i un decoder care formeaz\u{a} opera\c{t}ia invers\u{a}. Aceste doua elemente sunt cuplate transversal pe straturile de aceea\c{s}i m\u{a}rime pentru a ob\c{t}ine o fidelitate mai clar\u{a} a ma\c{t}tii prin concatenarea tensorilor din partea de encoder cu tensori care au trecut prin opera\c{t}ia de upscale.

Mai concret, CNN-ul are 4 straturi de encoding, \c{s}i anume un strat de bridge \c{s}i patru straturi de decoder. Fiecare strat de encoding este format dint 2 convolu\c{t}ii, o ad\u{a}ugare \c{s}i o convolu\c{t}ie final\u{a} urmat\u{a} de o opera\c{t}ie de activare non liniar\u{a} ReLU \c{s}i o normalizare. \6{I}ntre straturile de Encoder este o opera\c{t}ie de Pooling, iar \^{i}ntre straturile de Decoder este o opera\c{t}ie de Upscale. Imediat dup\u{a} opera\c{t}ia de upscale se realizeaz\u{a} o concatenare cu rezultatele stratului echivalent din encoder. Scopul concaten\u{a}rii este destul de similar cu cel al shortcut-ului, mai exact de a reduce detaliul imagini originale \^{i}n imagina degradat\u{a} generat\u{a} de encoder.

\section{YOLO}
YOLO este un algoritm care folose\c{s}te re\c{t}ele neuronale pentru a oferi detectarea obiectelor \^{i}n timp real. YOLO este o abreviere pentru termenul "You Only Look Once".

\begin{table}[htbp]
 	\caption{Parametrii modelului standard de antrenament Yolo}
	\label{tabel_yolo}
		\begin{center}
			\begin{tabular}{|c|c|}
            \hline
				\textbf{Parameter}& \textbf{Value} \\
				\hline\hline
 				Learning Rate& 0.001 \\
 				\hline
 				Score Threshold& 0.5 \\
 				\hline
 				IOU Threshold& 0.5 \\
 				\hline
 				Input Image Size& 416x416 \\
 				\hline
 				Number of Classes& 1\\
		\hline
			\end{tabular}
		\end{center}
\end{table}

\begin{figure}[h]
\graphicspath {  { ./images/ }  }
\caption{Algoritmul YOLO pentru detectarea obiectelor}
\centering
\includegraphics [scale=0.68] { yolo }
\label{yolo}
\end{figure}

\algsetup{indent=1, linenosize=\footnotesize}

\begin{algorithm}
	\caption{Detectarea predic\c{t}iile obiectelor}
	\label{NGalg}
		\begin{algorithmic}

			\STATE \textbf{BEGIN}
  		\STATE @ Read and Transform Image
  		\STATE @ Divide the image in a SxS grid
  		\STATE @ Go through the \textbf{darknet53} extractor to obtain features
  	    \STATE @ Send the features to the detection convolutional layers at multiple scales
  		\STATE @ Detect bounding box
  		\STATE @ Calculate various scores:
  		\STATE boxConfidenceScore = Pr(object) * IoU
  		\STATE conditionalClassProbability = Pr(class|object)
  		\STATE classConfidenceScore = Pr(class) * IoU
  		\STATE @ DetectBoxes(threshold, IoU)
  		\STATE @ Apply NonMaxSupression
  		\IF {detection is over IoU and treshold}
  		    \STATE @ Return(detection);
  		\ENDIF
  		\STATE \textbf{END}
\end{algorithmic}
\end{algorithm}

\newpage
\^{I}n compara\c{t}ie cu alte re\c{t}ele de clasificare a propunerilor de regiune (RCNN rapid) care efectueaz\u{a} detectarea pe diferite propuneri de regiune ajung\^{a}nd s\u{a} efectueze predic\c{t}ii de mai multe ori pentru diferite regiuni dintr-o imagine, arhitectura Yolo seam\u{a}n\u{a} mai mult cu FCNN (re\c{t}ea neuronal\u{a} complet convolu\c{t}ional\u{a}). YOLO transmite imaginea (nxn) prin FCNN, iar ie\c{s}irea este o predic\c{t}ie (mxm). Aceast\u{a} arhitectur\u{a} \^{i}mparte imaginea de intrare \^{i}n grila mxm iar pentru fiecare genera\c{t}ie de gril\u{a} sunt 2 casete de delimitare \c{s}i probabilit\u{a}\c{t}i de clas\u{a} pentru casetele respective. 

\begin{figure}[h]
\graphicspath {  { ./images/ }  }
\caption{Valoarea loss-ului pentru itera\c{t}iile de YOLO de la 800 la 900}
\centering
\includegraphics [scale=0.5] { yolo_darket }
\label{loss_yolo}
\end{figure}

Yolov4 este o \^{i}mbun\u{a}t\u{a}\c{t}ire a algoritmului Yolov3, av\^{a}nd o \^{i}mbun\u{a}t\u{a}\c{t}ire a preciziei de medii (mAP) cu p\^{a}n\u{a} la 10 la sut\u{a} \c{s}i a num\u{a}rului de cadre pe secund\u{a} cu 12\%. 

Compararea YOLO cu al\c{t}i algoritmi.

SOTA(State of the art): vezi Figure \ref{sota}


\section{Tensorflow}
Tensorflow este o bibliotec\u{a} de inteligen\c{t}\u{a} artificial\u{a} open source, care utilizeaz\u{a} grafice ale fluxului de date pentru a construi modele. Acesta permite dezvoltatorilor s\u{a} creeze re\c{t}ele neuronale la scar\u{a} larg\u{a} cu multe straturi.

\begin{figure}[h]
\graphicspath {  { ./images/ }  }
\caption{Clasificare pe straturi a imaginii cu Tensorflow}
\centering
\includegraphics [scale=0.7] { image_layers }
\label{image_layers}
\end{figure}


TensorFlow este folosit \^{i}n principal pentru: 
\begin{itemize}
	\item Clasificare
	\item Percep\c{t}ie
	\item \^{I}n\c{t}elegere
	\item Descoperire
	\item Creare
\end{itemize}

\chapter{Aplica\c{t}ie (validare numeric\u{a})}
\label{chapter:application}

\section{Metodologie}
\label{section:methodology}

\begin{itemize}
	\item Care sunt criteriile utilizate pentru a evalua metoda?

Am folosit o structura de U-net bazat\u{a} pe un encoder, Stem  \c{s}i Decoder.  Fiecare din cele 4 nivele de encoding, respectiv decoding este format din 2 straturi convolu\c{t}ionale (Conv2D) \c{s}i un shortcut intern care se adaug\u{a} la rezultatul acestora. 

Downscaling-ul se realizeaz\u{a} prin schimbarea stride-ului \^{i}n cadrul ultimei convolu\c{t}ii de la 1 la 2, iar stem-ul este format din aceea\c{s}i structur\u{a} ca \c{s}i Decoder-ul, cu excep\c{t}ia concaten\u{a}ri datelor reziduale de la nivelul corespunz\u{a}tor din Encoder. Structura nivelelor acestora este de 2 convolu\c{t}ii, un shortcut intern care se adaug\u{a} la rezultatul acestora, respectiv un layer de Upsampling.

Pentru a men\c{t}ine integritatea informa\c{t}iei, fiecare layer trece printr-un strat de normalizare yar pentru a cre\c{s}te fidelitatea imaginii \^{i}n fiecare nivel de encoder, respectiv fiecare nivel de decoder, astfel se realizeaz\u{a} o activare non liniar\u{a} RELU.
    
    %\item What specific hypotheses does your experiment test? Describe the experimental methodology that you used.
    
    %\item What are the dependent and independent variables?
    
    %\item What is the training/test data that was used, and why is it realistic or interesting?  Exactly what performance data did you collect and how are you presenting and analyzing it? Comparisons to competing methods that address the same problem are particularly useful.

\end{itemize}

\section{Date}
\label{section:data}
Pe parcusul proiectului, datele de antrenament s-au \^{i}mbun\u{a}t\u{a}\c{t}it, optimiz\^{a}nd astfel predic\c{t}ia \c{s}i acurate\c{t}ea algoritmului.

Pentru \^{i}nceput am utilizat buc\u{a}\c{t}i de date de la diferi\c{t}i pacien\c{t}i la care am creat aroximativ 50 de m\u{a}\c{s}ti de m\^{a}n\u{a}.

Mai apoi, ne-am axat pe date concrete primite de la un centru medical, mai exact date de antrenament de la 19 pacien\c{t}i \c{s}i 446 de m\u{a}\c{s}ti.

\newpage
\section{Rezultate}
\label{section:results}

Pentru \^{i}nceput, primele rezultate din primul stadiu de lucru pentru loss \c{s}i accuracy.

Pentru loss avem:
\begin{figure}[h]
\graphicspath {  { ./images/ }  }
\caption{Rezultate algoritm de segmentare pentru loss cu 250 de epoci}
\centering
\includegraphics [scale=0.4] { result1 }
\label{loss_250}
\end{figure}

\begin{figure}[h]
\graphicspath {  { ./images/ }  }
\caption{Rezultate algoritm de segmentare pentru model loss cu 100 de epoci dup\u{a} aprox. 0.01}
\centering
\includegraphics [scale=0.7] { model loss}
\label{loss_100}
\end{figure}

\^{I}mbun\u{a}t\u{a}\c{t}ire loss
\begin{figure}[h]
\graphicspath {  { ./images/ }  }
\caption{\^{I}mbun\u{a}\c{t}ire algoritm de segmentare pentru loss}
\centering
\includegraphics [scale=1] { imbunatatire }
\label{imbunatatire_loss}
\end{figure}

\newpage
Pentru accuary avem:
\begin{figure}[h]
\graphicspath {  { ./images/ }  }
\caption{Rezultate algoritm de segmentare pentru accuracy cu 250 de epoci}
\centering
\includegraphics [scale=0.5] { result2 }
\label{accuracy_250}
\end{figure}

\begin{figure}[h]
\graphicspath {  { ./images/ }  }
\caption{Rezultate algoritm de segmentare pentru model accuracy cu 100 de epoci dup\u{a} aprox. 0.01}
\centering
\includegraphics [scale=0.8] { model accuary }
\label{accuracy_100}
\end{figure}

\newpage
\^{I}n continuare, rezultatele pentru loss \c{s}i accuracy din faza a doua a cercet\u{a}rii pe baza setului de date de la centrul medical.

Pentru 2 pacien\c{t}i avem urm\u{a}toarele rezulate:

\begin{figure}[h]
\graphicspath {  { ./images/ }  }
\caption{Rezultate algoritm de segmentare pentru model accuracy \c{s}i model loss cu 50 de epoci pentru 2 pacien\c{t}i}
\centering
\includegraphics [scale=0.8] { real_data_2 }
\label{los_accuracy_50}
\end{figure}

Pentru 19 pacien\c{t}i avem urm\u{a}toarele rezulate:

\begin{figure}[h]
\graphicspath {  { ./images/ }  }
\caption{Rezultate algoritm de segmentare pentru model accuracy \c{s}i model loss cu 100 de epoci pentru 19 pacien\c{t}i}
\centering
\includegraphics [scale=0.9] { real_data_3 }
\label{los_accuracy_100}
\end{figure}

\newpage
Mai jos sunt prezentate dou\u{a} modele de antrenament pe baza setului de date de la centrul medical. Cele dou\u{a} modele au fost testate pentru 100 de epoci, cu men\c{t}iunea c\u{a} \^{i}n tabel nu au fost trecute \c{s}i epocile care aveau aceea\c{s}i valoare de loss.
\\
\\
Modelul 1
\\
Num\u{a}rul de date de antrenament: 19 pacien\c{t}i
\\
Num\u{a}rul de teste: 100
\\
Num\u{a}rul de m\u{a}\c{t}i: 446 (118 tumoare, 328 perete)
\\
Rezultate validare: 35\% date de validare (40 tumoare, 114 perete)
\\
Rezultate antrenament: 65\% date de antrenament(78 tumoare, 214 perete)

\begin{table}[htbp]
 	\caption{Primul model de antrenament}
	\label{tabe_model_1}
		\begin{center}
        \begin{tabular}{|c|c|}
        	\hline
        	Epochs & Loss \\
        	\hline
        	1 & 0.92 \\
        	\hline
        	2 & 0.63 \\
        	\hline
        	3 & 0.44 \\
        	\hline
        	4 & 0.40 \\
        	\hline
        	5 & 0.38 \\
        	\hline
        	6 & 0.35 \\
        	\hline
        	7 & 0.34 \\
        	\hline
        	8 & 0.32 \\
        	\hline
        	9 & 0.31 \\
        	\hline
        	11 & 0.29 \\
        	\hline
        	13 & 0.28 \\
        	\hline
        	14 & 0.27 \\
        	\hline
        	16 & 0.26 \\
        	\hline
        	20 & 0.25 \\
        	\hline
        	22 & 0.24 \\
        	\hline
        	25 & 0.23 \\
        	\hline
        	28 & 0.22 \\
        	\hline
        	33 & 0.21 \\
        	\hline
        	37 & 0.20 \\
        	\hline
        	45 & 0.19 \\
        	\hline
        	55 & 0.18 \\
        	\hline
        	61 & 0.17 \\
        	\hline
        	67 & 0.16 \\
        	\hline
        	100 & 0.15 \\
        	\hline
        \end{tabular}
    \end{center}
\end{table}

\newpage
Modelul 2
\\
Num\u{a}rul de date de antrenament: 19 pacien\c{t}i
\\
Num\u{a}rul de teste: 100
\\
Num\u{a}rul de m\u{a}\c{t}i: 446 (118 tumoare, 328 perete)
\\
Rezultate validare: 50\% date de validare (59 tumoare, 164 perete)
\\
Rezultate antrenament: 50\% date de antrenament (59 tumoare, 164 perete)
\\
\begin{table}[htbp]
 	\caption{Al doilea model de antrenament}
	\label{tabel_model_2}
		\begin{center}
        \begin{tabular}{|c|c|}
        	\hline
        	Epochs & Loss \\
        	\hline
        	1 & 0.91 \\
        	\hline
        	2 & 0.69 \\
        	\hline
        	3 & 0.48 \\
        	\hline
        	4 & 0.44 \\
        	\hline
        	5 & 0.39 \\
        	\hline
        	6 & 0.36 \\
        	\hline
        	7 & 0.34 \\
        	\hline
        	8 & 0.33 \\
        	\hline
        	9 & 0.32 \\
        	\hline
        	10 & 0.31 \\
        	\hline
        	11 & 0.30 \\
        	\hline
        	12 & 0.29 \\
        	\hline
        	14 & 0.27 \\
        	\hline
        	15 & 0.26 \\
        	\hline
        	17 & 0.25 \\
        	\hline
        	21 & 0.24 \\
        	\hline
        	25 & 0.23 \\
        	\hline
        	26 & 0.22 \\
        	\hline
        	29 & 0.21 \\
        	\hline
        	35 & 0.20 \\
        	\hline
        	43 & 0.19 \\
        	\hline
        	46 & 0.19 \\
        	\hline
        	58 & 0.17 \\
        	\hline
        	73 & 0.16 \\
        	\hline
        	76 & 0.15 \\
        	\hline
        	100 & 0.14 \\
        	\hline
        \end{tabular}
    \end{center}
\end{table}

\newpage
\begin{table}[htbp]
 	\caption{Parametrii modelului de antrenament}
	\label{tabel_parameters}
		\begin{center}
			\begin{tabular}{|c|c|}
			    \hline
				\textbf{Parameter}& \textbf{Value}\\
				\hline\hline
 				Loos: focal\_tversky\_loss & gamma = 0.75 \\
 				\hline
 				Matrics: tversky & alpha = 0.7, smooth = 1e-6 \\
 				\hline
 				Optimizer: tf.keras.optimizers.Adam & lr = 0.05, epsilon = 0.2 \\
 				\hline
			\end{tabular}
		\end{center}
\end{table}

%\newpage
%\section{Discussion}
%\label{section:discussion}

%\begin{itemize}
%	\item Is your hypothesis supported? 
%	\item What conclusions do the results support about the strengths and weaknesses of your method compared to other methods? 
%	\item How can the results be explained in terms of the underlying properties of the algorithm and/or the data. 
%\end{itemize}



\chapter{Concluzii \c{s}i lucr\u{a}ri viitoare}
\label{chapter:concl}

Lucrarea noastr\u{a} a \^{i}ncercat s\u{a} ofere un punct de vedere clar \c{s}i u\c{s}or din perspectiva detect\u{a}rii tumorilor maligne a vezicii urinare pentru a facilita procesul de \^{i}nv\u{a}\c{t}are \c{s}i a cre\c{s}te productivitatea acestuia pentru studen\c{t}ii de la medicin\u{a} \c{s}i nu numai.


Puterea rezultatelor noastre const\u{a} \^{i}n utilizarea algoritmului YOLO, care este un detector puternic recunoscut pentru obiecte. Am folosit ultima sa versiune pentru a avea cele mai recente \^{i}mbun\u{a}t\u{a}\c{t}iri atunci c\^{a}nd vorbim despre
detectarea posibilelor malforma\c{t}ii ale vezicii urinare \c{s}i a peretelui. 

\^{I}n final, am ob\c{t}inut o precizie \c{s}i o acurate\c{t}e mare de 0.788 datorit\u{a} utiliz\u{a}rii de scurt\u{a}turi \^{i}n re\c{t}ea \c{s}i un timp de r\u{a}spuns mic ca urmare a folosirii unui algoritm eficient de ROI.

\begin{itemize}
	\item Punctele tari:
	
- acurate\c{t}ea detecr\u{a}rii este mare datorit\u{a} utiliz\u{a}rii de scurt\u{a}turi \^{i}n re\c{t}ea

- timpul de r\u{a}spuns este mic datorit\u{a} utiliz\u{a}rii unui algoritm eficient de ROI

- interac\c{t}iunea cu aplica\c{t}ia este u\c{s}oar\u{a} datorit\u{a} folosirii unei platforme compatibil\u{a} cu telefoane mobile

- designeul este foarte accesibil \c{s}i u\c{s}or de utilizat

	\item  Punctele slabe:

- lipsa datelor

- necesitatea unei conexiuni la internet

	\item Oportunit\u{a}\c{t}i:
	
- cre\c{s}terea datelor de antrenament poate conduce la cre\c{s}terea predic\c{t}iei	

- \^{i}mbun\u{a}t\u{a}\c{t}irea calit\u{a}\c{t}ii procesului de \^{i}nv\u{a}\c{t}are

- cre\c{s}terea productivit\u{a}\c{t}ii de \^{i}nv\u{a}\c{t}are

- oricine poate utiliza aplica\c{t}ia

    \item Amenin\c{t}\u{a}ri:
    
- existen\c{t}a altor aplica\c{t}ii de acela\c{s}i gen

\end{itemize}

Pentru viitor ne propunem s\u{a} cre\c{s}tem num\u{a}rul de date de antrenament pentru a cre\c{s}te acurate\c{t}ea algorimului \c{s}i predic\c{t}ia aplica\c{t}iei. Totodat\u{a}, dorim s\u{a} analiz\u{a}m \c{s}i cazurile de pietre urinare \c{s}i cistita emfizematoas\u{a}.
%Try to emphasise the strengths and the weaknesses of your approach.
%What are the major shortcomings of your current method? For each shortcoming, propose additions or enhancements that would help overcome it. 

%Briefly summarize the important results and conclusions presented in the paper. 

%\begin{itemize}
%	\item What are the most important points illustrated by your work? 
%	\item How will your results improve future research and applications in the area? 
%\end{itemize}


\begin{thebibliography}{BibAll}
\bibliographystyle{plain}
\bibitem{}Sungmin Woo, Valeria Panebianco, Yoshifumi Narumi, Francesco Del Giudice, Valdair F. Muglia, Mitsuru Takeuchi, Soleen Ghafoor, Bernard H. Bochner, Alvin C. Goh, Hedvig Hricak, James W.F. Catto andHebert Alberto Vargas, Diagnostic Performance of Vesical Imaging Reporting and Data System for the Prediction of Muscle-invasive Bladder Cancer: A Systematic Review and Meta-analysis, 2020
\bibitem{}Valeria Panebianco, Yoshifumi Narumi, Ersan Altun,c Bernard H. Bochner,Jason A. Efstathiou, Shaista Hafeez, Robert Huddart, Steve Kennish, Seth Lerner, Rodolfo Montironi, Valdair F. Muglia, Georg Salomon, Stephen Thomas, Hebert Alberto Vargas, J. Alfred Witjes, Mitsuru Takeuchi, Jelle Barentsz and James W.F. Cattor, Multiparametric Magnetic Resonance Imaging for Bladder Cancer: Development of VI-RADS, 2018
\bibitem{}Nader Aldoj, Federico Biavati, Florian Michallek, Sebastian Stober and Marc Dewey, Automatic prostate and prostate zones segmentation of magnetic resonance images using DenseNet-like U-net, 2020
\bibitem{}Samuel J Galgano, Kristin K Porter, Constantine Burgan and Soroush Rais-Bahrami, The Role of Imaging in Bladder Cancer Diagnosis and Staging, 2020
\bibitem{}See Hyung Kim, Validation of vesical imaging reporting and data system for assessing muscle invasion in bladder tumor, 2020
\bibitem{}Ravi K. Kaza , Joel F. Platt, Richard H. Cohan, Elaine M. Caoili, Mahmoud M. Al-Hawary and Ashish Wasnik, Dual-Energy CT with Single- and Dual-Source Scanners: Current Applications in Evaluating the Genitourinary Tract, 2012
\bibitem{}Anushri Parakh, Hyunkwang Lee, Jeong Hyun Lee, Brian H. Eisner, Dushyant V. Sahani and Synho Do, Urinary Stone Detection on CT Images Using Deep Convolutional Neural Networks: Evaluation of Model Performance and Generalization, 2019
\bibitem{}Ekhtiar Syed, ResUNet-a Baseline on TensorFlow, 2019
\end{thebibliography}

\end{document}