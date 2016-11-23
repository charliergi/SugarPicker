%====INFORMATION====%
% LFSAB1402 Projet 2016
% Nomas : 08891500-NOMA2
% Noms : (Nom1,Prenom1)-(Nom2,Prenom2)
%====MODULELINK====%
declare
[Projet]={Module.link ["/home/gilles/SugarPicker/Projet2016.ozf"]}

%====CODE====%
local
   MaxTime = 10 % nombre de frame à l'animation
   MyFunction
   Map
   CheckMap
   GenerateMap
   Extensions = opt(withExtendedFormula:false
		    withIfThenElse:false
		    withComparison:false
		    withTimeWindow:false
		    withCheckMapEasy:false
		    withCheckMapComplete:false
		   )
   
in
   Map = map(ru:[rotate(angle:0.07 1:scale(rx:100.0 ry:100.0 1:translate(dx:250.0 dy:250.0 1:primitive(kind:road))))] pu:nil) %% TODO change the map here

   %%prend une Map en parametre et retourne une liste de fonction annonymes qui renvoie chacune un element a afficher.
   fun{MyFunction Map }
      local Search Change Create BuildFunc Separate in
	 %prend une map en paramètre et cree une liste de fonction annonyme suivant ru et pu dans map(ru:XX pu:XX)
	 
	 fun{Separate Map Acc1 Acc2}
	    case Map of nil then nil
	    [] map(ru:Ru pu:Pu) then
	       Acc1={Search Ru nil}
	       Acc2={Search Pu nil}
	       {Append Acc1 Acc2}
	    end
	 end
	 
	 %Parcourt la liste des RU de la map pour renvoyer une liste de fonction annonymes
	 fun{Search RU Acc}
	    case RU of nil then Acc
	    [] X|Y then {Search Y {BuildFunc X}|Acc}
	    end
	 end
      
	 %Construit une fonction a l'aide d'un record RU en paramètre
	 fun{BuildFunc R}
	    fun{$ Time}
	       {Change R 0.0 0.0 0.0 0.0 0.0}
	    end
	 end
	 % Stocke les donnees des RU pour creer un RUI
	 % /!\ Les valeurs Dx Dy sont considerees comme 0.0 si on utilise translate
	 % /!\ Les valeurs Rx Ry sont considerees comme 0.0 si on utilise scale
	 fun{Change Ru Rx Ry Dx Dy Theta}  
	       case Ru of nil then nil
	       [] primitive(kind:K) then {Create Ru Rx Ry Dx Dy Theta}  % Cree un realitem avec les valeurs des opérations parcourues
	       [] scale(rx:RX ry:RY 1:RU) then {Change RU RX RY Dx Dy Theta}      % Avance dans RU et save les valeurs du save
	       [] translate(dx:DX dy:DY 1:RU) then {Change RU Rx Ry DX DY Theta}  % Avance dans RU et save les valeurs du translate
	       [] rotate(angle:X 1:RU) then  {Change RU Rx Ry Dx Dy X}            % Avance dans RU et save les valeurs du rotate
	       end
	 end
	 %Cree un RUI a l'aide d'une primitive et des coefficient en X et Y.
	 %%TODO changer la definition des points
	 fun{Create Ru Rx Ry Dx Dy Theta}
	    
	    case Ru of nil then nil
	    [] primitive(kind:K) then
	       if K == road then
		  realitem(kind:road
			   p1:pt(x:((Rx*0.0)+Dx)*{Cos Theta}+((Ry*0.0)+Dy)*{Sin Theta} y:((Ry*0.0)+Dy)*{Cos Theta}-((Rx*0.0)+Dx)*{Sin Theta})
			   p2:pt(x:((Rx*1.0)+Dx)*{Cos Theta}+((Ry*0.0)+Dy)*{Sin Theta} y:((Ry*0.0)+Dy)*{Cos Theta}-((Rx*1.0)+Dx)*{Sin Theta})
			   )
	       elseif K == building then
		  realitem(kind:building
			   p1:pt(x:((Rx*0.0)+Dx)*{Cos Theta}+((Ry*0.0)+Dy)*{Sin Theta} y:((Ry*0.0)+Dy)*{Cos Theta}-((Rx*0.0)+Dx)*{Sin Theta})
			   p2:pt(x:((Rx*1.0)+Dx)*{Cos Theta}+((Ry*0.0)+Dy)*{Sin Theta} y:((Ry*0.0)+Dy)*{Cos Theta}-((Rx*1.0)+Dx)*{Sin Theta})
			   p3:pt(x:((Rx*1.0)+Dx)*{Cos Theta}+((Ry*1.0)+Dy)*{Sin Theta} y:((Ry*1.0)+Dy)*{Cos Theta}-((Rx*1.0)+Dx)*{Sin Theta})
			   p4:pt(x:((Rx*0.0)+Dx)*{Cos Theta}+((Ry*1.0)+Dy)*{Sin Theta} y:((Ry*1.0)+Dy)*{Cos Theta}-((Rx*0.0)+Dx)*{Sin Theta})
			   )
	       else
		  realitem(kind:water
			   p1:pt(x:((Rx*0.0)+Dx)*{Cos Theta}+((Ry*0.0)+Dy)*{Sin Theta} y:((Ry*0.0)+Dy)*{Cos Theta}-((Rx*0.0)+Dx)*{Sin Theta})
			   p2:pt(x:((Rx*1.0)+Dx)*{Cos Theta}+((Ry*0.0)+Dy)*{Sin Theta} y:((Ry*0.0)+Dy)*{Cos Theta}-((Rx*1.0)+Dx)*{Sin Theta})
			   p3:pt(x:((Rx*1.0)+Dx)*{Cos Theta}+((Ry*1.0)+Dy)*{Sin Theta} y:((Ry*1.0)+Dy)*{Cos Theta}-((Rx*1.0)+Dx)*{Sin Theta})
			   p4:pt(x:((Rx*0.0)+Dx)*{Cos Theta}+((Ry*1.0)+Dy)*{Sin Theta} y:((Ry*1.0)+Dy)*{Cos Theta}-((Rx*0.0)+Dx)*{Sin Theta})
			   )
	       end
	    end
	 end
	 {Separate Map _ _}
      end
   end
   
   
   

   fun{CheckMap Map}
      false %% TODO complete here the function for the checking of the maps
   end
   
   {Projet.run MyFunction Map MaxTime Extensions CheckMap}
end
