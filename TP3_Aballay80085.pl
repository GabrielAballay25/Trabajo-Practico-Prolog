%HECHOS

%contratos/7
%contratos(NumeroContrato,Distribuidor,NombreDelProducto,Regalia,TipoDeProducto,DerechosDeDistribucion,ValorMinimoaPagar).

contratos('A234','Distribuidor A','Game Of Thrones','1Q2010',2,['DVD','BlueRay','TVP','Streaming'],25000).
contratos('A423','Distribuidor B','El Hombre Invisible','1M2020',1,['DVD','Streaming'],12500).
contratos('A120','Distribuidor A','Mentes Criminales','2M2515',2,['TVP','Streaming'],7500).
contratos('A540','Distribuidor B','Lluvia Negra','3M3520',1,['DVD','BlueRay'],10000).
contratos('A255','Distribuidor A','CSI Las Vegas','3M3520',2,['DVD','Streaming'],30000).
contratos('A566','Distribuidor B','Cazafantasmas','1Q2010',1,['Cine'],50000).
contratos('A897','Distribuidor A','Sherlock Holmes','1M2020',2,['DVD','BlueRay','TVP','Streaming'],75000).
contratos('A123','Distribuidor C','El Rey Leon','2Q3015',1,['DVD','BlueRay','TVP','Streaming'],65000).
contratos('A453','Distribuidor B','La Odisea de los Giles','1M2020',1,['Cine'],35000).
contratos('A690','Distribuidor C','El Robo del Siglo','1Q2010',1,['Cine'],45000).

%ingresosMensualesporContrato(NumerodeContrato,FechadeIngreso(Dia,Mes,A�o),MontoIngreso,MontoGastosdeDistribucion,Pais)
%IngresosMensualesporContrato/5
ingresosmensualesporcontrato('A123',fechadeingresodedistribucion(15,03,2020),45000,17500,1).
ingresosmensualesporcontrato('A123',fechadeingresodedistribucion(15,03,2020),45000,17500,1).
ingresosmensualesporcontrato('A123',fechadeingresodedistribucion(31,03,2020),20000,16500,1).
ingresosmensualesporcontrato('A123',fechadeingresodedistribucion(30,06,2020),50000,22500,3).
ingresosmensualesporcontrato('A453',fechadeingresodedistribucion(12,06,2020),30000,15000,2).
ingresosmensualesporcontrato('A453',fechadeingresodedistribucion(28,06,2020),25000,15000,2).
ingresosmensualesporcontrato('A690',fechadeingresodedistribucion(02,02,2020),12000,13500,3).
ingresosmensualesporcontrato('A690',fechadeingresodedistribucion(29,02,2020),95500,13500,3).
ingresosmensualesporcontrato('A690',fechadeingresodedistribucion(31,03,2020),80000,12500,1).
ingresosmensualesporcontrato('A897',fechadeingresodedistribucion(16,03,2020),40000,17000,2).
ingresosmensualesporcontrato('A897',fechadeingresodedistribucion(31,03,2020),15000,17000,2).
ingresosmensualesporcontrato('A897',fechadeingresodedistribucion(02,29,2020),50000,17000,1).
ingresosmensualesporcontrato('A566',fechadeingresodedistribucion(30,04,2020),50000,16500,3).
ingresosmensualesporcontrato('A255',fechadeingresodedistribucion(10,04,2020),72000,14500,3).
ingresosmensualesporcontrato('A255',fechadeingresodedistribucion(30,04,2020),90000,14500,3).
ingresosmensualesporcontrato('A540',fechadeingresodedistribucion(12,06,2020),30000,10800,2).
ingresosmensualesporcontrato('A540',fechadeingresodedistribucion(30,06,2020),30800,10700,2).
ingresosmensualesporcontrato('A540',fechadeingresodedistribucion(31,07,2020),30500,10600,1).
ingresosmensualesporcontrato('A120',fechadeingresodedistribucion(31,07,2020),25500,23400,1).
ingresosmensualesporcontrato('A234',fechadeingresodedistribucion(15,05,2020),75600,12800,1).
ingresosmensualesporcontrato('A234',fechadeingresodedistribucion(31,05,2020),75600,12800,1).

%Regalias(Regalia,Nombre,%aPagar,%Costo,Pais)
%Regalias/5
regalias('1Q2010','Regalia 1',0.20,0.10,1).
regalias('1M2020','Regalia 2',0.20,0.20,2).
regalias('2Q3015','Regalia 3',0.30,0.15,1).
regalias('2M2515','Regalia 4',0.25,0.15,2).
regalias('3M3520','Regalia 5',0.35,0.20,3).

%TIPODEPRODUCTOS/2
%tipodeproductos(Id,Nombre)
tipodeproductos(1,'Pelicula').
tipodeproductos(2,'Serie').

%Paises/2
%paises(Id,Nombre)
paises(1,'Argentina').
paises(2,'Brasil').
paises(3,'Uruguay').





%CALCULOS NECESARIOS

sumatoria_MontoIngreso(NumContr,Mes,Res):-findall(MontIng,
                       (ingresosmensualesporcontrato(NumContr,fechadeingresodedistribucion(_,Mes,_),MontIng,_,_)
                                         ),Lista),sumlist(Lista,Res),!.


sumatoria_GastoMensual(NumContr,Mes,Res):-findall(GastoDist,
                       (ingresosmensualesporcontrato(NumContr,fechadeingresodedistribucion(_,Mes,_),_,GastoDist,_)),Lista)
                                                 ,sumlist(Lista,Res),!.



porcentaje_de_los_costos(NumContr,Mes,Res3):-sumatoria_MontoIngreso(NumContr,Mes,Res1),
                                                  sumatoria_GastoMensual(NumContr,Mes,Res2),
                                                  contratos(NumContr,_,_,RegContr,_,_,_),regalias(RegContr,_,_,PorCosto,_),
                                              (Res3 is (Res1 - Res2)*PorCosto),!.


neto_mensual_obtenido(NumContr,Mes,Resultado):-sumatoria_MontoIngreso(NumContr,Mes,Res1),sumatoria_GastoMensual(NumContr,Mes,Res2),
                           porcentaje_de_los_costos(NumContr,Mes,Res3),Resultado is Res1 - Res2 - Res3,!.


monto_de_la_regalia(NumContr,Mes,Monto):-neto_mensual_obtenido(NumContr,Mes,Resultado),contratos(NumContr,_,_,RegContr,_,_,ValorAPagar),
                      regalias(RegContr,_,PorPagar,_,_),(Monto is  (Resultado-ValorAPagar)*PorPagar),!.



%REGLAS



%Regla2/0.
%Desarrollar una regla que informe si existe o no, un
%contrato que �s�lo� tenga como derecho de distribuci�n:
%�cine�.

regla2():-contratos(_,_,_,_,_,DerDist,_),
                  member('Cine',DerDist),
                  length(DerDist,Cant),Cant ==1,!,write("Si Existe un contrato con un 'Solo' Derecho de distribucion: 'Cine'").


%Regla3/3.
%Regla3(NumeroContrato,Mes,MontoDeLaRegalia)
%Generar una regla que a partir del n�mero de contrato
%determine el monto de la regal�a para a abonar en un
%mes determinado.


regla3(NumContr,Mes,Monto):-monto_de_la_regalia(NumContr,Mes,Monto).



%Regla4/3.
%Regla4(NumeroContrato,Mes,MontoTotalAPagar)
%Generar una regla que permita determinar el pago total
%mensual, pasando por argumento el n�mero de contrato
%y el mes que se desea abonar.


% Monto a abonar por el contrato, se determina teniendo en cuenta las
% siguientes situaciones:
%
% 1- Si Neto Mensual > Monto M�nimo: debe abonar por el contrato el
% monto m�nimo m�s el Monto de la regal�a.
%
% 2- Si Neto Mensual <= Monto M�nimo: solo debe abonar el Monto M�nimo.

regla4(NumContr,Mes,Total):-neto_mensual_obtenido(NumContr,Mes,Resultado),
                                         contratos(NumContr,_,_,_,_,_,ValorMin),
                                         regla3(NumContr,Mes,Monto),
                  ( (Resultado > ValorMin, Total is ValorMin + Monto ) ; (Resultado =< ValorMin,Total is ValorMin)),!.




%Regla5/2
%regla5(Valor,mes)



%Desarrollar una regla que dado un valor y un mes
%determinados, genere una lista ordenada con el n�mero
%de contrato cuyo monto total a pagar (monto m�nimo +
%monto de la regal�a) sea mayor al valor pasado como
%argumento, y que corresponda al mes especificado.



regla5a(Valor,Mes,Lista):-findall(NumContrato,
                       (contratos(NumContrato,_,_,_,_,_,MontMin),
                ingresosmensualesporcontrato(NumContrato,fechadeingresodedistribucion(_,Mes,_),_,_,_),
                        monto_de_la_regalia(NumContrato,Mes,Monto),Valor < (MontMin+Monto)),Lista).

regla5(Valor,Mes,ListaOrd):-regla5a(Valor,Mes,Lista),sort(Lista,ListaOrd).



%Regla6/2.
% Desarrollar una regla que informe el n�mero de contrato, nombre del
% producto, nombre de la regal�a, el nombre del tipo de producto, s�lo de
% los contratos que tengan como m�nimo 3 (tres) derechos de distribuci�n
% y cuyo monto m�nimo a pagar sea mayor a un valor pasado por argumento.

regla6(Valor,Contratos):-findall((NumContr,NomProd,NomReg,NomTipo),
                                 (contratos(NumContr,_,NomProd,NomReg,NumTip,DerDist,MonMin),
                                  tipodeproductos(NumTip,NomTipo),
                                 length(DerDist,Cant),Cant >=3 ,MonMin>Valor),Contratos).
































