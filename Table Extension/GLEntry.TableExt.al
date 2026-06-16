tableextension 50020 GLEntryExt extends "G/L Entry"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "Transaction Type Code"; Code[20])
        {
            TableRelation = "Transaction Type";

        }
        field(50001; "Running Balance"; Decimal)
        {
            Caption = 'Running Balance';
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
}