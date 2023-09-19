\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{thud}[2020/01/21]

\RequirePackage{kvoptions}
\SetupKeyvalOptions{prefix={\@currname @opt@}}

\def\thud@tmpcmd{\relax}
\DeclareStringOption[\relax]{beamer}[]
\DeclareStringOption{target}
\DeclareStringOption{aauheader}
\DeclareStringOption{style}


\ProcessKeyvalOptions{\@currname}

\newif\ifthud@beamer
\ifx\thud@opt@beamer\thud@tmpcmd\else\thud@beamertrue\fi

\def\thud@save#1{\expandafter\let\csname thud@save@#1\expandafter\endcsname\csname#1\endcsname}
\def\thud@restore#1{\expandafter\let\csname#1\expandafter\endcsname\csname thud@save@#1\endcsname}
\def\@ifplus#1{\@ifnextchar+{\@firstoftwo{#1}}}

\def\thud@tmpcmd{bach}
\ifx\thud@opt@target\thud@tmpcmd
    \chardef\thud@target\z@\relax
\else
    \def\thud@tmpcmd{mst}
    \ifx\thud@opt@target\thud@tmpcmd
        \chardef\thud@target\@ne\relax
    \else
        \def\thud@tmpcmd{phd}
        \ifx\thud@opt@target\thud@tmpcmd
            \chardef\thud@target\tw@\relax
        \else
            \ClassError{\@currname}{Invalid value for the \protect"target\protect" option}
                {Specify one of \protect"bach\protect", \protect"mst\protect" or \protect"phd\protect"}
        \fi
    \fi
\fi
\newif\ifthud@phd
\ifnum\thud@target=\tw@\relax\thud@phdtrue\fi

\ifthud@beamer
\LoadClass[\thud@opt@beamer]{beamer}
\else
\LoadClass[onecolumn,twoside,\ifthud@phd 10\else 11\fi pt]{book}
\fi

\RequirePackage{helvet}

\def\thud@nonegiven#1{\ClassError{thud}{No \expandafter\string\csname#1\endcsname\space given}{Provide an \expandafter\string\csname#1\endcsname.}}
\def\@author{\thud@nonegiven{author}}
\def\@date{\begingroup\expandafter\advance\expandafter\year\ifnum\month>3 -1 \else -2 \fi\the\year-\advance\year1 \the\year\endgroup}

\RequirePackage{graphicx}


% localizzazione
\RequirePackage[\thudbabelopt]{babel}
\ifthud@beamer\else
\RequirePackage{setspace}
\RequirePackage[\ifthud@phd c5paper\else a4paper\fi]{geometry}
\fi

\addto\captionsenglish{%
    \def\abstractname{Abstract}%
    \def\acknowledgementsname{Acknowledgements}%
    \def\authorcontactsname{Author's Contacts}%
    \def\candidatename{Candidate}%
    \def\chairname{Chair}%
    \def\conclusionsname{Conclusions}%
    \def\cosupervisorname{Co-Supervisor}%
    \def\cosupervisorsname{Co-Supervisors}%
    \def\cyclename{Cycle}%
    \def\datename{Academic Year}%
    \def\indexname{Index}%
    \def\institutecontactsname{Institute Contacts}%
    \def\introductionname{Introduction}%
    \def\prefacename{Preface}%
    \def\reviewername{Reviewer}%
    \def\reviewersname{Reviewers}%
    \def\shortdatename{A.Y.}%
    \def\summaryname{Summary}%
    \def\supervisorname{Supervisor}%
    \def\supervisorsname{Supervisors}%
    \def\thesisname{\ifcase\thud@target Bachelor\space\or Master\space\or Ph.D.~\fi Thesis in \\ \thud@course}%
    \def\tutorname{Tutor}%
    \def\tutorsname{Tutors}%
}
\addto\captionsitalian{%
    \def\abstractname{Sommario}%
    \def\acknowledgementsname{Ringraziamenti}%
    \def\authorcontactsname{Contatti dell'autore}%
    \def\candidatename{Candidato}%
    \def\chairname{Direttore}%
    \def\conclusionsname{Conclusioni}%
    \def\cosupervisorname{Correlatore}%
    \def\cosupervisorsname{Correlatori}%
    \def\cyclename{Ciclo}%
    \def\datename{Anno accademico}%
    \def\indexname{Indice analitico}%
    \def\institutecontactsname{Contatti dell'Istituto}%
    \def\introductionname{Introduzione}%
    \def\prefacename{Prefazione}%
    \def\reviewername{Controrelatore}%
    \def\reviewersname{Controrelatori}%
    \def\shortdatename{A.A.}%
    \def\summaryname{Riassunto}%
    \def\supervisorname{Relatore}%
    \def\supervisorsname{Relatori}%
    \def\thesisname{Tesi di \ifcase\thud@target Laurea\or Laurea Magistrale\or Dottorato\fi \ in \\ \thud@course}%
    \def\tutorname{Tutor aziendale}%
    \def\tutorsname{Tutor aziendali}%
}


\gdef\thud@universityA{%
	\includegraphics[width=\textwidth]{banners\ifx\thud@opt@style\@empty\else/old\fi/banner_uniud_\languagename.pdf}\\
}
\gdef\thud@universityAaau{%
	\includegraphics[width=\textwidth]{banners\ifx\thud@opt@style\@empty\else/old\fi/banner_aau_\thud@opt@aauheader.pdf}\\
}
\gdef\thud@universityB{%
	Dipartimento di Scienze Matematiche, Informatiche e Fisiche\\%
	Universit\`a degli Studi di Udine\\
	Via delle Scienze, 206\\
	33100 Udine --- Italia\\
	+39 0432 558400\\
	\@ifundefined{url}\texttt\url{https://www.dmif.uniud.it/}
}
\gdef\thud@rights{%
		\textcopyright\ \the\year\ \@author\\ This work is shared under the Creative Commons 4.0 License Attribution-NonCommercial-ShareAlike.%
}

\def\@true{true}
\define@key{defentry}{long}[true]{%
    \def\thud@de@a{#1}%
    \ifx\@true\thud@de@a\let\thud@de@b\long\fi%
}
\define@key{defentry}{phd}[true]{%
    \def\thud@de@a{#1}%
    \ifx\@true\thud@de@a%
        \expandafter\let\csname ifthud@de@c\expandafter\endcsname\csname ifthud@phd\endcsname%
    \fi%
}
\define@key{defentry}{nonempty}[true]{%
    \def\thud@de@a{#1}%
    \ifx\@true\thud@de@a%
        \expandafter\let\csname ifthud@de@d\expandafter\endcsname\csname iftrue\endcsname%
    \fi%
}
\newcommand\thud@defentry[2][]{
	\let\thud@de@b\relax
	\let\ifthud@de@c\iftrue
	\let\ifthud@de@d\iffalse
    \setkeys{defentry}{#1}%
    \ifthud@de@d%% Either \iftrue or \iffalse
        \@namedef{thud@#2}{\thud@nonegiven{#2}}
    \else
        \expandafter\let\csname thud@#2\endcsname\@empty
    \fi
    \expandafter\thud@de@b\ifthud@de@c%% Either \iftrue or \ifthud@phd
        \@namedef{#2}##1{\expandafter\gdef\csname thud@#2\endcsname{##1}}
    \else
        \@namedef{#2}##1{\ClassWarning{\@currname}{\expandafter\string\csname#2\endcsname\space in non-PhD thesis}}
    \fi%
}
\thud@defentry{chair}
\thud@defentry[phd,long]{contacts}
\thud@defentry{cosupervisor}
\thud@defentry[nonempty]{course}
\thud@defentry[phd]{email}
\thud@defentry[phd]{homepage}
\thud@defentry[phd]{phdnumber}
\thud@defentry[phd]{reviewer}
%\thud@defentry{rights}
\thud@defentry{supervisor}
\thud@defentry[phd]{telephone}
\thud@defentry[phd]{cycle}
\thud@defentry{tutor}

\newsavebox\thud@tmpbox
\def\thud@showentry@#1#2{%
    \expandafter\ifx\csname thud@#2\endcsname\@empty\else%
        \def\thud@varname{\@nameuse{#2name}}%
        #1%% Either \iftrue or \iffalse
            \def\and{\\[\thud@se@and]\gdef\thud@varname{\@nameuse{#2sname}}}%
        \else%
            \let\and\@undefined
        \fi%
        \begin{lrbox}{\thud@tmpbox}\parbox[t]{\linewidth}{\@nameuse{thud@#2}}\end{lrbox}%
        \textsc{\thud@varname}\\[\thud@se@qual]%
        \usebox{\thud@tmpbox}\\[\thud@se@sep]\null%
    \fi%
}
\def\thud@showentry{\@ifstar{\expandafter\thud@showentry@\noexpand\iffalse}{\expandafter\thud@showentry@\noexpand\iftrue}}

\input{\ifthud@beamer beamer\else book\fi.thud.tex}
