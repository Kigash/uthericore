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
        field(50002; "Member No."; Code[20])
        {
            Caption = 'Member No.';
            TableRelation = Member;
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(50003; "Member Name"; Text[100])
        {
            Caption = 'Member Name';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(50004; "Product Name"; Text[100])
        {
            Caption = 'Product Name';
            Editable = false;
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
}