% sabeCantar(Vocaloid, Cancion)
sabeCantar(megurineLuka, cancion(nightFever, 4)).
sabeCantar(megurineLuka, cancion(foreverYoung, 5)).
sabeCantar(hatsumeMiku, cancion(tellYourWorld, 4)).
sabeCantar(gumi, cancion(foreverYoung, 4)).
sabeCantar(gumi, cancion(tellYourWorld, 5)).
sabeCantar(seeU, cancion(novemberRain, 6)).
sabeCantar(seeU, cancion(tellYourWorld, 5)).
sabeCantar(fede, cancion(aloha, 3)).

% esNovedoso(Vocaloid)
esNovedoso(Vocaloid):-
    tiene2Canciones(Vocaloid),
    cancionesConDuracionMayorA(Vocaloid, 5).

esNovedoso(Vocaloid):-
    cancionesConDuracionMayorA(Vocaloid, 10).

% cancionesConDuracionMayorA(Vocaloid, Minutos)
cancionesConDuracionMayorA(Vocaloid, Minutos):-
    sabeCantar(Vocaloid, Cancion),
    duracionSuperiorA(Cancion, Minutos).

% cantidadCanciones(Vocaloid)
cantidadCanciones(Vocaloid):-
    aggregate(count, sabeCantar(Vocaloid, _), _).

% tiene2Canciones(Vocaloid)
tiene2Canciones(Vocaloid):-
    aggregate(count, cantidadCanciones(Vocaloid), Count),
    Count is 2.

% duracionSuperiorA(Cancion, Minutos)
duracionSuperiorA(cancion(_, Duracion), Minutos):-
    Duracion > Minutos.

% esAcelerado(Vocaloid)
esAcelerado(Vocaloid):-
    sabeCantar(Vocaloid, Cancion),
    forall(sabeCantar(Vocaloid, Cancion), duracionMenorQue(Cancion, 4)).

duracionMenorQue(cancion(_, Duracion), Minutos):-
    Duracion =< Minutos.

% concierto(Concierto).
concierto(mikuExpo, pais(estadosUnidos), 2000, gigante(6)).
concierto(magicalMirai, pais(japon), 3000, gigante(10)).
concierto(vocalektVisions, pais(estadosUnidos), 1000, mediano(novemberRain)).
concierto(mikuFest, pais(argentina), 100, pequenio(4)).

% puedeParticiparEn(Vocaloid, Concierto).
puedeParticiparEn(Vocaloid, Concierto):-
	concierto(Concierto, _ , _, Tipo),
	cumpleCondicionesConcierto(Vocaloid, Tipo).

puedeParticiparEn(hatsumeMiku, Concierto):-
	concierto(Concierto, _, _ , _).

% cumpleCondicionesConcierto(Vocaloid, gigante(Duracion))
cumpleCondicionesConcierto(Vocaloid, gigante(Duracion)):-
	esNovedosoOAcelerado(Vocaloid),
	forall(sabeCantar(Vocaloid, Cancion), duracionMenorQue(Cancion, Duracion)).
			
% cumpleCondicionesConcierto(Vocaloid, pequenio(DuracionMinima))			
cumpleCondicionesConcierto(Vocaloid, pequenio(DuracionMinima)):-
	forall(sabeCantar(Vocaloid, Cancion), duracionSuperiorA(Cancion, DuracionMinima)).

% cumpleCondicionesConcierto(Vocaloid, mediano(NombreCancion))
cumpleCondicionesConcierto(Vocaloid, mediano(NombreCancion)):-
	sabeCantar(Vocaloid, Cancion),
	conoceCancion(Cancion, NombreCancion).

% conoceCancion(cancion(NombreCancion,_), Nombre)
conoceCancion(cancion(NombreCancion,_), Nombre):-
	NombreCancion == Nombre.

% esNovedosoOAcelerado(Vocaloid)
esNovedosoOAcelerado(Vocaloid):-
	esNovedoso(Vocaloid).
esNovedosoOAcelerado(Vocaloid):-	
	esAcelerado(Vocaloid).

% masFamoso(Vocaloid).
masFamoso(Vocaloid):-
	sabeCantar(Vocaloid, _),
	famaTotal(Vocaloid, FamaTotal),
	forall(sabeCantar(Vocaloid2, _), tieneMenosFamaQue(Vocaloid2, FamaTotal)).	

% famaTotal(Vocaloid, Total)	
famaTotal(Vocaloid, Total):-
	findall(Fama, (puedeParticiparEn(Vocaloid, Concierto), concierto(Concierto, _, Fama, _)), Total2),
	sumarFama(Total2, Total).

% sumarFama(List, Sum)
sumarFama(List, Sum) :-
    sumarFama(List, 0, Sum).
sumarFama([], Accumulator, Accumulator).
sumarFama([Head|Tail], Accumulator, Result) :-
    NewAccumulator is Accumulator + Head,
    sumarFama(Tail, NewAccumulator, Result).

% tieneMenosFamaQue(Vocaloid, Fama)	
tieneMenosFamaQue(Vocaloid, Fama):-
	famaTotal(Vocaloid, FamaVocaloid),
	Fama >= FamaVocaloid.
	
% nombre(Vocaloid, N)
nombre(Vocaloid, N):-
	atom_length(Vocaloid, N).

% conoce(Vocaloid, OtroVocaloid).
conoce(megurineLuka, hatsumeMiku).
conoce(megurineLuka, gumi).
conoce(gumi, seeU).
conoce(seeU, kaito).

% esElUnicoQueParticipa(Vocaloid, Concierto)
esElUnicoQueParticipa(Vocaloid, Concierto):-
	puedeParticiparEn(Vocaloid, Concierto),
	forall(esConocido(Vocaloid, OtroVocaloid), not(puedeParticiparEn(OtroVocaloid, Concierto))).
	
% esConocido(Vocaloid, OtroVocaloid)	
esConocido(Vocaloid, OtroVocaloid):-
	conoce(Vocaloid, OtroVocaloid).
esConocido(Vocaloid, OtroVocaloid):-
	conoce(Vocaloid, TercerVocaloid),
	esConocido(TercerVocaloid, OtroVocaloid).
