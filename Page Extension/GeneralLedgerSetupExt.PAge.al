pageextension 50432 "General Ledger Setup Ext" extends "General Ledger Setup"
{
    layout
    {
        addafter("Show Amounts")
        {
            field("Disallow Own Approver"; Rec."Disallow Own Approver")
            {
                ApplicationArea = All;
            }
            field("Current Bugdet"; Rec."Current Bugdet")
            {
                ApplicationArea = All;
            }
            field("Current Budget Start Date"; Rec."Current Budget Start Date")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Current Budget End Date"; Rec."Current Budget End Date")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
        modify("Global Dimension 1 Code")
        {
            Editable = true;
        }
        modify("Global Dimension 2 Code")
        {
            Editable = true;
        }
    }
}