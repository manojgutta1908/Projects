select * from Loans;
/*
•	Split the dataset into multiple relational tables:
o	Customers(CustomerID, Name, Gender, Income, State)
o	Loans(LoanID, CustomerID, LoanAmount, Term, InterestRate, LoanStatus, DateIssued)
o	Payments(PaymentID, LoanID, PaymentDate, PaymentAmount)
o	CreditScores(CustomerID, ScoreDate, CreditScore) */


create table Customers (
	  ID varchar(20) Primary Key
	, Child_Count int
	, Education_Status int
	, Maritial_Status int
	, Age_Days int
	, ID_Days int
	, Mobile_Tag int
	, Homephone_Tag int
	, Client_Family_Members int
	, Cleint_City_Rating int
	, Client_Permanent_Match_Tag int
	, Social_Circle_Default float
	, Phone_Change int
	, Foreign Key (Education_Status) References Education(Education_Id)
	, Foreign Key (Maritial_Status) References Maritial_Status(Maritial_ID) );

Insert into Customers (		
	  ID 
	, Child_Count 
	, Age_Days 
	, Education_Status 
	, Maritial_Status
	, ID_Days 
	, Mobile_Tag 
	, Homephone_Tag
	, Client_Family_Members 
	, Cleint_City_Rating
	, Client_Permanent_Match_Tag 
	, Social_Circle_Default 
	, Phone_Change )
select L.ID 
	, L.Child_Count 
	, L.Age_Days 
	, E.Education_ID
	, M.Maritial_ID
	, L.ID_Days 
	, L.Mobile_Tag 
	, L.Homephone_Tag
	, L.Client_Family_Members 
	, L.Cleint_City_Rating
	, L.Client_Permanent_Match_Tag 
	, L.Social_Circle_Default 
	, L.Phone_Change
from Loans as L
Left join Maritial_Status as M 
On L.Client_Marital_Status = M.Client_Maritial_Status
Left join Education as E
on L.Client_Education = E.Client_Education
where L.ID is Not Null and 
L.Client_Marital_Status is Not Null and 
L.Client_Education is Not Null; 




Create table Client_Income (
		  ID varchar(20) Primary Key
		, Client_Income int
		, Client_Income_Status int
		, Client_Occupation_Status int
		, Client_Contact_Work_Tag int
	    , Organization_ID int
		, Employed_Days int
		, WorkPhone_Working int
		, FOREIGN KEY (Client_Income_Status) References Income_Type(Income_Type_ID) 
		, Foreign Key (Organization_ID) References Organization_Type(Organization_Type_ID)
		, Foreign Key ( Client_Occupation_Status) References Occupation(Occupation_Type_ID)
		); 

Insert into Client_Income( 
		  ID 
		, Client_Income 
		, Client_Income_Status 
		, Client_Occupation_Status 
		, Client_Contact_Work_Tag 
	    , Organization_ID 
		, Employed_Days 
		, WorkPhone_Working) 
Select L.ID 
		, L.Client_Income 
		, I.Income_Type_ID
		, O.Occupation_Type_ID
		, L.Client_Contact_Work_Tag 
	    , OT.Organization_Type_ID
		, L.Employed_Days 
		, L.WorkPhone_Working
from Loans as L
left join Income_Type as I
on L.Client_Income_Type = I.Client_Income_Type
left join Occupation as O
on L.Client_Occupation = O.Client_Occupation
left join Organization_Type as OT
on L.Type_Organization = OT.Type_Organization
where ID is Not Null; 




Create table Cus_Properties (
		ID varchar(20) Primary Key
		, Car_Owned int
	    , Bike_Owned int
	    , House_Own int
		, House_Own_Type int
		, Own_House_Age int
		, Population_Region_Relative float 
		, Registration_Days int
		, Foreign Key (House_Own_Type) References House_Type(House_Type_ID) ); 


Insert into Cus_Properties( 
		  ID 
		, Car_Owned 
	    , Bike_Owned 
	    , House_Own 
		, House_Own_Type 
		, Own_House_Age 
		, Population_Region_Relative 
		, Registration_Days)
Select ID 
		, L.Car_Owned 
	    , L.Bike_Owned 
	    , L.House_Own 
		, H.House_Type_ID 
		, L.Own_House_Age 
		, L.Population_Region_Relative 
		, L.Registration_Days
from Loans as L
Left join House_Type as H
on L.Client_Housing_Type = H.Client_House_Type
where L.ID is Not Null;




Create table Cus_Loans( 
          ID Varchar(20) 
		, Contract_Type_ID int
		, Accompany_ID int
		, Credit_Amount float
		, ID_Days int
		, Application_Process_Day int
		, Application_Process_Hour int
		, Foreign key (Contract_Type_ID) References Loan_Contract(Contract_Type_ID)
		, Foreign key(Accompany_ID) References Accompany(Accompany_ID));


Insert into Cus_Loans(
		  ID
		, Contract_Type_ID
		, Accompany_ID 
		, Credit_Amount
		, ID_Days 
		, Application_Process_Day 
		, Application_Process_Hour)

Select L.ID
		, LC.Contract_Type_ID
		, A.Accompany_ID 
		, L.Credit_Amount
		, L.ID_Days 
		, L.Application_Process_Day 
		, L.Application_Process_Hour
from Loans as L 
LEFT JOIN Loan_Contract AS LC
ON L.Loan_Contract_Type = LC.Loan_Contract_Type
Left join Accompany as A
on L.Accompany_Client = A.Accompany_Client 
Where L.ID is Not null and L.Loan_Contract_Type IN ('CL','RL'); 


Create table CreditScores( 
			ID Varchar(20) 
			, Credit_Bureau int
			, Score_Source_1 float
			, Score_Source_2 float
			, Score_Source_3 float
			) ;

Insert into CreditScores (
			  ID 
			, Credit_Bureau 
			, Score_Source_1
			, Score_Source_2 
			, Score_Source_3
			)  
select ID 
	, Credit_Bureau 
	, Score_Source_1
	, Score_Source_2
	, Score_Source_3
from Loans
where ID is Not Null;

Create table Payments(
	ID Varchar(20)
	, Loan_Annuity float);

Insert into Payments( 
		ID
		, Loan_Annuity)
Select ID
	, Loan_Annuity
from Loans
where ID is Not Null;




-- LookUp Tables 

create table Maritial_Status ( 
			  Maritial_ID int Identity(1,1) Primary Key
			, Client_Maritial_Status varchar(5));
create table Education (
			Education_Id int Identity(1,1) Primary Key
			, Client_Education Varchar(50) );

Create table Income_Type(
	      Income_Type_ID int identity(1,1) Primary Key
		, Client_Income_Type Varchar(100));

Create table Occupation(
	      Occupation_Type_ID int identity(1,1) Primary Key
		, Client_Occupation Varchar(100));

Create table Organization_Type(
		Organization_Type_ID int identity(1,1) Primary Key
		, Type_Organization Varchar(100));


Delete Organization_Type

Create table House_Type (
		House_Type_ID int identity(1,1) Primary Key
		, Client_House_Type varchar(50) );

create table Loan_Contract (
		Contract_Type_ID int identity(1,1) Primary Key
		, Loan_Contract_Type NVarchar(10)); 


create table Accompany (
	   	  Accompany_ID int identity(1,1) Primary Key
		, Accompany_Client Varchar(20)); 

----------------------------------------		



Insert into Maritial_Status( Client_Maritial_Status) 
Select Distinct Client_Marital_Status
from Loans
where Client_Marital_Status is Not Null; 

Insert into Education(Client_Education)
Select Distinct Client_Education 
from Loans
where Client_Education is Not Null;

Insert into Organization_Type(Type_Organization )
Select Distinct Type_Organization from Loans 
where ID is Not Null;

Insert into Income_Type(Client_Income_Type)
Select Distinct  Client_Income_Type
from Loans
where Client_Income_Type is Not Null; 

Insert into Occupation(Client_Occupation)
select Distinct client_Occupation 
from Loans
where Client_Occupation is Not Null; 

Insert into House_Type(Client_House_Type)
Select Distinct Client_Housing_Type
from Loans
where Client_Housing_Type is Not Null; 

Insert into Loan_Contract(Loan_Contract_Type)
Select Distinct Loan_Contract_Type
from Loans
where Loan_Contract_Type is Not Null ; 

Insert into Accompany(Accompany_Client)
select Distinct Accompany_Client
from Loans
where Accompany_Client is Not Null; 




EXEC sp_rename 'CreditScores.Social_Source_3', 'Score_Source_3', 'COLUMN';

 

 




			

 
		









/*
Perform INNER, LEFT, and SELF JOINs to fetch insights like:
•	Customers with loans and their payment history.
•	Missed payments and current outstanding balances.
•	Comparing loan repayment patterns across different states or income groups. */

select * from Loans

-- Customers with loans and their payment history

Select  C.ID 
	, CL.Credit_Amount
	, P.Loan_Annuity
	, A.Accompany_Client
	, CS.Score_Source_1
	, CS.Score_Source_2
	, CS.Score_Source_3
from Customers as C 
Inner join Cus_Loans as CL
on C.ID = CL.ID 
left join Payments as P
on CL.ID = P.ID
left join Accompany as A
on CL.Accompany_ID = A.Accompany_ID
left join CreditScores as CS
on CL.ID = CS.ID ; 


--  current outstanding balances.

select  CL.ID
		,CL.Credit_Amount as Total_Loan
		,P.Loan_Annuity as Total_RePayment
		,(CL.Credit_Amount - IsNull (P.Loan_Annuity, 0)) as Outstanding_Balance
from Cus_Loans as CL
left join Payments as P
on CL.ID = P.ID ;

-- Comparing loan repayment patterns across income groups.

select Sum(P.Loan_Annuity) as Total_RePayment
	  , Avg(P.Loan_Annuity) as Avg_Total_RePayment
	  , Count(C.ID) as Customers
	  , I.Client_Income_Type
	  , C.Cleint_City_Rating
from Customers as C
left join Payments as P
on C.ID = P.ID
left join Client_Income as CI
on C.ID = CI.ID
left join Income_Type as I
on CI.Client_Income_Status = I.Income_Type_ID 
group by I.Client_Income_Type,C.Cleint_City_Rating
Order by Total_RePayment Desc;


-- •	Add indexes to optimize performance.

Create Index Idx_Loan_Contract_Day on Cus_Loans(Application_Process_Day); 
Create Index Idx_Loan_Contract_Hour on Cus_Loans(Application_Process_Hour); 

create Index Idx_Score 
on CreditScores(Score_Source_1); 
 
create Index Idx_Score_2 
on CreditScores(Score_Source_2);

create Index Idx_Score_3
on CreditScores(Score_Source_3);

 create Index Idx_Own_House 
 on Cus_Properties(House_Own_Type); 

 /*

 Use ROW_NUMBER(), RANK(), LAG(), LEAD(), and SUM() OVER() for:
•	Ranking customers by their total loan amount.
•	Calculating the running total of payments per loan.
•	Detecting changes in credit score over time per customer. */

Select ID
	, Total_Loans
	, DENSE_RANK () Over(Order by Total_Loans Desc) as Rank_No
from ( Select ID
			, Sum(Credit_Amount) as Total_Loans
			 from Cus_Loans 
			 group by ID) as Total_Loans;  
 

	

select * from Customers
select * from Income_Type
select * from Cus_Loans
select * from Payments
select * from CreditScores
select * from Cus_Properties
select * from Accompany
select top 2 * from Client_Income
select * from Income_Type

select * from Maritial_Status
select * from Education
select * from Organization_Type
select * from House_Type
select * from Income_Type
select * from Accompany
select * from Loan_Contract
select * from Occupation

-- Calculating the running total of payments per loan

select P.ID
	, P.Loan_Annuity
	, C.Credit_Amount
	, sum(P.Loan_Annuity) Over(Partition by C.ID Order by P.Loan_Annuity Desc) as Running_Total
from Payments as P 
join Cus_Loans as C
on P.ID = C.ID; 

/* Create a dynamic stored procedure that:
•	Accepts input parameters like @State, @MinLoanAmount, or @LoanStatus.
•	Returns a custom result set showing:
o	Average interest rates
o	Count of loans
o	Total payments
o	Delinquency rates Based on the dynamic filter inputs.
*/

select * from Cus_Loans

create Procedure Loan_Summary (
	@Credit_Amount float
	, @Loan_Contract_Type Varchar(10) ) 
	As 
Begin 
select CL.ID
, Sum(CL.Credit_Amount) as Total_Loans
, Sum(P.Loan_Annuity) as Total_RePayments
, LC.Loan_Contract_Type as Loan_Contract
from Cus_Loans as CL
join Payments as P 
on CL.ID = P.ID
join Loan_Contract as LC
on CL.Contract_Type_ID = LC.Contract_Type_ID
where CL.Credit_Amount >= @Credit_Amount
and LC.Loan_Contract_Type= @Loan_Contract_Type
group by CL.ID, LC.Loan_Contract_Type
Order by Sum(P.Loan_Annuity) Desc
End ; 


Exec Loan_Summary @Credit_Amount = 1000, @Loan_Contract_Type = 'CL';

