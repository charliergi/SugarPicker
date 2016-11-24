%====INFORMATION====%
% LFSAB1402 Projet 2016
% Nomas : 08891500-NOMA2
% Noms : (Nom1,Prenom1)-(Nom2,Prenom2)
%====MODULELINK====%
declare
{Property.put 'MyDir' '/home/gilles/SugarPicker/'} %% TODO ajoutez cette ligne si les images ne s'affichent pas et remplacez ./ par le chemin vers le dossier des images
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
   Map = map(ru:[rotate(angle:0.07 1:scale(rx:100.0 ry:100.0 1:translate(dx:250.0 dy:250.0 1:primitive(kind:road)))) rotate(angle:0.07 1:scale(rx:100.0 ry:100.0 1:translate(dx:200.0 dy:200.0 1:primitive(kind:road)))) ] pu:[translate(dx:time dy:time 1:primitive(kind:arena))]) %% TODO change the map here
   
   %%prend une Map en parametre et retourne une liste de fonction annonymes qui renvoie chacune un element a afficher.
   fun{MyFunction Map }
      local Search Change Create BuildFunc Separate SearchForPu ChangeForPu BuildFuncForPu in
	 %prend une map en paramètre et cree une liste de fonction annonyme suivant ru et pu dans map(ru:XX pu:XX)
	 
	 fun{Separate Map Acc1 Acc2}
	    case Map of nil then nil
	    [] map(ru:Ru pu:Pu) then
	       Acc1={Search Ru nil}
	       Acc2={SearchForPu Pu nil}
	       {Append Acc1 Acc2}
	    end
	 end
	 
	 %Parcourt la liste des RU de la map pour renvoyer une liste de fonction annonymes
	 fun{Search RU Acc}
	    case RU of nil then Acc
	    [] X|Y then {Search Y {BuildFunc X}|Acc}
	    end
	 end
	 
	 fun{SearchForPu PU Acc}
	    case PU of nil then Acc
	    [] H|T then {Search T {BuildFuncForPu H}|Acc}
	    end
	 end
	 
	 
	 %Construit une fonction a l'aide d'un record RU en paramètre
	 fun{BuildFunc R}
	    fun{$ Time}
	       {Change R 0.0 0.0 0.0 0.0 0.0}
	    end
	 end
	 
	 fun{BuildFuncForPu R}
	    fun{$ Time}
	       {ChangeForPu R Time false}
	    end
	 end
	 
	 % Stocke les donnees des RU pour creer un RUI
	 % /!\ Les valeurs Dx Dy sont considerees comme 0.0 si on utilise translate
	 % /!\ Les valeurs Rx Ry sont considerees comme 0.0 si on utilise scale
	 
	 fun{Change Ru Rx Ry Dx Dy Theta}  
	    case Ru of nil then nil
	    [] primitive(kind:K) then {Create Ru Rx Ry Dx Dy Theta Time}        % Cree un realitem avec les valeurs des opérations parcourues
	    [] scale(rx:RX ry:RY 1:RU) then {Change RU RX RY Dx Dy Theta}   % Avance dans RU et save les valeurs du save
	    [] translate(dx:DX dy:DY 1:RU) then {Change RU Rx Ry DX DY Theta} % Avance dans RU et save les valeurs du translate
	    [] rotate(angle:X 1:RU) then  {Change RU Rx Ry Dx Dy X}        % Avance dans RU et save les valeurs du rotate
	    end
	 end
	 fun{ChangeForPu Pu Time Check}
	    case Pu of nil then nil
	    [] primitive(kind:K) then
	       {Browse Time}
	       if Check == true then {Create Pu 0.0 0.0 0.0 0.0 0.0 Time}
	       else
	       {Create Pu 0.0 0.0 0.0 0.0 0.0 0.0}
	       end
	    [] translate(dx:Timer dy:Timer2 1:PU) then {ChangeForPu PU Time true}
	    end
	 end

         %Calcule la Formule (Data) passée en paramètre
	 declare
	 fun{Calculate Data Time}
	    case Data of time then Time
	    [] plus(1:X 2:Y) then
	       {Calculate X Time} + {Calculate Y Time}
	    [] minus(1:X 2:Y) then
	       {Calculate X Time} - {Calculate Y Time}
	    [] mult(1:X 2:Y) then
	       {Calculate X Time} * {Calculate Y Time}
	    []'div'(1:X 2:Y) then
	       {Calculate X Time} / {Calculate Y Time}
	    [] sin(1:X) then
	       case X of time then
		  {Float.sin Time}
	       else
		  {Float.sin {Calculate X Time}}  
	       end
	    [] cos(1:X) then
	       case X of time then
		  {Float.cos Time}
	       else
		  {Float.cos {Calculate X Time}}  
	       end
	   [] tan(1:X) then
	       case X of time then
		  {Float.tan Time}
	       else
		  {Float.tan {Calculate X Time}}  
	       end
	    else
	       Data
	    end
	 end
	 %{Browse {Calculate plus(1:6.0 2:'div'(1:0.84 2:sin(1:time))) 18.0}}
	 %{Browse {Calculate sin(1:plus(1:2.0 2:time)) 1.0}}
	 {Browse {Calculate plus(1:cos(1:tan(1:0.00000001)) 2:mult(1:1000.0 2:mult(1:10000.0 2:mult(1:10000000.0 2:100000000.0)))) 1.0}}  
	       
	 
	 %Cree un RUI a l'aide d'une primitive et des coefficient en X et Y.
	 %%TODO changer la definition des points
	 
	 fun{Create Ru Rx Ry Dx Dy Theta Time}
	    
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
	       elseif K== water then
		  realitem(kind:water
			   p1:pt(x:((Rx*0.0)+Dx)*{Cos Theta}+((Ry*0.0)+Dy)*{Sin Theta} y:((Ry*0.0)+Dy)*{Cos Theta}-((Rx*0.0)+Dx)*{Sin Theta})
			   p2:pt(x:((Rx*1.0)+Dx)*{Cos Theta}+((Ry*0.0)+Dy)*{Sin Theta} y:((Ry*0.0)+Dy)*{Cos Theta}-((Rx*1.0)+Dx)*{Sin Theta})
			   p3:pt(x:((Rx*1.0)+Dx)*{Cos Theta}+((Ry*1.0)+Dy)*{Sin Theta} y:((Ry*1.0)+Dy)*{Cos Theta}-((Rx*1.0)+Dx)*{Sin Theta})
			   p4:pt(x:((Rx*0.0)+Dx)*{Cos Theta}+((Ry*1.0)+Dy)*{Sin Theta} y:((Ry*1.0)+Dy)*{Cos Theta}-((Rx*0.0)+Dx)*{Sin Theta})
			  )
	       elseif K==pokemon then
		  pokeitem(kind:pokemon position:pt(x:150.0+Time y:150.0+Time))
	       elseif K==pokestop then
		  pokeitem(kind:pokestop position:pt(x:250.0+Time y:250.0+Time))
	       elseif K==arena then
		  pokeitem(kind:arena position:pt(x:350.0+Time y:350.0+Time))
	       else
		  yolo	  
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

   
   