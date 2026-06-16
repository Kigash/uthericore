query 50000 "MemberBalancesSummary"
{
    Caption = 'Member Balances Summary';
    QueryType = Normal;


    elements
    {
        dataitem(Vendor; Vendor)
        {
            column(MemberNo; "Member No.")
            {
            }
            column(AccountType; "Account Type")
            {
            }
            column(Balance; Balance)
            {
                Method = Sum;
            }
        }
    }


    trigger OnBeforeOpen()
    begin

    end;
}


