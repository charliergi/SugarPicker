declare
fun{CheckMap Map}
   local CheckRu CheckPu CheckList CheckFormule in
      fun{CheckList Rp Case}
	 case Rp of nil then true
	 [] X|Y then
	    if Case==ru then
	       if {CheckRu [X]} then {CheckList Y Case}
	       else false
	       end
	    elseif Case==pu then
	       if {CheckPu [X]} then {CheckList Y Case}
	       else false
	       end
	    else false
	    end
	 else false
	 end
      end	  
      fun{CheckRu Ru}
	 case Ru of nil then  true
	 [] X|Y then 
	    case X of primitive(kind:K) then
	       if K== road then {CheckRu Y}
	       elseif K== water then {CheckRu Y}
	       elseif K== building then  {CheckRu Y}
	       else false
	       end
	    [] scale(rx:Rx ry:Ry 1:Ru) then
	       if {CheckFormule Rx false} andthen {CheckFormule Ry false} then {CheckRu Ru}
	       else false
	       end
	    [] translate(dx:Dx dy:Dy 1:Ru ) then
	       if {CheckFormule Dx false} andthen {CheckFormule Dy false} then {CheckRu Ru}
	       else false
	       end
	    [] rotate(angle:Theta 1:Ru) then
	       if {CheckFormule Theta false} then {CheckRu Ru}
	       else false
	       end
	    else false
	    end
	 else false
	 end
      end
      
      fun {CheckPu Pu}
	 case Pu of nil then true
	 [] X|Y then
	    case X of primitive(kind:K) then
	       if K == pokemon then {CheckPu Y}
	       elseif K== pokestop then {CheckPu Y}
	       elseif K==arena then {CheckPu Y}
	       else false
	       end
	    []translate(dx:Dx dy:Dy 1:Pu) then
	       if {CheckFormule Dy true} andthen {CheckFormule Dx true} then {CheckPu Pu}
	       else false
	       end
	    [] spawn(tmin:X tmax:Y 1:Pu) then
	       if {Int.is X} andthen {Int.is Y} then true
	       else false
	       end
	    else false
	    end
	 else false
	 end
      end
      fun{CheckFormule F flag}
	 if {Float.is F} then true
	 else
	    case F of time then
	       if flag then true
	       else false
	    [] plus(X Y) then
	       if {CheckFormule X} andthen {CheckFormule Y} then true
	       else false
	       end
	    [] minus(X Y) then
	       if {CheckFormule X} andthen {CheckFormule Y} then true
	       else false
	       end
	    [] mult(X Y) then
	       if {CheckFormule X} andthen {CheckFormule Y} then true
	       else false
	       end
	    [] 'div'(X Y) then
	       if {CheckFormule X} andthen {CheckFormule Y} then true
	       else false
	       end
	    [] sin(X) then
	       if {CheckFormule X} then true
	       else false
	       end
	    [] cos(X) then
	       if {CheckFormule X} then true
	       else false
	       end
	    [] tan(X) then
	       if {CheckFormule X} then true
	       else false
	       end
	    [] exp(X) then
	       if {CheckFormule X} then true
	       else false
	       end
	    [] log(X) then
	       if {CheckFormule X} then true
	       else false
	       end
	    [] neg(X) then
	       if {CheckFormule X} then true
	       else false
	       end
	    [] ite(X Y Z) then
	       if {CheckFormule X} andthen {CheckFormule Y} andthen {CheckFormule Z} then true
	       else false
	       end
	    [] eq(X Y) then
	       if {CheckFormule X} andthen {CheckFormule Y} then true
	       else false
	       end
	    [] ne(X Y) then
	       if {CheckFormule X} andthen {CheckFormule Y} then true
	       else false
	       end
	    [] lt(X Y) then
	       if {CheckFormule X} andthen {CheckFormule Y} then true
	       else false
	       end
	    [] le(X Y) then
	       if {CheckFormule X} andthen {CheckFormule Y} then true
	       else false
	       end
	    [] gt(X Y) then
	       if {CheckFormule X} andthen {CheckFormule Y} then true
	       else false
	       end
	    [] ge(X Y) then
	       if {CheckFormule X} andthen {CheckFormule Y} then true
	       else false
	       end
	    else false
	    end
	 end
      end
      case Map of nil then false
      [] map(ru:Ru pu:Pu) then
	    if {CheckList Ru ru} andthen {CheckList Pu pu} then true
	    else false
	    end
      else false
      end	 
   end
end
Map =  map(ru:[translate(dx:ge(time 10.0) dy:10.0 1:[scale(rx:10.0 ry:10.0 1:[primitive(kind:road) translate(dx:10.0 dy:10.0 1:[translate(dx:10.0 dy:10.0 1:[primitive(kind:water)]) primitive(kind:building)])])])] pu:[translate(dx:mult(10.0 time) dy:100.0 1:[primitive(kind:pokemon) primitive(kind:arena) primitive(kind:pokestop)])])

{Browse {CheckMap Map}}