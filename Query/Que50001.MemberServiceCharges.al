query 50001 "Member Service Charges"
{
    Caption = 'Member Service Charges';
    QueryType = Normal;

    elements
    {
        dataitem(TellerLine; "Teller Transaction Line")
        {
            column(MemberNo; "Member No.")
            {
            }
            column(Transaction_Charge; "Transaction Charge")
            {
                Method = Sum;
            }
        }
    }

    trigger OnBeforeOpen()
    begin

    end;
}
