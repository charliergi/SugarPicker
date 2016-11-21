declare
fun{Create Ru Rx Ry Dx Dy }
   case Ru of nil then nil
   [] primitive(kind:K) then
      if K == road then
	 realitem(kind:road p1:pt(x:Rx*(0.0+Dx) y:Ry*(0.0+Dy)) p2:pt(x:Rx*(1.0+Dx) y:Ry*(0.0+Dy)))
      elseif K == building then
	 realitem(kind:building p1:pt(x:Rx*(0.0+Dx) y:Ry*(0.0+Dy)) p2:pt(x:Rx*(1.0+Dx) y:Ry*(0.0+Dy)) p3:pt(x:Rx*(1.0+Dx) y:Ry*(1.0+Dy)) p4:pt(x:Rx*(1.0+Dx) y:Ry*(1.0+Dy)))
      else
	 nil
      end
   end
end
declare
fun{Change Ru Rx Ry Dx Dy}  
   case Ru of nil then nil
   [] primitive(kind:K) then {Create Ru Rx Ry Dx Dy}
   [] scale(rx:RX ry:RY 1:RU) then {Change RU RX RY Dx Dy}
   [] translate(dx:DX dy:DY 1:RU) then {Change RU Rx Ry DX DY}
   else
      yolo
   end 
end

   {Browse {Change translate(dx:50.0 dy: 50.0 1:scale(rx:2.0 ry:2.0 1:primitive(kind:building))) 0.0 0.0 0.0 0.0}}