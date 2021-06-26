/*3.	Use the following variable to create a new table “customers” inside the company DB.
 Use OpenXML*/
 use Company_SD
 declare @docs xml ='<customers>
              <customer FirstName="Bob" Zipcode="91126">
                     <order ID="12221">Laptop</order>
              </customer>
              <customer FirstName="Judy" Zipcode="23235">
                     <order ID="12221">Workstation</order>
              </customer>
              <customer FirstName="Howard" Zipcode="20009">
                     <order ID="3331122">Laptop</order>
              </customer>
              <customer FirstName="Mary" Zipcode="12345">
                     <order ID="555555">Server</order>
              </customer>
       </customers>'
declare @hdocs int
Exec sp_xml_preparedocument @hdocs output , @docs
select* into customers

from openxml (@hdocs , '//customer')
WITH (cusFname  varchar(10) '@FirstName' ,
      Zcode int '@Zipcode' ,
	  order_ varchar(10)'order',
	  id int 'order/@ID')

Exec sp_xml_removedocument @hdocs

select* from customers