A=imread("C:\Users\omerp\Documents\לימודים\שנה ג\מעבדה ג\פלורסנציה מולקולרית\תמונוץ\חלק ב רודמין ב\Rohdamine_b_1.jpeg");
A1=im2double(A);
figure
imagesc(A1(:,:,1))
%%
lower = 30;
upper = 500;
maxrange = 900;
height =62;
size = 10*(upper-lower)./maxrange;

Av=A1(height,lower:upper,1);
x=linspace(0,size,length(Av));
plot(x,Av)



Avl=log(Av);
scatter(x,Avl)
xlabel('x[cm]')
ylabel('ln(Power) [AU]')
title('ln(power) as function of distance c=0.1M')
grid minor
P = polyfit(x,Avl,1);
yfit = P(1)*x+P(2);
hold on;
plot(x,yfit,'r-.');

output = P(1)

%Intenstiy = transpose(Av);
%X = transpose(x);
