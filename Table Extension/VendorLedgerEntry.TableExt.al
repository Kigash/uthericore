tableextension 50018 VendorLedgerEntryExt extends "Vendor Ledger Entry"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "Transaction Type Code"; Code[20])
        {
            TableRelation = "Transaction Type";

        }

    }

    var
        myInt: Integer;
}