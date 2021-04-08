function f=fit(x,y,xx)
fit=polyfit(x,y,4);
f=round(polyval(fit,xx));
end