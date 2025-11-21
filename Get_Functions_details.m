

function [lb,ub,dim,fobj] = Get_Functions_details(F)


switch F
    case 'F1'
%         F1=economicgeneration;
        fobj = @economicgeneration;
        lb=0;
        ub=1;
        dim=10;
        
    case 'F2'
        fobj = @economicgeneration2;
        lb=0;
        ub=1;
        dim=10;
        
      case 'F3'
        fobj = @economicgeneration3;
        lb=0;
        ub=1;
        dim=10;
        
    case 'F4'
        fobj =  @economicemission;
        lb=0;
        ub=1;
        dim=10;
        
        case 'F5'
        fobj =  @economicemission2;
        lb=0;
        ub=1;
        dim=10;
        
       case 'F6'
        fobj = @economicemission3;
        lb=0;
        ub=1;
        dim=10;  
             
end

end

