table 50030 "Cashier Transaction Entries"
{
    Caption = 'Cashier Transaction Entries';
    DataClassification = ToBeClassified;
    DrillDownPageID = "Cashier Transaction Entries";
    LookupPageID = "Cashier Transaction Entries";

    fields
    {
        field(1; "Entry No"; Integer)
        {
            Caption = 'Entry No';
            DataClassification = ToBeClassified;
        }
        field(2; "Document No"; Code[50])
        {
            Caption = 'Document No';
            DataClassification = ToBeClassified;
        }
        field(3; "Cashier No"; Code[50])
        {
            Caption = 'Cashier No';
            DataClassification = ToBeClassified;
        }
        field(4; "Treasury No"; Code[50])
        {
            Caption = 'Treasury No';
            DataClassification = ToBeClassified;
        }
        field(5; "Member No"; Code[50])
        {
            Caption = 'Member No';
            DataClassification = ToBeClassified;
        }
        field(6; Description; Text[200])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(7; "Debit Amount"; Decimal)
        {
            Caption = 'Debit Amount';
            DataClassification = ToBeClassified;
        }
        field(8; "Credit Amount"; Decimal)
        {
            Caption = 'Credit Amount';
            DataClassification = ToBeClassified;
        }
        field(9; "Transaction Type"; Option)
        {
            OptionCaption = 'Deposit,Cash Withdrawal,Transfer From Treasury,Transfer To Treasury';
            OptionMembers = Deposit,"Cash Withdrawal","Transfer From Treasury","Transfer To Treasury";
        }
        field(10; "Running Balance"; Decimal)
        {
            Caption = 'Running Balance';
            DataClassification = ToBeClassified;
        }
        field(11; "Posting Date"; Date)
        { }
        field(12; "User ID"; Code[50])
        { }
        field(13; Amount; Decimal)
        { }
    }
    keys
    {
        key(PK; "Entry No")
        {
            Clustered = true;
        }
    }
}
