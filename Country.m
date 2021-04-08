classdef Country
    
    properties(Access = private)
        Data            %dane  o przypadkach zarazenia i smierciah
        Name            %nazwa kraju
        ShortName       %skrót kraju
        PredictionData  %przewidywane dane
    end
    
    methods
        %konstruktor
        function country = Country(data,name,shortname)
            %sprawdzanie czy struktura
            if(~isstruct(data))
                country.Data=[];
                error('Dane to nie strutura');
            end
            %sprawdzanie czy typu cell
              if(~iscell(name))
                error('name to nie komorka');
              end
               if(~iscell(name))
                error('shortname to nie komorka');
              end
             
            country.Data=data;
            country.Name=name;
            country.ShortName=shortname;
            country.PredictionData=struct([]);
        end
        
        function value = getShortName(obj)
            value=obj.ShortName;
        end
        function value = getData(obj)
            value=obj.Data;
        end
        %pobieranie danych z klasy kraju
        function [DataX,DataY]=getdata(country,Dataselect)
            size=length(country.Data(1,:));
            DataX=strings(size:1);
            DataY=zeros(size:1);
            
            for i=1:size
                DataX(i)= country.Data(1,i).Date_reported;
                DataY(i)=country.Data(1,i).(Dataselect);
            end
            
            
        end
        
    end
    
    
end