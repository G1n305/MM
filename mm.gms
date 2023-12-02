Set i /1*8/;
Set j /1*5/;
Set s /1*8/; 

Parameter b(j)    pre-order cost /1*5 30/;
Parameter l(i)    cost to satisfy demand /1*8 70/;
Parameter q(i)    selling price /1*8 50/;
Parameter r(j)    salvage value/1*5 10/;
Parameter A(i,j)  units of part j to produce a unit of product i;

* Assign random values to A
A(i,j) = uniform(1, 5);

Scalar p_s /0.5/;

Table D(s,i) demand scenarios
       1 2 3 4 5 6 7 8
   1   6 3 7 3 8 5 8 5
   2   6 2 4 3 4 3 4 5;

Variables
    x(j)    
    y(j,s)  
    z(i,s)  
    Z ;
Positive Variables x, y, z;


Equations
    cost    
    balance(j,s)
    product(i,s);

cost ..    Z =e= sum((j,s), p_s * (b(j)*x(j) + r(j)*y(j,s))) - sum((i,s), p_s * q(i)*z(i,s));

balance(j,s) ..   y(j,s) =e= x(j) - sum(i, A(i,j) * z(i,s));

product(i,s) ..      z(i,s) =l= D(s,i);

* Define the model and solve
Model two_stage /all/;
Solve two_stage using MIP minimizing Z;

