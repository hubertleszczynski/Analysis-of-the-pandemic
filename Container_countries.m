classdef Container_countries
    
    properties
        container       %kontener przechowywujacy obiekty typu kraj
    end
    
    methods
        function obj = setcontainer(obj,container)
            obj.container=container;
        end
        %konstruktor
        function container_countries = Container_countries()
          container_countries.container=struct([]);
        end
        %funkcja do dodawania nowego obiektu do kontenera
        function [container] = Add(container_countries,country)
            if(~isa(country,'Country'))
                
                error('To nie obiekt typu Country');
            end
            if(isempty(container_countries.container))
            container=struct(string(country.getShortName()),country);
            else
            container=setfield(container_countries.container,string(country.getShortName()),country);
            end
        end
        %funkcja do pobierania wszystkich danych z kontenera
        function [Xdata,Ydata] = getdata(container_countries,Dataselect,i)
           if(~ischar(Dataselect))
                error('Dataselect to nie char');
           end
            names=fieldnames(container_countries.container);
            
           
                [Xdata,Ydata]=container_countries.container.(names{i}).getdata(Dataselect);
                
            
        end
        %funkcja do usuwania obiektow  z konteneru
        function [container]=Remove(container_countries)

              container=struct([]);
        end
    end
    
end
