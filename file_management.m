function [funStruct] = file_management()

funStruct.DownloadData=@LOCALDownloadData;
funStruct.GetCountryNames=@LOCALGetCountryNames;
funStruct.SetCountryData=@LOCALSetCountryData;
funStruct.predictdate=@LOCALpredictdate;
end
function [da]=LOCALpredictdate(numer)
for i=0:numer
 da{i+1}=datestr(datetime(date)+days(i));
end
end
function [dataStructure]=LOCALDownloadData(urlAddress, varargin)
% LOCALDownloadData funkcja pobierajaca dane ze strony Swiatowej
% Organizacji Zdrowia i zwraca w postaci tabeli
if(nargin==2)
    if(isstring(varargin{1}) | ischar(varargin{1}))
        if(strcmp(varargin{1},'-h'))
            fprintf('LOCALDownloadData funkcja pobierajaca dane ze strony');
            fprintf('Swiatowej Organizacji Zdrowia i zwraca w postaci tabeli ');
            fprintf('z danego adresu url pobiera dane Use -h option to get console help.\n')
        end
    end
end

%Try to download data
try
    dataStructure = webread(urlAddress);
catch ME
    if (strcmp(ME.identifier,'MATLAB:minrhs'))
        msg = ['Za malo argumentow.'];
        causeException = MException('MATLAB:myCode:argumentNo',msg);
        ME = addCause(ME,causeException);
    end
    if (strcmp(ME.identifier,'MATLAB:webservices:UnknownHost'))
        msg = ['Adres URL jest niepoprawny.'];
        causeException = MException('MATLAB:myCode:wrngURL',msg);
        ME = addCause(ME,causeException);
    end
    rethrow(ME)
end
%jesli dane sie sa w postaci tabeli zwracany jest b³¹d
if(~istable(dataStructure))
    dataStructure=[];
    error('Dane z podanego adresu nie sa danymi komatybilne');
end
end
%funkcja zwraca wszystkie nazwy krajow znajdujacych sie w pliku
function[All_country_names]=LOCALGetCountryNames(data)

All_country_names=unique(data.Country);
end
%funkcja zwraca obiekt typu Country
function[country]=LOCALSetCountryData(data,countryname)
if(~iscell(countryname))
    error('countryname to nie komorka');
end
indices=find(strcmp(data.Country,countryname));
name=data.Country(indices(1));
shortname=data.Country_code(indices(1));
for i=1:length(indices)
    
    data_country(i)=struct('Date_reported',string(data.Date_reported(indices(i))),'New_cases',data.New_cases(indices(i)),'Cumulative_cases',data.Cumulative_cases(indices(i)),'New_deaths',data.New_deaths(indices(i)),'Cumulative_deaths',data.Cumulative_deaths(indices(i)));
end
country=Country(data_country,name,shortname);
%  plot(datetime(data_country.Date_reported), data_country.Cumulative_cases);
end

