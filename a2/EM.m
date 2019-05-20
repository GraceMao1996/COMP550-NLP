pi=[1/3 1/6 1/3 1/6];
A = [1/6 3/6 1/6 1/6;1/10 3/10 2/5 1/5;1/9 5/9 2/9 1/9;1/4 1/4 1/4 1/4];
B = [3/8 1/8 1/8 1/8 1/8 1/8; 
    5/14 1/14 3/14 3/14 1/14 1/14;
    1/12 7/12 1/12 1/12 1/12 1/12;
    1/7 1/7 1/7 1/7 2/7 1/7];
O = [6 2 3 5];
T = 4;%number of the word in the new sentence
a = zeros(4,T);



for i=(1:4)
    a(i,1) = pi(i)*B(i,O(1));
end
for t=(2:T)
    for j = (1:4)
        for i = (1:4)
            a(j,t) = a(j,t)+(a(i,t-1)*A(i,j)*B(j,O(t)));
        end
    end
end
p = 0;
for j = (1:4)
    p = p + a(j,T);
end

% disp(a);
% disp(p);


b = zeros(4,T);
% for k =(1:T-1)
for i=(1:4)
    b(i,T) = 1;
end
for t=(1:T-1)
    for i = (1:4)
        for j = (1:4)
            b(i,T-t) = b(i,T-t)+(b(j,T-t+1)*A(i,j)*B(j,O(T-t+1)));
        end
    end
end
% end
q=0;
for j = (1:4)
     q= q +(pi(j)*B(j,O(1))*b(j,1));
end

% disp(b);
% disp(q);
%disp(1);

r= zeros(4,T);
for t = (1:T)
    for i = (1:4)
        r(i,t) = a(i,t)*b(i,t)/p;
    end
end


e = zeros(4,4,T-1);
for t = (1:T-1)
    for i = (1:4)
        for j = (1:4)
            e(i,j,t) = a(i,t)*A(i,j)*B(j,O(t+1))*b(j,t+1)/p;
        end
    end
end
pi2 = zeros(1,4);
for i=(1:4)
    pi2(i) = pi2(i)+r(i,1);
end

disp(sum(pi2(:)))
% 
u = zeros(4,4);
d = zeros(4,4);
for i=(1:4)
   for j = (1:4)
        
        for t =(1:T-1)
            u(i,j) = u(i,j)+e(i,j,t);
            d(i,j) = d(i,j)+r(i,t);
        end 
        
    end
end
% 
s = zeros(4,6);
x = zeros(4,6);
for w=(1:6)
    for i=(1:4)
        for t =(1:T)
            if O(t)==w
                s(i,w) = s(i,w)+r(i,t);
            end
            x(i,w) = x(i,w)+ r(i,t);
        end   
      
    end
end
% disp("u:")
% disp(u)
% disp("d:")
% disp(d)
% 
% disp("s:")
% disp(s)
% disp("x:")
% disp(x)
% 
% disp("pi:")
% disp(pi2);
% format rat;

%sentence 2
O = [1 1 2 2];
T = 4;%number of the word in the new sentence
a = zeros(4,T);



for i=(1:4)
    a(i,1) = pi(i)*B(i,O(1));
end
for t=(2:T)
    for j = (1:4)
        for i = (1:4)
            a(j,t) = a(j,t)+(a(i,t-1)*A(i,j)*B(j,O(t)));
        end
    end
end
p = 0;
for j = (1:4)
    p = p + a(j,T);
end

% disp(a);
% disp(p);


b = zeros(4,T);

for i=(1:4)
    b(i,T) = 1;
end
for t=(1:T-1)
    for i = (1:4)
        for j = (1:4)
            b(i,T-t) = b(i,T-t)+(b(j,T-t+1)*A(i,j)*B(j,O(T-t+1)));
        end
    end
end
q=0;
for j = (1:4)
     q= q +(pi(j)*B(j,O(1))*b(j,1));
end

% disp(b);
% disp(q);
%disp(1);

r= zeros(4,T);
for t = (1:T)
    for i = (1:4)
        r(i,t) = a(i,t)*b(i,t)/p;
    end
end

e = zeros(4,4,T-1);
for t = (1:T-1)
    for i = (1:4)
        for j = (1:4)
            e(i,j,t) = a(i,t)*A(i,j)*B(j,O(t+1))*b(j,t+1)/p;
        end
    end
end


for i=(1:4)
    pi2(i) =pi2(i)+ r(i,1);
end

disp(sum(pi2(:)))
% 
for i=(1:4)
   for j = (1:4)
        
        for t =(1:T-1)
            u(i,j) = u(i,j)+e(i,j,t);
            d(i,j) = d(i,j)+r(i,t);
        end 
        
    end
end
% 
for w=(1:6)
    for i=(1:4)
        for t =(1:T)
            if O(t)==w
                s(i,w) = s(i,w)+r(i,t);
            end
            x(i,w) = x(i,w)+ r(i,t);
        end   
    end
end

%sencence 3
O = [1 1 2 3 2 3];
T = 6;%number of the word in the new sentence
a = zeros(4,T);



for i=(1:4)
    a(i,1) = pi(i)*B(i,O(1));
end
for t=(2:T)
    for j = (1:4)
        for i = (1:4)
            a(j,t) = a(j,t)+(a(i,t-1)*A(i,j)*B(j,O(t)));
        end
    end
end
p = 0;
for j = (1:4)
    p = p + a(j,T);
end

% disp(a);
% disp(p);


b = zeros(4,T);

for i=(1:4)
    b(i,T) = 1;
end
for t=(1:T-1)
    for i = (1:4)
        for j = (1:4)
            b(i,T-t) = b(i,T-t)+(b(j,T-t+1).*A(i,j).*B(j,O(T-t+1)));
        end
    end
end
q=0;
for j = (1:4)
     q= q +(pi(j)*B(j,O(1))*b(j,1));
end

% disp(b);
% disp(q);
%disp(1);

r= zeros(4,T);
for t = (1:T)
    for i = (1:4)
        r(i,t) = a(i,t)*b(i,t)/p;
    end
end


e= zeros(4,4,T-1);
for t = (1:T-1)
    for i = (1:4)
        for j = (1:4)
            e(i,j,t) = a(i,t)*A(i,j)*B(j,O(t+1))*b(j,t+1)/p;
        end
    end
end


for i=(1:4)
    pi2(i) =pi2(i)+ r(i,1);
end

disp(sum(pi2(:)))
% 
for i=(1:4)
   for j = (1:4)
        
        for t =(1:T-1)
            u(i,j) = u(i,j)+e(i,j,t);
            d(i,j) = d(i,j)+r(i,t);
        end 
        
    end
end
% 
for w=(1:6)
    for i=(1:4)
        for t =(1:T)
            if O(t)==w
                s(i,w) = s(i,w)+r(i,t);
            end
            x(i,w) = x(i,w)+ r(i,t);
        end   
    end
end



%sencence 4
O = [2 1 4];
T = 3;%number of the word in the new sentence
a = zeros(4,T);



for i=(1:4)
    a(i,1) = pi(i)*B(i,O(1));
end
for t=(2:T)
    for j = (1:4)
        for i = (1:4)
            a(j,t) = a(j,t)+(a(i,t-1).*A(i,j).*B(j,O(t)));
        end
    end
end

p = 0;
for j = (1:4)
    p = p + a(j,T);
end

b = zeros(4,T);

for i=(1:4)
    b(i,T) = 1;
end
for t=(1:T-1)
    for i = (1:4)
        for j = (1:4)
            b(i,T-t) = b(i,T-t)+(b(j,T-t+1).*A(i,j).*B(j,O(T-t+1)));
        end
    end
end


r= zeros(4,T);
for t = (1:T)
    for i = (1:4)
        r(i,t) = a(i,t)*b(i,t)/p;
    end
end


e= zeros(4,4,T-1);
for t = (1:T-1)
    for i = (1:4)
        for j = (1:4)
            e(i,j,t) = a(i,t)*A(i,j)*B(j,O(t+1))*b(j,t+1)/p;
        end
    end
end

for i=(1:4)
    pi2(i) =pi2(i)+ r(i,1);
end

disp(sum(pi2(:)))
% 
for i=(1:4)
   for j = (1:4)
        
        for t =(1:T-1)
            u(i,j) = u(i,j)+e(i,j,t);
            d(i,j) = d(i,j)+r(i,t);
        end 
        
    end
end
% 
for w=(1:6)
    for i=(1:4)
        for t =(1:T)
            if O(t)==w
                s(i,w) = s(i,w)+r(i,t);
            end
            x(i,w) = x(i,w)+ r(i,t);
        end   
    end
end

%sentence 5
O = [2 4 1 5];
T = 4;%number of the word in the new sentence
a = zeros(4,T);



for i=(1:4)
    a(i,1) = pi(i)*B(i,O(1));
end
for t=(2:T)
    for j = (1:4)
        for i = (1:4)
            a(j,t) = a(j,t)+(a(i,t-1).*A(i,j).*B(j,O(t)));
        end
    end
end
p = 0;
for j = (1:4)
    p = p + a(j,T);
end


b = zeros(4,T);

for i=(1:4)
    b(i,T) = 1;
end
for t=(1:T-1)
    for i = (1:4)
        for j = (1:4)
            b(i,T-t) = b(i,T-t)+(b(j,T-t+1).*A(i,j).*B(j,O(T-t+1)));
        end
    end
end


r= zeros(4,T);
for t = (1:T)
    for i = (1:4)
        r(i,t) = a(i,t)*b(i,t)/p;
    end
end


e= zeros(4,4,T-1);
for t = (1:T-1)
    for i = (1:4)
        for j = (1:4)
            e(i,j,t) = a(i,t)*A(i,j)*B(j,O(t+1))*b(j,t+1)/p;
        end
    end
end

for i=(1:4)
    pi2(i) =pi2(i)+ r(i,1);
end

disp(sum(pi2(:)))
% 
for i=(1:4)
   for j = (1:4)
        
        for t =(1:T-1)
            u(i,j) = u(i,j)+e(i,j,t);
            d(i,j) = d(i,j)+r(i,t);
        end 
        
    end
end
% 
for w=(1:6)
    for i=(1:4)
        for t =(1:T)
            if O(t)==w
                s(i,w) = s(i,w)+r(i,t);
            end
            x(i,w) = x(i,w)+ r(i,t);
        end   
    end
end

%sentence 6
O = [1 2 5];
T = 3;%number of the word in the new sentence
a = zeros(4,T);



for i=(1:4)
    a(i,1) = pi(i)*B(i,O(1));
end
for t=(2:T)
    for j = (1:4)
        for i = (1:4)
            a(j,t) = a(j,t)+(a(i,t-1).*A(i,j).*B(j,O(t)));
        end
    end
end


p = 0;
for j = (1:4)
    p = p + a(j,T);
end
b = zeros(4,T);

for i=(1:4)
    b(i,T) = 1;
end
for t=(1:T-1)
    for i = (1:4)
        for j = (1:4)
            b(i,T-t) = b(i,T-t)+(b(j,T-t+1).*A(i,j).*B(j,O(T-t+1)));
        end
    end
end


r= zeros(4,T);
for t = (1:T)
    for i = (1:4)
        r(i,t) = a(i,t)*b(i,t)/p;
    end
end


e= zeros(4,4,T-1);
for t = (1:T-1)
    for i = (1:4)
        for j = (1:4)
            e(i,j,t) = a(i,t)*A(i,j)*B(j,O(t+1))*b(j,t+1)/p;
        end
    end
end

for i=(1:4)
    pi2(i) =pi2(i)+ r(i,1);
end
% 
for i=(1:4)
   for j = (1:4)
        
        for t =(1:T-1)
            u(i,j) = u(i,j)+e(i,j,t);
            d(i,j) = d(i,j)+r(i,t);
        end 
        
    end
end
% 
for w=(1:6)
    for i=(1:4)
        for t =(1:T)
            if O(t)==w
                s(i,w) = s(i,w)+r(i,t);
            end
            x(i,w) = x(i,w)+ r(i,t);
        end   
    end
end

%sentence 7
O = [2 4 6];
T = 3;%number of the word in the new sentence
a = zeros(4,T);



for i=(1:4)
    a(i,1) = pi(i)*B(i,O(1));
end
for t=(2:T)
    for j = (1:4)
        for i = (1:4)
            a(j,t) = a(j,t)+(a(i,t-1).*A(i,j).*B(j,O(t)));
        end
    end
end
disp(a)

p = 0;
for j = (1:4)
    p = p + a(j,T);
end

b = zeros(4,T);

for i=(1:4)
    b(i,T) = 1;
end
for t=(1:T-1)
    for i = (1:4)
        for j = (1:4)
            b(i,T-t) = b(i,T-t)+(b(j,T-t+1).*A(i,j).*B(j,O(T-t+1)));
        end
    end
end

disp(b);
r= zeros(4,T);
for t = (1:T)
    for i = (1:4)
        r(i,t) = a(i,t)*b(i,t)/p;
    end
end
disp(r)

e= zeros(4,4,T-1);
for t = (1:T-1)
    for i = (1:4)
        for j = (1:4)
            e(i,j,t) = a(i,t)*A(i,j)*B(j,O(t+1))*b(j,t+1)/p;
        end
    end
end

for i=(1:4)
    pi2(i) =pi2(i)+ r(i,1);
end
% 
disp(sum(pi2(:)))
for i=(1:4)
   for j = (1:4)
        
        for t =(1:T-1)
            u(i,j) = u(i,j)+e(i,j,t);
            d(i,j) = d(i,j)+r(i,t);
        end 
        
    end
end
% 
for w=(1:6)
    for i=(1:4)
        for t =(1:T)
            if O(t)==w
                s(i,w) = s(i,w)+r(i,t);
            end
            x(i,w) = x(i,w)+ r(i,t);
        end   
    end
end

for i=(1:4)
    for j =(1:4)
        A2(i,j)=u(i,j)/d(i,j);
    end
end

for w=(1:6)
    for i=(1:4)
        B2(i,w)=s(i,w)/x(i,w);
    end
end

disp("A:")
disp(A2)
disp("B:")
disp(B2)
disp("pi:")
disp(pi2/7)
disp(sum(pi2(:))/7);
