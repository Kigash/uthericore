tableextension 50012 BankAccLedgerEntryExt extends "Bank Account Ledger Entry"
{
    fields
    {
        field(50000; "Posting Time"; Time)
        {

        }
        field(50001; "Transaction Type Code"; Code[20])
        {
            TableRelation = "Transaction Type";

        }
        field(50002; "Running Balance"; Decimal)
        {

        }
    }

    var
        myInt: Integer;
}