sabeCantar(megurineLuka, cancion(nightFever,4)).
sabeCantar(megurineLuka, cancion(foreverYoung,5)).
sabeCantar(hatsuneMiku, cancion(tellYourWorld,4)).
sabeCantar(gumi, cancion(foreverYoung,4)).
sabeCantar(gumi, cancion(tellYourWorld,5)).
sabeCantar(seeU, cancion(novemberRain,6)).
sabeCantar(seeU, cancion(nightFever,5)).

esNovedoso(Vocaloid) :-
    sabeDosCanciones(Vocaloid),
    sabeAlgunaMayorA(Vocaloid, 5).

esNovedoso(Vocaloid) :-
    sabeAlgunaMayorA(Vocaloid, 10).

sabeDosCanciones(Vocaloid) :-
    sabeCantar(Vocaloid,Cancion1),
    sabeCantar(Vocaloid,Cancion2),
    titulosDiferentes(Cancion1,Cancion2).

titulosDiferentes(Cancion1,Cancion2) :-
    titulo(Cancion1,Titulo1),
    titulo(Cancion2,Titulo2),
    Titulo1 \= Titulo2.

titulo(cancion(Titulo1,_),Titulo1).

sabeAlgunaMayorA(Vocaloid, Duracion) :-
    sabeCantar(Vocaloid,Cancion),
    duracion(Cancion, Duracion1),
    Duracion1 > Duracion.

duracion(cancion(_,Duracion),Duracion).

esAcelerado(Vocaloid) :-
    sabeCantar(Vocaloid,_),
    todasCancionesMasCortasQue(Vocaloid,4).

duracionMenorA(Cancion,Duracion) :-
    duracion(Cancion,Duracion1),
    Duracion1 =< Duracion.

concierto(mikuExpo, eeuu, 2000, gigante(6)).
concierto(magicalMirai, japon, 3000, gigante(10)).
concierto(vocalektVisions, eeuu, 1000, mediano(novemberRain)).
concierto(mikuFest, argentina, 100, pequenio(4)).

condicion(Concierto,Condicion) :-
    concierto(Concierto,_,_,Condicion).

puedeParticipar(hatsuneMiku,Concierto) :-
    concierto(Concierto,_,_,_).


puedeParticipar(Vocaloid,Concierto) :-
    condicion(Concierto,Condicion),
    cumpleCondicion(Vocaloid,Condicion).
    %condicion(Concierto,Condicion),
    

cumpleCondicion(Vocaloid, gigante(Duracion)) :-
    novedosoOAcelerado(Vocaloid),
    todasCancionesMasCortasQue(Vocaloid,Duracion).

cumpleCondicion(Vocaloid, mediano(Titulo)) :-
    sabeCantar(Vocaloid,Cancion),
    titulo(Cancion,Titulo).

cumpleCondicion(Vocaloid, pequenio(Duracion)) :-
    sabeAlgunaMayorA(Vocaloid, Duracion).

todasCancionesMasCortasQue(Vocaloid,Duracion) :-    
    sabeCantar(Vocaloid,_),
    forall(sabeCantar(Vocaloid,Cancion), duracionMenorA(Cancion, Duracion)).

novedosoOAcelerado(Vocaloid) :-
    esNovedoso(Vocaloid).

novedosoOAcelerado(Vocaloid) :-
    esAcelerado(Vocaloid).

%3

elMasFamoso(Vocaloid) :-
    sabeCantar(Vocaloid,_),
    calcularFama(Vocaloid,FamaTotal),
    forall(sabeCantar(Vocaloid2,_),tieneMenosFama(Vocaloid2,FamaTotal)).

tieneMenosFama(Vocaloid,Fama) :-
    calcularFama(Vocaloid,FamaTotal),
    FamaTotal =< Fama.

calcularFama(Vocaloid,FamaTotal) :-
    cantidadLetrasNombre(Vocaloid,Cantidad),
    mayorFamaConcierto(Vocaloid,Fama),
    multiplicar(Fama,Cantidad, FamaTotal).

famaConcierto(Concierto,Fama) :-
    concierto(Concierto,_,Fama,_).

daMenosFama(Concierto, Fama) :-
    famaConcierto(Concierto, FamaConcierto),
    FamaConcierto =< Fama.

cantidadLetrasNombre(Vocaloid,Cantidad) :-
    sabeCantar(Vocaloid,_),
    atom_length(Vocaloid,Cantidad).

multiplicar(X,Y,Z) :-
    Z is X*Y.

mayorFamaConcierto(Vocaloid,Fama) :-
    sabeCantar(Vocaloid,_),
    puedeParticipar(Vocaloid,Concierto1),
    famaConcierto(Concierto1,Fama),
    forall(puedeParticipar(Vocaloid,Concierto), daMenosFama(Concierto,Fama)).

%4
conoceA(megurineLuka,hatsuneMiku).
conoceA(megurineLuka,gumi).
conoceA(gumi,seeU).
conoceA(seeU,kaito).

esConocido(Vocaloid,OtroVocaloid) :-
    conoceA(Vocaloid,OtroVocaloid).

esConocido(Vocaloid, OtroVocaloid) :-
    conoceA(Vocaloid,OtroVocaloid2),
    esConocido(OtroVocaloid2,OtroVocaloid).

esElUnicoQueParticipa(Vocaloid,Concierto) :-
    sabeCantar(Vocaloid,_),
    puedeParticipar(Vocaloid,Concierto),
    forall(esConocido(Vocaloid,OtroVocaloid), not(puedeParticipar(OtroVocaloid,Concierto))).
